Config = {}
Config.UseTarget = GetConvar('UseTarget', 'false') == 'true'

Config.Products = {
    ["normal"] = {
        [1] = {
            name = "tosti",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "water_bottle",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "kurkakola",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "twerks_candy",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "snikkel_candy",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "sandwich",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "beer",
            price = 7,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "whiskey",
            price = 10,
            amount = 50,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "vodka",
            price = 12,
            amount = 50,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "bandage",
            price = 100,
            amount = 50,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "lighter",
            price = 2,
            amount = 50,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "rolling_paper",
            price = 2,
            amount = 5000,
            info = {},
            type = "item",
            slot = 12,
        },
    },
    ["hardware"] = {
        [1] = {
            name = "lockpick",
            price = 200,
            amount = 50,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_wrench",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "weapon_hammer",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "repairkit",
            price = 250,
            amount = 50,
            info = {},
            type = "item",
            slot = 4,
            requiredJob = { "mechanic", "police" }
        },
        [5] = {
            name = "screwdriverset",
            price = 350,
            amount = 50,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "phone",
            price = 850,
            amount = 50,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "radio",
            price = 250,
            amount = 50,
            info = {},
            type = "item",
            slot = 7,
        },
        [8] = {
            name = "binoculars",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 8,
        },
        [9] = {
            name = "firework1",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 9,
        },
        [10] = {
            name = "firework2",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 10,
        },
        [11] = {
            name = "firework3",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 11,
        },
        [12] = {
            name = "firework4",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 12,
        },
        [13] = {
            name = "fitbit",
            price = 400,
            amount = 150,
            info = {},
            type = "item",
            slot = 13,
        },
        [14] = {
            name = "cleaningkit",
            price = 150,
            amount = 150,
            info = {},
            type = "item",
            slot = 14,
        },
        [15] = {
            name = "advancedrepairkit",
            price = 500,
            amount = 50,
            info = {},
            type = "item",
            slot = 15,
            requiredJob = { "mechanic" }
        },        
    },
    ["weedshop"] = {
        [1] = {
            name = "joint",
            price = 10,
            amount = 1000,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_poolcue",
            price = 100,
            amount = 1000,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "weed_nutrition",
            price = 20,
            amount = 1000,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "empty_weed_bag",
            price = 2,
            amount = 1000,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "rolling_paper",
            price = 2,
            amount = 1000,
            info = {},
            type = "item",
            slot = 5,
        },
    },
    ["gearshop"] = {
        [1] = {
            name = "diving_gear",
            price = 2500,
            amount = 10,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "jerry_can",
            price = 200,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },
    },
    ["leisureshop"] = {
        [1] = {
            name = "parachute",
            price = 2500,
            amount = 10,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "binoculars",
            price = 50,
            amount = 50,
            info = {},
            type = "item",
            slot = 2,
        },    
        [3] = {
            name = "diving_gear",
            price = 2500,
            amount = 10,
            info = {},
            type = "item",
            slot = 3,
        },
        -- [4] = {
        --     name = "smoketrailred",
        --     price = 250,
        --     amount = 50,
        --     info = {},
        --     type = "item",
        --     slot = 4,
        -- },
    },
    ["weapons"] = {
        [1] = {
            name = "weapon_knife",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "weapon_bat",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "weapon_hatchet",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 3,
            requiredJob = { "mechanic", "police" }
        },
        [4] = {
            name = "weapon_pistol",
            price = 2500,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
            requiresLicense = true
        },
        [5] = {
            name = "weapon_snspistol",
            price = 1500,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            requiresLicense = true
        },
        [6] = {
            name = "weapon_vintagepistol",
            price = 4000,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            requiresLicense = true
        },
        [7] = {
            name = "pistol_ammo",
            price = 250,
            amount = 250,
            info = {},
            type = "item",
            slot = 7,
            requiresLicense = true
        },
    },
    ["casino"] = {
        [1] = {
            name = 'casinochips',
            price = 1,
            amount = 999999,
            info = {},
            type = 'item',
            slot = 1,
        }
    },
}

Config.Locations = {
    -- 24/7 Locations
    ["247supermarket"] = {
        ["label"] = "24/7 Supermarket",
        ["coords"] = {
            [1] = vector4(24.47, -1346.62, 29.5, 271.66),       -- 24/7 1
            [2] = vector4(-3039.54, 584.38, 7.91, 17.27),       -- 24/7 2
            [3] = vector4(-3242.97, 1000.01, 12.83, 357.57),    -- 24/7 3
            [4] = vector4(1728.07, 6415.63, 35.04, 242.95),     -- 24/7 4
            [5] = vector4(1959.82, 3740.48, 32.34, 301.57),     -- 24/7 5
            [6] = vector4(549.13, 2670.85, 42.16, 99.39),       -- 24/7 6
            [7] = vector4(2677.47, 3279.76, 55.24, 335.08),     -- 24/7 7
            [8] = vector4(2556.66, 380.84, 108.62, 356.67),     -- 24/7 8
            [9] = vector4(372.66, 326.98, 103.57, 253.73),      -- 24/7 9
        },
        ["ped"] = {
            ["model"] = 'mp_m_shopkeep_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["normal"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },

    -- LTD Gasoline Locations
    ["ltdgasoline"] = {
        ["label"] = "LTD Gasoline",
        ["coords"] = {
            [1] = vector4(-47.02, -1758.23, 29.42, 45.05),      -- LTD 1
            [2] = vector4(-706.06, -913.97, 19.22, 88.04),      -- LTD 2
            [3] = vector4(-1820.02, 794.03, 138.09, 135.45),    -- LTD 3
            [4] = vector4(1164.71, -322.94, 69.21, 101.72),     -- LTD 4
            [5] = vector4(1697.87, 4922.96, 42.06, 324.71)      -- LTD 5
        },
        ["ped"] = {
            ["model"] = 'mp_m_shopkeep_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["normal"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },

    -- Rob's Liquor Locations
    ["robsliquor"] = {
        ["label"] = "Rob's Liqour",
        ["coords"] = {
            [1] = vector4(-1221.58, -908.15, 12.33, 35.49),     -- ROB 1
            [2] = vector4(-1486.59, -377.68, 40.16, 139.51),    -- ROB 2
            [3] = vector4(-2966.39, 391.42, 15.04, 87.48),      -- ROB 3
            [4] = vector4(1165.17, 2710.88, 38.16, 179.43),     -- ROB 4
            [5] = vector4(1134.2, -982.91, 46.42, 277.24)       -- ROB 5
        },
        ["ped"] = {
            ["model"] = 'mp_m_shopkeep_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["normal"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },

    -- Hardware Store Locations
    ["hardware"] = {
        ["label"] = "Hardware Store",
        ["coords"] = {
            [1] = vector4(45.68, -1749.04, 29.61, 53.13),       -- HDWR 1
            [2] = vector4(2747.71, 3472.85, 55.67, 255.08),     -- HDWR 2
            [3] = vector4(-421.83, 6136.13, 31.88, 228.2)       -- HDWR 3
        },
        ["ped"] = {
            ["model"] = 'mp_m_waremech_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["hardware"],
        ["showblip"] = true,
        ["blipsprite"] = 402
    },

    -- Ammunation Locations
    ["ammunation"] = {
        ["label"] = "Ammunation",
        ["coords"] = {
            [1] = vector4(-661.96, -933.53, 21.83, 177.05),        -- AMMU 1
            [2] = vector4(809.68, -2159.13, 29.62, 1.43),        -- AMMU 2
            [3] = vector4(1692.67, 3761.38, 34.71, 227.65),        -- AMMU 3
            [4] = vector4(-331.23, 6085.37, 31.45, 228.02),        -- AMMU 4
            [5] = vector4(253.63, -51.02, 69.94, 72.91),          -- AMMU 5
            [6] = vector4(23.0, -1105.67, 29.8, 162.91),         -- AMMU 6
            [7] = vector4(2567.48, 292.59, 108.73, 349.68),        -- AMMU 7
            [8] = vector4(-1118.59, 2700.05, 18.55, 221.89),       -- AMMU 8
            [9] = vector4(841.92, -1035.32, 28.19, 1.56),        -- AMMU 9
            [10] = vector4(-1304.19, -395.12, 36.7, 75.03)     -- AMMU 10
        },
        ["ped"] = {
            ["model"] = 's_m_y_ammucity_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["weapons"],
        ["showblip"] = true,
        ["blipsprite"] = 110
    },

    -- Casino Locations
    ["casino"] = {
        ["label"] = "Diamond Casino",
        ["coords"] = {
            [1] = vector4(950.21, 33.11, 71.84, 54.11)
        },
        ["ped"] = {
            ["model"] = 's_m_y_casino_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["casino"],
        ["showblip"] = true,
        ["blipsprite"] = 617
    },
    ["casino2"] = {
        ["label"] = "Casino Bar",
        ["coords"] = {
            [1] = vector4(937.45, 27.22, 71.83, 61.21)
        },
        ["ped"] = {
            ["model"] = 'a_m_y_smartcaspat_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["normal"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },

    -- Weedshop Locations
    ["weedshop"] = {
        ["label"] = "Smoke on the water",
        ["coords"] = {
            [1] = vector4(-1171.31, -1570.89, 4.66, 130.03)
        },
        ["ped"] = {
            ["model"] = 'a_m_y_hippy_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["weedshop"],
        ["showblip"] = true,
        ["blipsprite"] = 140
    },

    -- Sea Word Locations
    ["seaword1"] = {
        ["label"] = "Sea Word",
        ["coords"] = {
            [1] = vector4(-1687.03, -1072.18, 13.15, 52.93)
        },
        ["ped"] = {
            ["model"] = 'a_m_y_beach_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["gearshop"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },

    -- Leisure Shop Locations
    ["leisureshop"] = {
        ["label"] = "Leisure Shop",
        ["coords"] = {
            [1] = vector4(-1505.91, 1511.95, 115.29, 257.13)
        },
        ["ped"] = {
            ["model"] = 'a_m_y_beach_01'
        },
        ["radius"] = 2.2,
        ["products"] = Config.Products["leisureshop"],
        ["showblip"] = true,
        ["blipsprite"] = 52
    },
}
