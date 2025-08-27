# Lootify (skeleton)

Tarkov-like inventory skeleton for FiveM using **ox_lib** callbacks and **oxmysql** for persistence.
Auto-detects **ESX** or **Qbox/QBCore** and uses the correct identifier (citizenid/identifier).

## Requirements
• ox_lib • oxmysql • (ESX or Qbox/QBCore)

## Install
1. Put this folder in your resources: `resources/[loot]/lootify`
2. Import SQL: `server/database.sql`
3. Ensure dependencies and Lootify in `server.cfg`:
```
ensure oxmysql
ensure ox_lib
ensure lootify
```
4. In game, run `/lootify` to open the UI.

## Notes
• This is a base. It only draws the grid template and saves a stub inventory JSON.
• Next steps: items registry, placement rules, collision checks, stack/split, drag-drop, equip validation, trades/loot, stash, hotbar, weight, durability, etc.
