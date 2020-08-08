local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

isInInventory = false
ESX = nil
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
    [4] = nil,
    [5] = nil
}
local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false


Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(10)
        end

        Citizen.Wait(3000)
	    toghud = true
    end
)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
    end
    while true do
        Citizen.Wait(7)
        if not IsPlayerDead(PlayerId()) then
            DisableControlAction(0, 37, true)
            if IsDisabledControlJustPressed(1, Config.OpenControl) and GetLastInputMethod(0) then
               -- if IsInputDisabled(0) then
                    openInventory()
               --[[  if not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base') then
                        while (not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base')) do
                            RequestAnimDict('amb@prop_human_parking_meter@male@base')
                            Citizen.Wait(10)
                        end
                    end
                    while isInInventory do
                        if canPlayAnim then
                            TaskPlayAnim(PlayerPedId(),'amb@prop_human_parking_meter@male@base', 'base', 1.0, 1.0, -1, 48, 0.0, 0, 0, 0)
                            Citizen.Wait(2000)
                        end
                        Citizen.Wait(10)
                    end --]]
            --    end
            elseif  IsDisabledControlJustReleased(1,  Keys["1"]) and canFire then
                if fastWeapons[1] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[1])
                end
            elseif IsDisabledControlJustReleased(1, Keys["2"]) and canFire then
                if fastWeapons[2] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[2])
                end
            elseif IsDisabledControlJustReleased(1, Keys["3"]) and canFire then
                if fastWeapons[3] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[3])
                end
            elseif IsDisabledControlJustReleased(1, Keys["4"]) and canFire then
                if fastWeapons[4] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[4])
                end
            elseif IsDisabledControlJustReleased(1, Keys["5"]) and canFire then
                if fastWeapons[5] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[5])
                end
            elseif IsDisabledControlJustReleased(1, Keys ["LEFTALT"]) then
                showHotbar()
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function lockinv()
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(10)
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable 
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

function getPlayerWeight()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("conde_inventory:getPlayerInventoryWeight", function(cb)
            local playerweight = cb
            --[[SendNUIMessage({
                action = "setWeightText",
                text =  "<strong>         "..tostring(playerweight).."/"..tostring(Config.MaxWeight).."KG<strong>"
            })]]
            weight = playerweight
            if weight >= Config.MaxWeight then
                weight = 100
            end
            WeightLoaded = true
        end)
    end)
end

function loadStatus()
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        health = (GetEntityHealth(player) - 100)
        armour = GetPedArmour(player)
        if IsPedOnFoot(player) then
            if IsPedSwimmingUnderWater(player) then
                oxy = (GetPlayerUnderwaterTimeRemaining(PlayerId()))
            else
                oxy = (GetPlayerSprintStaminaRemaining(PlayerId()))
            end
        else
            oxy = 0
        end


-- SET YOUR STATUS HERE (ESX BASIC NEEDS, STRESS OR  OR WTV YOU ARE USING)
--[[
        TriggerEvent('tqrp_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('tqrp_status:getStatus', 'thirst', function(thirst)
                TriggerEvent('tqrp_status:getStatus','stress',function(stress)
                    myhunger = hunger.getPercent()
                    mythirst = thirst.getPercent()
                    mystress = stress.getPercent()
                    StatusLoaded = true
                end)
            end)
        end)
        ]]
-- DELETE THIS AFTER COMPLETING THE ABOVE CODE
        myhunger = 0
        mythirst = 0
        mystress = 0
        StatusLoaded = true
-- DELETE THIS AFTER COMPLETING THE ABOVE CODE
    end)
end

function loadItems()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("conde_inventory:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = 0,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        local founditem = false
                        for slot, item in pairs(fastWeapons) do
                            if item == inventory[key].name then
                                table.insert(
                                        fastItems,
                                        {
                                            label = inventory[key].label,
                                            count = inventory[key].count,
                                            weight = 0,
                                            type = "item_standard",
                                            name = inventory[key].name,
                                            usable = inventory[key].usable,
                                            rare = inventory[key].rare,
                                            canRemove = true,
                                            slot = slot
                                        }
                                )
                                founditem = true
                                break
                            end
                            end
                            if founditem == false then
                             table.insert(items, inventory[key])

                        end
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(
									items,
									{
										label = weapons[key].label,
										count = ammo,
										weight = 0,
										type = "item_weapon",
										name = weapons[key].name,
										usable = false,
										rare = false,
										canRemove = true
									}
								)
							end
                    end
                end
            fastItemsHotbar =  fastItems
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
                    weight = weight
                }
            )
            ItemsLoaded = true
        end, GetPlayerServerId(PlayerId()))
    end)
end

function openInventory()
 --   loadPlayerInventory()
    isInInventory = true
    lockinv()
    SetNuiFocus(true, true)  
    loadPlayerInventory()
    SendNUIMessage(
        {
            action = "display",
            type = "normal",
            hunger = myhunger,
            thirst = mythirst,
            stress = mystress,
            health = health,
            armour = armour,
            oxygen = oxy,
            weight = weight
        }
    )
end

function closeInventory()
    isInInventory = false
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    WeightLoaded = false
    getPlayerWeight()
    StatusLoaded = false
    loadStatus()
    ItemsLoaded = false
    loadItems()
    while not ItemsLoaded or not StatusLoaded or not WeightLoaded do
        Citizen.Wait(100)
    end
end

function showHotbar()
    if not isHotbar then
        isHotbar = true
        SendNUIMessage({
            action = "showhotbar",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
        Citizen.Wait(1500)
        isHotbar = false
    end
end

RegisterNUICallback("NUIFocusOff", function()
    if isInInventory then
        closeInventory()
    end
end)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true
                ESX.TriggerServerCallback('GetCharacterNameServer', function(playerss)
                    foundPlayers = true
                        table.insert(
                            elements,
                            {
                                label = playerss,
                                player = GetPlayerServerId(players[i])
                            }
                        )

                        SendNUIMessage(
                            {
                                action = "nearPlayers",
                                foundAny = foundPlayers,
                                players = elements,
                                item = data.item
                            }
                        )
                end, GetPlayerServerId(players[i]))
            end
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)

        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory()
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
       if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
     --       TriggerServerEvent("tqrp_base:serverlog", "[DROP ITEM] | "..data.item.name .." quant: "..data.number, GetPlayerServerId(PlayerId()), GetCurrentResourceName())
            TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback("GiveItem", function(data, cb)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 3.0 then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        canPlayAnim = false
        ClearPedSecondaryTask(PlayerPedId())
        RequestAnimDict("mp_common")
        while (not HasAnimDictLoaded("mp_common")) do 
            Citizen.Wait(10) 
        end
        TaskPlayAnim(PlayerPedId(),"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
        if (Config.PropList[data.item.name] ~= nil) then 
            attachModel = GetHashKey(Config.PropList[data.item.name].model)
            local bone = GetPedBoneIndex(PlayerPedId(), Config.PropList[data.item.name].bone)
            RequestModel(attachModel)
            while not HasModelLoaded(attachModel) do
                Citizen.Wait(10)
            end
            closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(closestEntity, PlayerPedId(), bone, Config.PropList[data.item.name].x, Config.PropList[data.item.name].y, Config.PropList[data.item.name].z,
            Config.PropList[data.item.name].xR, Config.PropList[data.item.name].yR, Config.PropList[data.item.name].zR, 1, 1, 0, true, 2, 1)
            Citizen.Wait(1500)
            if DoesEntityExist(closestEntity) then
                DeleteEntity(closestEntity)
            end
        end
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
        canPlayAnim = true
        TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
        Wait(250)
        loadPlayerInventory()
    end
    cb("ok")
end)

RegisterNUICallback("PutIntoFast", function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
		loadPlayerInventory()
		cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
    fastWeapons[data.item.slot] = nil
    if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
        TriggerEvent('conde-inventoryhud:closeinventory', _source)
        RemoveWeapon(data.item.name)
    end
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('tqrp_inventory:disablenumbers')
AddEventHandler('tqrp_inventory:disablenumbers', function(disabled)
    canFire = disabled
end)

RegisterNetEvent('conde-inventoryhud:steal')
AddEventHandler('conde-inventoryhud:steal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
            exports['mythic_progbar']:Progress({
                name = "rob",
                duration = 3000,
                label = "A roubar...",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {},
                animation = {},
                prop = {},
              }, function(status)
                if not status then
                    TriggerEvent("conde_inventory:openPlayerInventory", GetPlayerServerId(closestPlayer))
           --         TriggerServerEvent("tqrp_base:serverlog", "[STEALINVENTORY] | TARGET = ["..searchPlayerPed.."]",  GetPlayerServerId(PlayerId()), GetCurrentResourceName())
                end
            end)
        end
    else
        exports['mythic_notify']:SendAlert('error', 'Nenhum jogador por perto')
    end
end)

RegisterNetEvent('conde-inventoryhud:notification')
AddEventHandler('conde-inventoryhud:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
        SendNUIMessage({
            action = "notification",
            itemname = sourceitemname,
            itemlabel = sourceitemlabel,
            itemcount = sourceitemcount,
            itemremove = sourceitemremove
        })
end)

RegisterNetEvent('conde-inventoryhud:closeinventory')
AddEventHandler('conde-inventoryhud:closeinventory', function()
    closeInventory()
end)

RegisterNetEvent('conde-inventoryhud:clearfastitems')
AddEventHandler('conde-inventoryhud:clearfastitems', function()
    fastWeapons = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = nil,
        [5] = nil
    }
    RemoveAllPedWeapons(PlayerPedId(), true)
end)

RegisterNetEvent('conde_inventory:doClose')
AddEventHandler('conde_inventory_inventoryhud:doClose', function(...) 
    closeInventory(...); 
end)


