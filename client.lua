local QBCore = exports['qb-core']:GetCoreObject()

-- Define tus categorías y sus iconos/colores aquí
local categoryMeta = {
    Weapons = {icon = '🔫', color = 'category-weapons'},
    Vehicles = {icon = '🚗', color = 'category-vehicles'},
    Items = {icon = '🧰', color = 'category-items'},
    Clothing = {icon = '👚', color = 'category-clothing'},
    Properties = {icon = '🏠', color = 'category-properties'},
    ['Food & Drinks'] = {icon = '🍽️', color = 'category-food'},
}

RegisterNetEvent('adminshop:openMenu', function()
    SetNuiFocus(true, true)
    local Player = QBCore.Functions.GetPlayerData()
    local cash = Player.money and Player.money['cash'] or 0
    -- Organiza los items por categoría
    local categories = {}
    for _, v in pairs(Config.Items) do
        local cat = v.category or 'Items'
        if not categories[cat] then
            categories[cat] = {name = cat, icon = (categoryMeta[cat] and categoryMeta[cat].icon) or '🧰', color = (categoryMeta[cat] and categoryMeta[cat].color) or 'category-items', items = {}}
        end
        table.insert(categories[cat].items, {name = v.label, id = v.name, price = v.price})
    end
    local categoriesArr = {}
    for _, v in pairs(categories) do table.insert(categoriesArr, v) end
    print('Enviando categorías a NUI:', json.encode(categoriesArr))
    SendNUIMessage({
        action = 'openShop',
        cash = cash,
        categories = categoriesArr
    })
end)

RegisterNUICallback('buyItem', function(data, cb)
    -- data: { category, id, price, amount, method }
    TriggerServerEvent('adminshop:buyItem', data.id, tonumber(data.amount), data.method)
    cb({})
end)

RegisterNUICallback('closeShop', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'closeShop'})
    cb({})
end)

RegisterNetEvent('adminshop:feedback', function(message, success)
    SendNUIMessage({action = 'feedback', message = message, success = success})
end)