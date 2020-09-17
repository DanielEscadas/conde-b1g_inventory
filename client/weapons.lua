
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local currentWeapon
local currentWeaponSlot
local currentWepAttachs = {}
canFire = true

RegisterNetEvent('conde-inventoryhud:useWeapon')
AddEventHandler('conde-inventoryhud:useWeapon', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
    TriggerEvent('conde-inventoryhud:notification', weapon,"Retiraste", 1, false)

end)

RegisterNetEvent('conde-inventoryhud:removeCurrentWeapon')
AddEventHandler('conde-inventoryhud:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
end)

-- This is just an example for the carbine rifle, do the same for the following...

local weapons = {
	[GetHashKey('WEAPON_CARBINERIFLE')] = {
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['extendedmag'] = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
	}
}

RegisterNetEvent('tqrp_inventoryhud:useAttach')
AddEventHandler('tqrp_inventoryhud:useAttach', function(attach)
    local playerPed = PlayerPedId()
    local hasAttach = false
    if currentWeapon ~= nil then
        local hash = GetHashKey(currentWeapon)
        for i = 1, #currentWepAttachs do
            if currentWepAttachs[i] == attach then
                hasAttach = true
            end
		end
		if weapons[tostring( hash )] ~= nil and weapons[tostring( hash )][attach] ~= nil and not hasAttach then
			ESX.TriggerServerCallback('esx_inventory:removeItem', function(cb) end, attach)
			table.insert(currentWepAttachs, attach)
            GiveWeaponComponentToPed( playerPed, hash, weapons[tostring( hash )][attach] )
        else
            exports['b1g_notify']:Notify('error', 'Esse attachment não é compativel ou já se encontra equipado.')
        end
    else
        exports['b1g_notify']:Notify('error', 'Nenhuma arma selecionada.')
    end
end)

RegisterCommand("desequipar", function(source, args, rawCommand)
    if currentWeapon ~= nil then
        local playerPed = PlayerPedId()
        local hash = GetHashKey(currentWeapon)
        if args[1] then
			local attach = args[1]
            for i = 1, #currentWepAttachs do
                if currentWepAttachs[i] == attach then
                    ESX.TriggerServerCallback('tqrp_inventoryhud:addPlayerItem', function(cb)
                        if cb then
                            table.remove(currentWepAttachs, i)
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][attach])
                        else
                            exports['b1g_notify']:Notify('error', 'Espaço insuficiente.')
                        end          
                    end, currentWepAttachs[i], 1)
                    return
                end
            end
            exports['b1g_notify']:Notify('error', 'Essa arma não tem esse attachment.')
		else
			for i = 1, #currentWepAttachs do
				if currentWepAttachs[i] ~= nil then
					ESX.TriggerServerCallback('tqrp_inventoryhud:addPlayerItem', function(cb)
                        if cb then
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
							table.remove(currentWepAttachs, i)
                        else
                            exports['b1g_notify']:Notify('error', 'Espaço insuficiente.')
                        end          
                    end, currentWepAttachs[i], 1)
				end
			end
		end
    else
        exports['b1g_notify']:Notify('error', 'Não tens nenhuma arma na mão.')
    end
end)

function RemoveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    local wepInfo = { 
        count = GetAmmoInPedWeapon(playerPed, hash),
        attach = currentWepAttachs
    }
    TriggerServerEvent('conde-inventoryhud:updateAmmoCount', hash, wepInfo)
    canFire = false
    disable()
    if checkh[weapon] == hash then
        if GetSelectedPedWeapon(playerPed) == hash then
            ESX.TriggerServerCallback('tqrp_inventoryhud:addPlayerItem', function(cb)
            end, weapon, 1)
        end
    end
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
        if not HasAnimDictLoaded("reaction@intimidation@cop@unarmed") then
            loadAnimDict( "reaction@intimidation@cop@unarmed" )
        end
        TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
		Citizen.Wait(100)
    else
        if not HasAnimDictLoaded("reaction@intimidation@1h") then
            loadAnimDict( "reaction@intimidation@1h" )
        end
        TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "outro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
        Citizen.Wait(1600)
    end
    RemoveWeaponFromPed(playerPed, hash)
	ClearPedTasks(playerPed)
    canFire = true
    TriggerEvent('conde-inventoryhud:notification', weapon,"Guardaste", 1, false)
end

function GiveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    if not HasAnimDictLoaded("reaction@intimidation@1h") then
        loadAnimDict( "reaction@intimidation@1h" )
    end
    if weapon == 'WEAPON_PETROLCAN' then
        local coords = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
            TriggerEvent('conde-inventoryhud:removeCurrentWeapon')
            TriggerEvent('joca_fuel:useJerryCan')
        else
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            SetPedAmmo(playerPed, hash, 1000)
            ClearPedTasks(playerPed)
            canFire = true
        end
    else
      ESX.TriggerServerCallback('conde-inventoryhud:getAmmoCount', function(gunInfo)
        currentWepAttachs = gunInfo.attachments
        canFire = false
        disable()
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("rcmjosh4") then
                loadAnimDict( "rcmjosh4" )
            end
            TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(500)
        else
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)          
            Citizen.Wait(1600)
        end
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        for i = 1, #currentWepAttachs do
            if weapons[tostring( hash )] ~= nil then
                GiveWeaponComponentToPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
            end
        end
        if checkh[weapon] == hash then
            ESX.TriggerServerCallback('tqrp_inventoryhud:takePlayerItem', function(cb)
                SetPedAmmo(playerPed, hash, 1)
            end, weapon, 1)
        elseif Config.FuelCan == hash and gunInfo.ammoCount == nil then
            SetPedAmmo(playerPed, hash, 1000)
        else
            SetPedAmmo(playerPed, hash, gunInfo.ammoCount or 0)
        end
        ClearPedTasks(playerPed)
        canFire = true
      end, hash)
    end
end

--[[Citizen.CreateThread(function()
    local sleep = 1500
    while true do
        local player = PlayerPedId()
        if IsPedShooting(player) then
            sleep = 10
            for k, v in pairs(Config.Throwables) do
                if k == currentWeapon then
                    ESX.TriggerServerCallback('conde_inventory:takePlayerItem', function(removed)
                        if removed then
                            TriggerEvent('conde-inventoryhud:removeCurrentWeapon')
                        end
                    end, currentWeapon, 1)
                end
            end
        else
            sleep = 1500
        end
        Citizen.Wait(sleep)
    end
end)]]

function disable()
	Citizen.CreateThread(function ()
		while not canFire do
			Citizen.Wait(10)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(player, true)
		end
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
