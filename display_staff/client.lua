ESX = nil
local activated = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)

function DrawStaffOverSkin(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(true)
	SetTextColour(255, 0, 0, 255)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 700
end

RegisterCommand('onstaff', function()
    ESX.TriggerServerCallback("checkperms:fordisplay", function(permschecked)
        if permschecked == "superadmin" or permschecked == "admin" or permschecked == "mod" then 
            if activated == false then
                TriggerServerEvent('on:logs')
            end
            activated = true
            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local offset = 1
                    local Mycoords = GetEntityCoords(GetPlayerPed(-1), false)
                    local coords = GetEntityCoords(PlayerPedId(), false)
                    local dist = Vdist2(Mycoords, coords)
                    if dist < 5 then
                        if activated == true then
                            DrawStaffOverSkin(Mycoords.x,  Mycoords.y,  Mycoords.z + 1, "STAFF", 0.6)
                        end
                    end
                end
            end)
            ESX.ShowNotification("Staff activated")
        else
            ESX.ShowNotification("You are not a staff you can't use")
        end
    end)
end)


RegisterCommand('offstaff', function()
    ESX.TriggerServerCallback("checkperms:fordisplay", function(permschecked)
        if permschecked == "superadmin" or permschecked == "admin" or permschecked == "mod" then 
            activated = false
            ESX.ShowNotification("Staff deactivated")
        else
            ESX.ShowNotification("You are not a staff you can't use it")
        end 
    end)
    if activated == true then
        TriggerServerEvent('off:logs')
    end
end)
