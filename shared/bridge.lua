Bridge = {}
Bridge.name = 'standalone'

local ESX, QBCore, QBXCore

CreateThread(function()
    if GetResourceState('es_extended') == 'started' then
        Bridge.name = 'esx'
        ESX = exports['es_extended']:getSharedObject()
        if not ESX then print('[lootify] ESX shared object not found') end
    elseif GetResourceState('qbx-core') == 'started' then
        Bridge.name = 'qbox'
        QBXCore = exports['qbx-core']:GetCoreObject()
    elseif GetResourceState('qb-core') == 'started' then
        Bridge.name = 'qbcore'
        QBCore = exports['qb-core']:GetCoreObject()
    else
        Bridge.name = 'standalone'
    end
    print(('[lootify] Bridge in %s mode'):format(Bridge.name))
end)

function Bridge.getIdentifier(src)
    if Bridge.name == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        return xPlayer and xPlayer.identifier or nil
    elseif Bridge.name == 'qbox' then
        local player = exports['qbx-core']:GetPlayer(src)
        return player and player.PlayerData and player.PlayerData.citizenid or nil
    elseif Bridge.name == 'qbcore' then
        local player = QBCore.Functions.GetPlayer(src)
        return player and player.PlayerData and player.PlayerData.citizenid or nil
    end
    -- fallback to license identifier
    local ids = GetPlayerIdentifiers(src)
    for i = 1, #ids do
        if ids[i]:sub(1,7) == 'license' then
            return ids[i]
        end
    end
    return nil
end

function Bridge.notify(src, msg, nType)
    if Bridge.name == 'esx' then
        TriggerClientEvent('esx:showNotification', src, msg)
    elseif Bridge.name == 'qbox' or Bridge.name == 'qbcore' then
        TriggerClientEvent('QBCore:Notify', src, msg, nType or 'primary')
    else
        TriggerClientEvent('lootify:notify', src, msg)
    end
end

return Bridge
