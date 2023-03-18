function notify(msg)
	AddTextEntry('alyxgun', msg)
	BeginTextCommandDisplayHelp('alyxgun')
	EndTextCommandDisplayHelp(0, false, false, 1500)
end

function raycast(distance)
	local world, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
	local start = world + normal
	local destination = world + normal * (distance or 500)
	local _, hit, coords, _, entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(start.x, start.y, start.z, destination.x, destination.y, destination.z, -1))
	if hit then
		return entity, coords
	end
end

table.insert(tools, {
	name = 'Physgun',
	action = function()
		local entity, coords = raycast()
		if entity and NetworkGetEntityIsNetworked(entity) then
			local netid = NetworkGetNetworkIdFromEntity(entity)
			TriggerServerEvent('alyxgun:FreezeEntity', netid, true)
			SetEntityAlpha(entity, 204)
			local distance = #(GetEntityCoords(PlayerPedId()) - coords)
			if distance < 0 then
				distance = -distance
			end
			while holding do
				if IsControlPressed(0, 14) then
					if distance > 0 then
						distance -= 1
					end
				elseif IsControlPressed(0, 15) then
					distance += 1
				end
				local world, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
				local pos = world + normal * distance
				TriggerServerEvent('alyxgun:MoveEntity', netid, pos.x, pos.y, pos.z)
				Wait(0)
			end
			TriggerServerEvent('alyxgun:FreezeEntity', netid)
			ResetEntityAlpha(entity)
			TriggerServerEvent('alyxgun:PushEntity', netid, 0, 0, 0.001)
		end
	end
})

table.insert(tools, {
	name = 'Super Jump',
	action = function()
		superJump = not superJump
		if not superJump then return end
		Citizen.CreateThread(function()
			local player = PlayerId()
			notify('Super Jump Enabled')
			while superJump do
				SetSuperJumpThisFrame(player)
				Wait(0)
			end
			notify('Super Jump Disabled')
		end)
	end
})

table.insert(tools, {
	name = 'Invisibility',
	action = function()
		local ped = PlayerPedId()
		SetEntityVisible(ped, not IsEntityVisible(ped))
	end
})

table.insert(tools, {
	name = 'Night Vision',
	action = function()
		SetNightvision(not GetUsingnightvision())
	end
})

table.insert(tools, {
	name = 'Heat Vision',
	action = function()
		SetSeethrough(not GetUsingseethrough())
	end
})

table.insert(tools, {
	name = 'Teleport',
	action = function()
		local entity, coords = raycast()
		if entity then
			SetEntityCoords(PlayerPedId(), coords.x, coords.y, coords.z)
		end
	end
})

table.insert(tools, {
	name = 'Explosion',
	action = function()
		local entity, coords = raycast()
		if entity then
			AddExplosion(coords.x, coords.y, coords.z, 0, 20.0)
		end
	end
})

table.insert(tools, {
	name = 'Light',
	action = function()
		local entity, coords = raycast()
		if entity then
			StartEntityFire(entity)
		end
	end
})

table.insert(tools, {
	name = 'Push',
	action = function()
		local entity, coords = raycast()
		if entity and NetworkGetEntityIsNetworked(entity) then
			TriggerServerEvent('alyxgun:PushEntity', NetworkGetNetworkIdFromEntity(entity), GetEntityForwardX(PlayerPedId()) * 100, GetEntityForwardY(PlayerPedId()) * 100, 20)
		end
	end
})

table.insert(tools, {
	name = 'Lift',
	action = function()
		local entity, coords = raycast()
		if entity and NetworkGetEntityIsNetworked(entity) then
			local vel = GetEntityVelocity(entity)
			TriggerServerEvent('alyxgun:PushEntity', NetworkGetNetworkIdFromEntity(entity), vel.x, vel.y, vel.z + 20)
		end
	end
})

table.insert(tools, {
	name = 'Reverse',
	action = function()
		local entity, coords = raycast()
		if entity and NetworkGetEntityIsNetworked(entity) then
			local vel = GetEntityVelocity(entity)
			TriggerServerEvent('alyxgun:PushEntity', NetworkGetNetworkIdFromEntity(entity), -vel.x * 5, -vel.y * 5, vel.z)
		end
	end
})