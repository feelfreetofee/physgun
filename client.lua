local phys = false
RegisterCommand('phys', function()
	phys = not phys
	if not phys then return end
	local aim, entity
	local offset
	local player = PlayerId()
	local ped = PlayerPedId()
	while phys do
		if aim then
			if not IsPlayerFreeAiming(player) then
				aim = false
			end
			local world, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
			if IsControlPressed(0, 14) then
				offset -= 1
			elseif IsControlPressed(0, 15) then
				offset += 1
			end
			if offset < 0 then
				offset = -offset
			end
			local pos = world + normal * offset
			SetEntityCoords(entity, pos.x, pos.y, pos.z)
		elseif IsControlJustPressed(0, 24) then
			aim, entity = GetEntityPlayerIsFreeAimingAt(player)
			if aim then
				offset = #(GetEntityCoords(ped) - GetEntityCoords(entity))
			end
		end
		Wait(0)
	end
end)