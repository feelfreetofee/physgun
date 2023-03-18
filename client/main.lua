tools, tool = {}, 1

Citizen.CreateThread(function()
	Config.weapon = joaat(Config.weapon)
    while true do
        local armed, weapon = GetCurrentPedWeapon(PlayerPedId())
        if armed and weapon == Config.weapon and IsPlayerFreeAiming(PlayerId()) then
			if not holding then
				holding = true
				Citizen.CreateThread(function()
					while holding do
						DisplaySniperScopeThisFrame()
						DisableControlAction(0, 24)
						DisablePlayerFiring(PlayerId(), 1)
						if IsDisabledControlJustPressed(0, 24) then
							tools[tool].action()
						elseif IsControlJustReleased(0, Config.controller.key) then
							Config.controller.action()
						end
						Wait(0)
					end
				end)
			end
		elseif holding then
			holding = false
		end
		Wait(500)
	end
end)