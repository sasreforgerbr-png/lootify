Config = {}

-- Inventory UI
Config.Title = 'Lootify'
Config.Debug = true

-- How many slots wide/high the default player main grid is
Config.DefaultPlayerGrids = {
    -- main backpack/body grid (example)
    { w = 8, h = 6 },
    -- two rows with two 2x2 pockets (example)
    {
        { w = 2, h = 2 }, { w = 2, h = 2 }
    },
    {
        { w = 2, h = 2 }, { w = 2, h = 2 }
    }
}

-- Equipment slots inspired by Tarkov
-- Note: this is just a skeleton; validation rules come later.
Config.EquipmentSlots = {
    'Headwear',
    'FaceCover',
    'Earpiece',
    'Eyewear',
    'ArmorVest',
    'TacticalRig',
    'Backpack',
    'Primary',
    'Secondary',
    'Holster',
    'Scabbard',
    'Armband',
    'Pockets'
}
