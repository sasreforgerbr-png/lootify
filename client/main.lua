local showing = false

RegisterNetEvent('lootify:open', function()
    if showing then return end
    showing = true
    SetNuiFocus(true, true)
    local payload = lib.callback.await('lootify:fetchInventory', false)
    SendNUIMessage({ action = 'open', data = payload, config = { title = Config.Title } })
end)

RegisterNUICallback('close', function(_, cb)
    showing = false
    SetNuiFocus(false, false)
    cb(1)
end)

RegisterNUICallback('save', function(data, cb)
    TriggerServerEvent('lootify:saveInventory', data)
    cb(1)
end)

-- fallback notify if no framework
RegisterNetEvent('lootify:notify', function(msg)
    lib.notify({ title = Config.Title, description = msg })
end)

-- optional test key mapping (disabled by default)
-- RegisterCommand('lootify', function() TriggerEvent('lootify:open') end)
-- RegisterKeyMapping('lootify', 'Open Lootify', 'keyboard', 'F2')

-- NUI post bridges
RegisterNUICallback('close', function(_, cb) cb(1) end)

RegisterRawNuiCallback('close', function(_, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({ action = 'close' })
    cb({ ok = true })
end)

RegisterRawNuiCallback('save', function(data, cb)
    -- data is empty for now
    TriggerServerEvent('lootify:saveInventory', {})
    cb({ ok = true })
end)
