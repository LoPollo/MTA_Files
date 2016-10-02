-- *** THESE ARE THE SETTINGS. MODIFY IN META.XML ***

reloadTime = 5000 		-- for Rhino
reloadTimeHydra = 3000 	-- for Hydra
reloadTimeHunter = 2000 -- for Hunter
range = 2 				-- To increase range, set this value to 1. To decrease range, use 3. My code is optimized for 2.

local mx = 0
local my = 0
local mz = 0

--*** BETTER NOT TOUCH BELOW ***

event = nil
fired = false
drawHandler = nil
armedVehicles = {[425]=true, [520]=true, [432]=true}
w, h = guiGetScreenSize()
height = nil
endY = nil
r, g = 255, 0
time = 0

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z
end

function onStart()
	height = math.ceil(h / 50)
	if height < 19 then
		height = 19
	end
	endY = math.ceil((h/100)*6)
	corona = createMarker (0, 0, -10, "corona", 1.0, 200, 100, 0, 150)
	bindKey ( "mouse1", "down", toggleRhino )
	bindKey("vehicle_fire", "down", toggleHunter)
	bindKey("vehicle_secondary_fire", "down", toggleHunter)
	color = tocolor(255, 255, 255, 200)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)

function entering( thePlayer, seat )
if thePlayer == localPlayer then
	toggleControl ( "vehicle_fire", true )
	toggleControl ( "vehicle_secondary_fire", true )
	local model = getElementModel ( source )
	if model == 432 or model == 425 or model == 520 then
		drawHandler = addEventHandler("onClientRender", root, reloadFinished)
	end
	if model == 432 then
		toggleControl ( "vehicle_fire", false )
		toggleControl ( "vehicle_secondary_fire", false )
		addEventHandler("onClientRender", root, marker)
		event = true
    end
end
end
addEventHandler("onClientVehicleEnter", getRootElement(), entering)

function exit( thePlayer, seat )
if thePlayer == localPlayer then
	local model = getElementModel ( source )
	if model == 432 then
		if event ~= nil then
			removeEventHandler("onClientRender", root, marker)
			event = nil
		end
		toggleControl ( "vehicle_fire", true )
		toggleControl ( "vehicle_secondary_fire", true )
	end
end
end
addEventHandler("onClientVehicleExit", getRootElement(), exit)

addEventHandler("onClientElementDestroy", getRootElement(), function ()
if (getElementModel(source) == 432 and getVehicleController(source) == localPlayer) then
	if event ~= nil then
		removeEventHandler("onClientRender", root, marker)
		event = nil
	end
	toggleControl ( "vehicle_secondary_fire", true )
end
end)

function wasted()
	if source == localPlayer then
		if event ~= nil then
			removeEventHandler("onClientRender", root, marker)
			event = nil
		end
		toggleControl ( "vehicle_fire", true )
		toggleControl ( "vehicle_secondary_fire", true )
	end
end
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), wasted )

function clientResourceStop()
	toggleControl ( "vehicle_fire", true )
	toggleControl ( "vehicle_secondary_fire", true )
end
addEventHandler( "onClientResourceStop", getResourceRootElement(getThisResource()), clientResourceStop )

local excol

function toggleRhino()
if fired == false then
	if isPedInVehicle ( localPlayer ) and not isCursorShowing() then
		local veh = getPedOccupiedVehicle ( localPlayer )
		if (veh) then
			if ( getElementModel ( veh ) == 432 ) then
				fired = true
				local turX, turY, turZ = getElementPosition(veh)
				local cx,cy,cz = getVehicleComponentPosition( veh, "misc_a" )
				local x, y, z = getVehicleComponentPosition( veh, "misc_c" )
				local barrelX, barrelY, barrelZ = getPositionFromElementOffset(veh,cx,cy,cz)
				local muzzleX, muzzleY, muzzleZ = getPositionFromElementOffset(veh,x,y,z)
				local velX = (muzzleX - barrelX) /range
				local velY = (muzzleY - barrelY) /range
				local velZ = (muzzleZ - barrelZ) /range
				local vx, vy, vz = getElementVelocity(veh)
				setElementVelocity (veh, vx+(((velX/3)*(-1))/50), vy+(((velY/3)*(-1))/50), vz+(((velZ/3)*(-1))/50) ) --recoil
				--triggerServerEvent("TankShell",resourceRoot,veh,muzzleX,muzzleY,muzzleZ,velX,velY,velZ,dist, mx, my, mz)
				triggerEvent("TankShell",resourceRoot,veh,muzzleX,muzzleY,muzzleZ,velX,velY,velZ,dist)
				local dist = getDistanceBetweenPoints3D ( muzzleX, muzzleY, muzzleZ, mx, my, mz )
				local exx = mx
				local exy = my
				local exz = mz
				--setTimer(function()
				--		--createExplosion(exx, exy, exz, 10, false, 0.5, false)
				--		triggerServerEvent ( "DoExplosion", resourceRoot, exx,exy,exz,10)
				--	end,
				--math.max(50,dist*9.5), 1)
				removeEventHandler("onClientRender", root, reloadFinished)
				drawHandler = nil
				start = getTickCount()
				drawHandler = addEventHandler("onClientRender", root, reload)
				time = reloadTime
				soundTimer = setTimer(function() 
					--local sound = playSound("reload.mp3")
					--setSoundVolume(sound, 0.1)
					end,
				(reloadTime-1000+1000), 1)
			end
		end
	end
end
end

function toggleHunter(control)
--outputChatBox("called")
if isPedInVehicle(localPlayer) then
local model = getElementModel(getPedOccupiedVehicle(localPlayer))
if model == 425 and fired == false and control == "vehicle_fire" then
	fired = true
	setTimer(function()
		toggleControl ( "vehicle_fire", false )
	end, 100, 1)
	setTimer(function() 
		toggleControl ( "vehicle_fire", true )
		fired = false
	end, reloadTimeHunter, 1)
	removeEventHandler("onClientRender", root, reloadFinished)
	drawHandler = nil
	start = getTickCount()
	drawHandler = addEventHandler("onClientRender", root, reload)
	time = reloadTimeHunter
elseif model == 520 and fired == false and control == "vehicle_secondary_fire" then
	fired = true
	setTimer(function()
		toggleControl ( "vehicle_secondary_fire", false )
	end, 100, 1)
	setTimer(function() 
		toggleControl ( "vehicle_secondary_fire", true )
		fired = false
	end, reloadTimeHydra, 1)
	removeEventHandler("onClientRender", root, reloadFinished)
	drawHandler = nil
	start = getTickCount()
	drawHandler = addEventHandler("onClientRender", root, reload)
	time = reloadTimeHydra
end
end
end

function reload()
if not isPedInVehicle(localPlayer) then
	removeEventHandler("onClientRender", root, reload)
	drawHandler = nil
end
setMarkerColor ( corona, 255, 0, 0, 100 )
local getTime = (getTickCount()) - start
local height = math.ceil(h / 50)
if height < 19 then
	height = 19
end
dxDrawRectangle (0, h-endY-height-6, height+6, endY, tocolor(0,0,0,150), false)
local endY = math.ceil((h/100)*6)
endY = endY - 4
	if getTime <= time then
		endY = (getTime/time)*endY
	else
		removeEventHandler("onClientRender", root, reload)
		drawHandler = nil
		drawHandler = addEventHandler("onClientRender", root, reloadFinished)
		if getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 432 then
			local sfx = playSFX ( "genrl", 136, 72 )
			setSoundVolume (sfx, 1)
		end
		setMarkerColor ( corona, r, g, 0, 150 )
		start = nil
		fired = false
	end
	dxDrawRectangle (2, h-endY-height-8, height+2, endY, tocolor(220,0,0,150), false)
end

function reloadFinished()
if not isPedInVehicle(localPlayer) then
	removeEventHandler("onClientRender", root, reloadFinished)
	drawHandler = nil
else
	dxDrawRectangle (0, h-endY-height-6, height+6, endY, tocolor(0,0,0,150), false)
	dxDrawRectangle (2, h-endY-height-4, height+2, endY-4, tocolor(220,0,0,150), false)
end
end

function marker()
if not isPedInVehicle(localPlayer) then
	removeEventHandler("onClientRender", getRootElement(), marker)
	if isTimer(soundTimer) then
		killTimer(soundTimer)
	end
	fired = false
	drawHandler = nil
	setElementPosition (corona, 0, 0, -10)
else
	local vx, vy, vz = nil, nil, nil
	local cx, cy, cz = nil, nil, nil
	local veh = getPedOccupiedVehicle ( localPlayer )
	if veh then
		local x, y, z = getVehicleComponentPosition( veh, "misc_a" )
		cx, cy, cz = getPositionFromElementOffset( veh, x, y, z )
		x, y, z = getVehicleComponentPosition( veh, "misc_c" )
		vx, vy, vz = getPositionFromElementOffset( veh, x, y, z )
		if vx ~= nil then
		local velX = (vx - cx) /range
		local velY = (vy - cy) /range
		local velZ = (vz - cz) /range
		
		local vx1, vy1 = cx + (velX * 50 * 0.1), cy + (velY * 50 * 0.1)
		local vx2, vy2 = cx + (velX * 50 * 0.2), cy + (velY * 50 * 0.2)
		local vx3, vy3 = cx + (velX * 50 * 0.3), cy + (velY * 50 * 0.3)
		local vx4, vy4 = cx + (velX * 50 * 0.5), cy + (velY * 50 * 0.5)
		local vx5, vy5 = cx + (velX * 50 * 0.6), cy + (velY * 50 * 0.6)
		local vx6, vy6 = cx + (velX * 50 * 0.7), cy + (velY * 50 * 0.7)
		local vx7, vy7 = cx + (velX * 50 * 0.8), cy + (velY * 50 * 0.8)

		local m1 = cz + (velZ * 50 * 0.1) - ((getGravity()*2400*0.01)/2)
		local m2 = cz + (velZ * 50 * 0.2) - ((getGravity()*2400*0.04)/2)
		local m3 = cz + (velZ * 50 * 0.3) - ((getGravity()*2400*0.09)/2)
		local m4 = cz + (velZ * 50 * 0.5) - ((getGravity()*2400*0.25)/2)
		local m5 = cz + (velZ * 50 * 0.6) - ((getGravity()*2400*0.36)/2)
		local m6 = cz + (velZ * 50 * 0.7) - ((getGravity()*2400*0.49)/2)
		local m7 = cz + (velZ * 50 * 0.8) - ((getGravity()*2400*0.64)/2)
		
		local hit
		local elementHit
		hit, mx, my, mz, elementHit = processLineOfSight (cx, cy, cz, vx1, vy1, m1, true, true, true, true, true, false, false, false, veh)
		if hit == false then
			hit, mx, my, mz, elementHit = processLineOfSight (vx1, vy1, m1, vx2, vy2, m2, true, true, true, true, true, false, false, false, veh)
			if hit == false then
				hit, mx, my, mz, elementHit = processLineOfSight (vx2, vy2, m2, vx3, vy3, m3, true, true, true, true, true, false, false, false, veh)
				if hit == false then
					hit, mx, my, mz, elementHit = processLineOfSight (vx3, vy3, m3, vx4, vy4, m4, true, true, true, true, true, false, false, false, veh)
					if hit == false then
						hit, mx, my, mz, elementHit = processLineOfSight (vx4, vy4, m4, vx5, vy5, m5, true, true, true, true, true, false, false, false, veh)
						if hit == false then
							hit, mx, my, mz, elementHit = processLineOfSight (vx5, vy5, m5, vx6, vy6, m6, true, true, true, true, true, false, false, false, veh)
							if hit == false then
								hit, mx, my, mz, elementHit = processLineOfSight (vx6, vy6, m6, vx7, vy7, m7, true, true, true, true, true, false, false, false, veh)
								if hit == false then
									mx, my, mz = vx7, vy7, m7
								end
							end
						end
					end
				end
			end
		end
		local dist = getDistanceBetweenPoints3D ( vx, vy, vz, mx, my, mz )
		if dist < 50 then
			r = 5.1 * dist
			g = 255
		elseif dist >= 50 then
			r = 255
			g = 255 - ((dist-50) * 5.1)
		end
		setElementPosition (corona, mx, my, mz)
		setMarkerColor ( corona, r, g, 0, 150 )
		if not drawHandler then
			drawHandler = addEventHandler("onClientRender", root, reloadFinished)
		end
	end
	end
end
end

function projectileSound ( creator )
local zeType = getProjectileType( source )
if zeType == 21 then
	if getElementType(creator) == "vehicle" then
		if getElementModel(creator) == 432 then
			local velX, velY, velZ = getElementVelocity(source)
			local cx, cy, cz = getVehicleComponentPosition( creator, "misc_c" )
			cx, cy, cz = getPositionFromElementOffset(creator, cx, cy, cz)
			fxAddTankFire(cx, cy, cz, velX, velY, velZ)
			local sound1 = playSFX3D ( "genrl", 45, 2, cx, cy, cz )
			local sound2 = playSFX3D ( "genrl", 45, 3, cx, cy, cz )
			local sound3 =  playSFX3D ( "genrl", 45, 4, cx, cy, cz )
			setSoundMaxDistance( sound1, 300 )
			setSoundMaxDistance( sound2, 300 )
			setSoundMaxDistance( sound3, 200 )
			setSoundVolume(sound1, 2)
			setSoundVolume(sound2, 2)
			setSoundVolume(sound3, 2)
			--setElementModel(source, 342)
		end
	end
end
end
addEventHandler( "onClientProjectileCreation", getRootElement(), projectileSound )

function TankShellHandler(el,x,y,z,vx,vy,vz,distance)
	--outputChatBox("Client Trigger")
	bullet = createProjectile(el, 21, x, y, z, 0.5, nil, 0, 0, 0, vx, vy, vz)
	--setElementVelocity (bullet, 0, 0, 0 ) -- this doesn't work
	--outputChatBox(tostring(setElementVelocity (bullet, 0, 0, 10 )))
	setTimer(function(bullet)
		if isElement(bullet) and getElementType(bullet) == "projectile" then
			destroyElement(bullet)
			bullet = nil
		end
	end,reloadTime, 1, bullet) --make sure there is only 1 bullet at once
end
addEvent( "TankShell", true )
addEventHandler( "TankShell", resourceRoot, TankShellHandler)


function onHit()
	if getElementType(source) == "projectile" and source == bullet then
		local x, y, z = getElementPosition(source)
		triggerServerEvent ( "DoExplosion", resourceRoot, x, y, z,10)
	end
end
addEventHandler("onClientElementDestroy", root, onHit)