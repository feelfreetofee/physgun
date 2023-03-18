local netids = {}

function netid(entity)
	if not netids[entity] then
		netids[entity] = NetworkGetEntityFromNetworkId(entity)
	end
	return netids[entity]
end

RegisterNetEvent('alyxgun:PushEntity')
AddEventHandler('alyxgun:PushEntity', function(entity, x, y, z)
	SetEntityVelocity(netid(entity), x, y, z)
end)

RegisterNetEvent('alyxgun:MoveEntity')
AddEventHandler('alyxgun:MoveEntity', function(entity, x, y, z)
	SetEntityCoords(netid(entity), x, y, z)
end)

RegisterNetEvent('alyxgun:RotateEntity')
AddEventHandler('alyxgun:RotateEntity', function(entity, x, y, z)
	SetEntityRotation(netid(entity), x, y, z)
end)

RegisterNetEvent('alyxgun:FreezeEntity')
AddEventHandler('alyxgun:FreezeEntity', function(entity, freeze)
	FreezeEntityPosition(netid(entity), freeze)
end)