# Ghost Admin Shop

A modern, transparent, and fully-featured admin shop for FiveM, designed for QBCore/ESX servers using ox_inventory. Features a beautiful NUI dashboard, category cards, real-time server data, and Discord logging.

---

## ✨ Features

- **Modern Dashboard UI:** Transparent, glassy interface with category cards and icons.
- **Categories:** Weapons, Vehicles, Items, Clothing, Properties, Food & Drinks.
- **Real-Time Data:** Player cash, categories, and items are synced from the server.
- **Purchase Flow:** Select item, quantity, payment method (cash/bank), and buy with one click.
- **Feedback:** UI feedback for successful or failed purchases.
- **Discord Logging:** All purchases are logged to a Discord webhook.
- **Robust Item Handling:** Only valid items (from ox_inventory) are given; special logic for weapons/vehicles.
- **Responsive Design:** Looks great on all screen sizes.

---

## 🖥️ Preview

![Dashboard Preview](preview.png) <!-- Add a screenshot if available -->

---

## 🚀 Installation

1. **Download or clone this repository** into your FiveM resources folder:
   ```bash
   git clone https://github.com/yourname/ghost-admin-shop.git
   ```
2. **Add to your server.cfg:**
   ```
   ensure ghost-admin-shop
   ```
3. **Dependencies:**
   - [ox_inventory](https://github.com/overextended/ox_inventory)
   - QBCore or ESX framework

---

## ⚙️ Configuration

- Edit `config.lua` to customize categories, items, prices, and permissions.
- Ensure all item names match those in `ox_inventory/data/items.lua`.
- Set your Discord webhook in the config for purchase logging.

---

## 🕹️ Usage

- Open the admin shop via your preferred command, keybind, or admin menu integration.
- Browse categories, select items, set quantity and payment method.
- Click **Purchase** to buy. The server checks funds, removes money, and gives the item.
- Purchases are logged to Discord and feedback is shown in the UI.
- Close the shop with the ❌ button.

---

## 🛠️ Customization

- **UI:** Edit `html/style.css` and `html/index.html` for appearance tweaks.
- **Icons/Colors:** Update category icons/colors in the config and JS.
- **Server Logic:** Modify `server.lua` for custom purchase checks or logging.

---

## 📝 Credits

- UI/UX: Inspired by modern dashboard designs.
- Inventory: [ox_inventory](https://github.com/overextended/ox_inventory)
- Framework: QBCore/ESX
- Special thanks to the FiveM community!

---

## 📄 License

This project is open-source. Feel free to modify and share, but please credit the original author.
