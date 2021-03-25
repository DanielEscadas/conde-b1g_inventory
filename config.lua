Config = {}
Config.Locale = "en"
Config.IncludeCash = true -- Include cash in inventory?
Config.IncludeWeapons = true -- Include weapons in inventory?
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)?
Config.ExcludeAccountsList = {"bank","money"} -- List of accounts names to exclude from inventory
Config.OpenControl = 349 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.MaxWeight = 80 --SAME AS THE DEFAULT ON ES EXTENDED CONFIG

Config.Attachments = {"flashlight", "grip", "scope", "skin", "suppressor"}

-- List of item names that will close ui when used
Config.CloseUiItems = {
  'bread',
}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110
Config.PoliceShopShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2
Config.PoliceShopLength = 2

Config.Color = 2
Config.WeaponColor = 1

Config.WeaponLiscence = {x = 12.47, y = -1105.5, z = -29.8}
Config.LicensePrice = 22500

Config.Shops = {
    RegularShop = {
        Locations = {
            { x = 373.875, y = 325.896, z = 102.566 },
            { x = -1104.52, y = -821.67, z = 13.28 },
            { x = 2557.458, y = 382.282, z = 107.622 },
            { x = -3038.939, y = 585.954, z = 6.908 },
            { x = -3241.927, y = 1001.462, z = 11.830 },
            { x = 547.431, y = 2671.710, z = 41.156 },
            { x = 1961.464, y = 3740.672, z = 31.343 },
            { x = 2678.916, y = 3280.671, z = 54.241 },
            { x = 1729.216, y = 6414.131, z = 34.037 },
            { x = -48.519, y = -1757.514, z = 28.421 },
            { x = 1163.373, y = -323.801, z = 68.205 },
            { x = -707.501, y = -914.260, z = 18.215 },
            { x = -1820.523, y = 792.518, z = 137.118 },
            { x = 1698.388, y = 4924.404, z = 41.063 },
            { x = 25.723, y = -1346.966, z = 28.497 },
            { x = 268.26, y = -979.44, z = 28.37 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
       
        }
    },

    IlegalShop = {
        Locations = {
            { x = 468.58, y = -3205.64, z = 9.79 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    RobsLiquor = {
        Locations = {
            { x = 1135.808, y = -982.281, z = 45.415 },
            { x = -1222.915, y = -906.983, z = 11.326 },
            { x = -1487.553, y = -379.107, z = 39.163 },
            { x = -2968.243, y = 390.910, z = 14.043 },
            { x = 1166.024, y = 2708.930, z = 37.157 },
            { x = 1392.562, y = 3604.684, z = 33.980 },
            { x = -1393.409, y = -606.624, z = 29.319 }
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }

        }
    },

    YouTool = {
        Locations = {
            { x = 2748.0, y = 3473.0, z = 55.68 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    PrisonShop = {
        Locations = {
            { x = -1103.05, y = -823.72, z = 14.48 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    WeaponShop = {
        Locations = {
            { x = 22.09, y = -1107.28, z = 28.80 }
          
        },

        Items = {
            { name = "bread", price = 1}
        }
    },


    PoliceShop = {
       Locations = {
            { x = 461.5, y = -981.09, z = 30.69 },

        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
}
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_FLARE = 1233104067,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847

Config.PropList = {
    cash = {["model"] = 'prop_cash_pile_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}
}
