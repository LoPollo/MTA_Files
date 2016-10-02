local event = nil

local mark = createMarker ( 0, 0, -10, "corona", 2.0, 255, 255, 255, 0)
local mark2 = createMarker (0, 0, -10, "corona", 2.0, 255, 255, 255, 255)

local dist = 150


function entering( thePlayer, seat )
	if thePlayer == localPlayer then
		local model = getElementModel ( source )
		if model == 425 or model == 520 or model == 476 then
			addEventHandler("onClientRender", root, marker)
			event = true 
			attachElements (mark, source, 0, dist, 0 )
	    end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), entering)

addEventHandler("onClientResourceStart", getRootElement(), function()
	local veh = getPedOccupiedVehicle( localPlayer )
	local model = veh and getElementModel(veh) or nil
	if model == 425 or model == 520 or model == 476 then
		addEventHandler("onClientRender", root, marker)
		event = true 
		attachElements (mark, getPedOccupiedVehicle( localPlayer ), 0, dist, 0 )
	end
end)

function exit( thePlayer, seat )
	if thePlayer == localPlayer then
		local model = getElementModel ( source )
		if model == 425 or model == 520 or model == 476 then
			if event ~= nil then
				removeEventHandler("onClientRender", root, marker)
				event = nil
				detachElements ( mark )
				setElementPosition (mark, 0, 0, -10)
				setElementPosition (mark2, 0, 0, -10)
			end
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), exit)


addEventHandler("onClientElementDestroy", getRootElement(), function ()
	if (getElementModel(source) == 425 or getElementModel(source) == 520 or model == 476) and getVehicleController(source) == localPlayer then
		if event ~= nil then
			removeEventHandler("onClientRender", root, marker)
			event = nil
			detachElements ( mark )
			setElementPosition (mark, 0, 0, -10)
			setElementPosition (mark2, 0, 0, -10)
		end
	end
end)


function wasted()
	if source == localPlayer then
		if event ~= nil then
			removeEventHandler("onClientRender", root, marker)
			event = nil
			detachElements ( mark )
			setElementPosition (mark, 0, 0, -10)
			setElementPosition (mark2, 0, 0, -10)
		end
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wasted )




function marker()
	local veh = getPedOccupiedVehicle ( localPlayer )
	local vx, vy, vz = getElementPosition(veh)

	local ex, ey, ez = getElementPosition(mark)

	local mh = false
	local mh, mx, my, mz = processLineOfSight ( vx, vy, vz, ex, ey, ez, true, true, true, true, true, false, false, false, veh )
	mx = mh and mx or ex
	my = mh and my or ey
	mz = mh and mz or ez
	setMarkerColor ( mark2, mh and 0 or 255, mh and 255 or 0, 0, mh and 255 or 192 )
	setMarkerSize ( mark2, mh and 6 or 4 )
	setElementPosition (mark2, mx, my, mz)
end