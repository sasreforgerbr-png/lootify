Items = {}

-- Example base items (just a couple to start)
Items['water'] = {
    label = 'Water Bottle',
    size = { w = 1, h = 2 },
    stack = 3,
}

Items['bandage'] = {
    label = 'Bandage',
    size = { w = 1, h = 1 },
    stack = 5,
}

-- Example container with multiple grids like Tarkov rig/backpack
Items['simple_rig'] = {
    label = 'Simple Rig',
    size = { w = 3, h = 3 },
    grids = {
        { w = 4, h = 4 },
        {
            { w = 2, h = 2 },
            { w = 2, h = 2 },
        },
        {
            { w = 2, h = 2 },
            { w = 2, h = 2 },
        }
    }
}

return Items
