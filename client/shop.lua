local shopData = nil

Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local Licenses = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        if IsInRegularShopZone(coords) or IsInRobsLiquorZone(coords) or IsInIlegalShopZone(coords) or IsInYouToolZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) or IsInPoliceShopZone(coords) then
            if IsInRegularShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("regular")
                    Citizen.Wait(2000)
                end
            end
            if IsInIlegalShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("ilegal")
                    Citizen.Wait(2000)
                end
            end
            if IsInRobsLiquorZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("robsliquor")
                    Citizen.Wait(2000)
                end
            end
            if IsInYouToolZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("youtool")
                    Citizen.Wait(2000)
                end
            end
            if IsInPrisonShopZone(coords) then
                if ESX.GetPlayerData().job.name == police then
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("prison")
                       Citizen.Wait(2000)
                    end
                end
            end
            if IsInWeaponShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                --    if Licenses['weapon'] ~= nil then
                        OpenShopInv("weaponshop")
                        Citizen.Wait(2000)
                --    else
                 --       exports['mythic_notify']:DoHudText('error', 'You need a Fire Arms license before you can buy weapons')
                 --   end
                end
            end
            if IsInPoliceShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    if ESX.GetPlayerData().job.name == "police" then
                --    if Licenses['weapon'] ~= nil the
                        OpenShopInv("policeshop")
                        Citizen.Wait(2000)
                --    else
                 --       exports['mythic_notify']:DoHudText('error', 'You need a Fire Arms license before you can buy weapons')
                 --   end
                    end
                end
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

function OpenShopInv(shoptype)
    text = "Store"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
        TriggerEvent("conde_inventory:openShopInventory", data, inventory)
    end, shoptype)
end

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
        TriggerEvent("conde_inventory:openShopInventory", data, inventory)
    end, type, shopinventory)
end)

RegisterNetEvent("conde_inventory:openShopInventory")
AddEventHandler("conde_inventory:openShopInventory", function(data, inventory)
    setShopInventoryData(data, inventory, weapons)
    openShopInventory()
end)

function setShopInventoryData(data, inventory)
    shopData = data

    SendNUIMessage(
            {
                action = "setInfoText",
                text = data.text
            }
    )

    items = {}

    SendNUIMessage(
            {
                action = "setShopInventoryItems",
                itemList = inventory
            }
    )
end

function openShopInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
            {
                action = "display",
                type = "shop"
            }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("suku:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
    end

    Wait(150)
    loadPlayerInventory()

    cb("ok")
end
)

RegisterNetEvent("suku:AddAmmoToWeapon")
AddEventHandler("suku:AddAmmoToWeapon", function(hash, amount)
    AddAmmoToPed(PlayerPedId(), hash, amount)
end)

function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end
function IsInIlegalShopZone(coords)
    IlegalShop = Config.Shops.IlegalShop.Locations
    for i = 1, #IlegalShop, 1 do
        if GetDistanceBetweenCoords(coords, IlegalShop[i].x, IlegalShop[i].y, IlegalShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInRobsLiquorZone(coords)
    RobsLiquor = Config.Shops.RobsLiquor.Locations
    for i = 1, #RobsLiquor, 1 do
        if GetDistanceBetweenCoords(coords, RobsLiquor[i].x, RobsLiquor[i].y, RobsLiquor[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInYouToolZone(coords)
    YouTool = Config.Shops.YouTool.Locations
    for i = 1, #YouTool, 1 do
        if GetDistanceBetweenCoords(coords, YouTool[i].x, YouTool[i].y, YouTool[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInPrisonShopZone(coords)
    PrisonShop = Config.Shops.PrisonShop.Locations
    for i = 1, #PrisonShop, 1 do
        if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end


function IsInPoliceShopZone(coords)
    PoliceShop = Config.Shops.PoliceShop.Locations
    for i = 1, #PoliceShop, 1 do
        if GetDistanceBetweenCoords(coords, PoliceShop[i].x, PoliceShop[i].y, PoliceShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    player = PlayerPedId()
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), "Loja", 3.0, Config.Color, Config.ShopBlipID)
    end

    for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
        CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), "Tabacaria", 3.0, Config.Color, Config.LiquorBlipID)
    end

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), "U Ferramentas", 3.0, Config.Color, Config.YouToolBlipID)
    end

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), "Prison Commissary", 3.0, Config.Color, Config.PrisonShopBlipID)
    end

    for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), "Ammunation", 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
    end

    CreateBlip(vector3(-755.79, 5596.07, 41.67), "Teleférico", 3.0, 4, 36)
end)

Citizen.CreateThread(function()
    local sleep = 7
    while true do
        Citizen.Wait(sleep)
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        if IsPedOnFoot(player) then
            for k, v in pairs(Config.Shops.RegularShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.IlegalShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.YouTool.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.PrisonShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.WeaponShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.PoliceShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z + 1, "Press [~g~E~w~] to open the shop")
                        near = true
                        break
                    end
                    near = true
                end
            end
            if not near then 
                sleep = 1500
            else
                sleep = 7
            end
            near = false
        else
            Citizen.Wait(1500)
        end
    end
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function CreateBlip(coords, text, radius, color, sprite)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end