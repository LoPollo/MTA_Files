local marker = {}

function onPDamage()
	if getElementData (source, "greenzone") then
		cancelEvent()
	end
end
addEventHandler ("onClientPlayerDamage", localPlayer, onPDamage)

function onPSKill(target)
	if getElementData (target, "greenzone") then
		cancelEvent()
	end
end
addEventHandler ("onClientPlayerStealthKill", localPlayer, onPSKill)

function renderGreenzoneTag()
	local streamedPlayers = getElementsByType ("player", root, true)
	if streamedPlayers and #streamedPlayers ~= 0 then
		local lpos = {getElementPosition(localPlayer)}
		for _,p in ipairs (streamedPlayers) do
			if p and isElement (p) then
				if getElementData (p, "greenzone") then
					local ppos = {getElementPosition(p)}
					if getDistanceBetweenPoints3D (lpos[1], lpos[2], lpos[3], ppos[1], ppos[2], ppos[3]) <= 50 then
						if marker[p] == nil and getPedOccupiedVehicle(p) == false then
							marker[p] = createMarker ( ppos[1], ppos[2], ppos[3], "cylinder", 2.0,  0, 220, 0, 255 )
							setElementAlpha ( marker[p], 32 )
							attachElements ( marker[p], p , 0 ,0 , -1 )
						end
						if getPedOccupiedVehicle(p) and isElement ( marker[p] ) then
							detachElements ( marker[p] )
							destroyElement ( marker[p] )
							marker[p] = nil
						end
						--[[local x, y = getScreenFromWorldPosition (ppos[1], ppos[2], ppos[3])
						if x and y then
							dxDrawText ("Greenzone protected", x+1, y+1, x, y, tocolor (0, 0, 0), 0.5, "bankgothic", "center")
							dxDrawText ("Greenzone protected", x, y, x, y, tocolor (0, 220, 0), 0.5, "bankgothic", "center")
						end]]
					end
				else
					if isElement ( marker[p] ) then
						detachElements ( marker[p] )
						destroyElement ( marker[p] )
						marker[p] = nil
					end
				end
			end
		end
	end
end
addEventHandler ("onClientHUDRender", root, renderGreenzoneTag)

function onQuitGame( reason )
	local p = source
	--outputChatBox ( getPlayerName( source ).." has left the server ("..reason..")" )
	if not (marker[p] == nil) then
    	detachElements ( marker[p] )
		destroyElement ( marker[p] )
		marker[p] = nil
	end
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )