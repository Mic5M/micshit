ESX = nil
myStrengthModifier = 1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent("Kl_Hud:onTick")
AddEventHandler("Kl_Hud:onTick", function(status)

    TriggerEvent('esx_status:getStatus', 'hunger', function(status)
        food = status.val / 10000
    end)
    TriggerEvent('esx_status:getStatus', 'thirst', function(status)
        thirst = status.val / 10000
    end)

end)

Citizen.CreateThread(function()
    while true do 
        local s = 1000
        local ped = GetPlayerPed(-1)
        local MyPedVeh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
        local EstaEnElAgua = IsEntityInWater(ped)
        local EstaEnElAguaNadando = IsPedSwimming(ped)
        
        -- Rdarar
        if IsPedSittingInAnyVehicle(ped) and not IsPlayerDead(ped) then

            DisplayRadar(true)

        elseif not IsPedSittingInAnyVehicle(ped) then

            DisplayRadar(false)

        end
        SendNUIMessage({
            pauseMenu = IsPauseMenuActive();
            armour = GetPedArmour(PlayerPedId());
            health = GetEntityHealth(PlayerPedId())-100;
            food = food;
            thirst = thirst;
            estoyencoche = IsPedSittingInAnyVehicle(ped);
            id = GetPlayerServerId(PlayerId());
            EstaEnElAgua = IsEntityInWater(ped);
            EstaEnElAguaNadando = IsPedSwimming(ped);
            oxigenoagua = GetPlayerUnderwaterTimeRemaining(PlayerId())*10;
            oxigeno = 100-GetPlayerSprintStaminaRemaining(PlayerId());
        })

        RegisterCommand('hudOff',function()
            SendNUIMessage({
                quitarhud = true
            })
        end)

        RegisterCommand('hudOn',function()
            SendNUIMessage({
                ponerhud = true
            })
        end)

        RegisterCommand('cinemaOn',function()
            DisplayHud(false)
            SendNUIMessage({
                ponerbarras = true
            })
        end)

        -- quitarbarras

        RegisterCommand('cinemaOff',function()
            SendNUIMessage({
                quitarbarras = true
            })
        end)

        Citizen.Wait(s)
        
	end
	
end)