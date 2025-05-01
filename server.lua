local QBCore = exports['qb-core']:GetCoreObject()

-- Configura tu webhook de Discord aquí
local DISCORD_WEBHOOK = 'https://discord.com/api/webhooks/1330437721587585087/jnEDaNd1gfgwQCixzEpt0vPFHj6jcxt8Ye8DR2aZ-CoX1ZALR2dIBD1nEWyBXGztlk-8'

local function sendDiscordLog(player, itemName, amount, totalPrice)
    local embed = {
        {
            ['color'] = 65280, -- Verde
            ['title'] = 'Compra en Tienda Admin',
            ['description'] = ('**Jugador:** %s\n**ID:** %s\n**Item:** %s\n**Cantidad:** %s\n**Total cash:** %s')
                :format(player.PlayerData.name or 'Desconocido', player.PlayerData.citizenid or 'N/A', itemName, amount, totalPrice),
            ['footer'] = {
                ['text'] = os.date('%Y-%m-%d %H:%M:%S')
            }
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers)
        print('[DEBUG] Discord Webhook Response:', err, text)
    end, 'POST', json.encode({embeds = embed}), {['Content-Type'] = 'application/json'})
end

RegisterCommand('admintienda', function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('adminshop:openMenu', src)
end, false)

RegisterCommand('opshop', function(source, args, rawCommand)
    local src = source
    TriggerClientEvent('adminshop:openMenu', src)
end, false)

RegisterNetEvent('adminshop:buyItem', function(itemName, amount, method)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    -- Busca el item en tu config
    local itemConfig
    for _, v in pairs(Config.Items) do
        if v.name == itemName then
            itemConfig = v
            break
        end
    end
    if not itemConfig then
        TriggerClientEvent('adminshop:feedback', src, 'Item inválido.', false)
        return
    end
    local totalPrice = itemConfig.price * amount
    local money = Player.Functions.GetMoney(method or 'cash') or 0
    if money < totalPrice then
        TriggerClientEvent('adminshop:feedback', src, 'No tienes suficiente dinero.', false)
        return
    end
    Player.Functions.RemoveMoney(method or 'cash', totalPrice)
    -- Aquí la entrega real:
    local added = exports.ox_inventory:AddItem(src, itemName, amount)
    if added then
        TriggerClientEvent('adminshop:feedback', src, 'Compra exitosa. Item entregado.', true)
    else
        TriggerClientEvent('adminshop:feedback', src, 'Error: No se pudo entregar el item.', false)
    end
    sendDiscordLog(Player, itemName, amount, totalPrice)
end) 