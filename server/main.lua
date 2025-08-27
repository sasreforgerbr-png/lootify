local Bridge = require 'shared/bridge'
local Utils = require 'shared/utils'

local Cache = {}

local function ensureRow(owner)
    local row = MySQL.single.await('SELECT data FROM lootify_inventories WHERE owner = ? AND name = ?', { owner, 'player' })
    if not row then
        -- create an empty inventory using default grids
        local payload = { slots = {}, equipment = {}, grids = Config.DefaultPlayerGrids }
        MySQL.prepare.await('INSERT INTO lootify_inventories (owner, name, data) VALUES (?, ?, ?)', { owner, 'player', json.encode(payload) })
        return payload
    end
    return json.decode(row.data)
end

lib.callback.register('lootify:fetchInventory', function(src)
    local owner = Bridge.getIdentifier(src)
    if not owner then return nil end
    if not Cache[owner] then
        Cache[owner] = ensureRow(owner)
    end
    if Config.Debug then
        print(('[lootify] fetchInventory for %s'):format(owner))
    end
    return Cache[owner]
end)

RegisterNetEvent('lootify:saveInventory', function(data)
    local src = source
    local owner = Bridge.getIdentifier(src)
    if not owner then return end
    Cache[owner] = data
    MySQL.prepare.await('INSERT INTO lootify_inventories (owner, name, data) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE data = VALUES(data)',
        { owner, 'player', json.encode(data) })
    if Config.Debug then
        print(('[lootify] inventory saved for %s'):format(owner))
    end
end)

-- simple command to open UI
lib.addCommand('lootify', { help = 'Open Lootify inventory UI' }, function(source, args, raw)
    TriggerClientEvent('lootify:open', source)
end)

AddEventHandler('playerDropped', function(reason)
    local src = source
    local owner = Bridge.getIdentifier(src)
    if owner then Cache[owner] = nil end
end)
