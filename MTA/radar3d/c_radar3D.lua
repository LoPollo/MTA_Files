--
-- c_radar3D.lua
--

------------------------------------------------------------------------------------------------------------------
-- settings
------------------------------------------------------------------------------------------------------------------
local radarTab = {renderer = nil, renderTarget = nil, tiles = {}, custom = {tiles = {}, blips = {}}, enabled = false}
local scx, scy = guiGetScreenSize()

-- window settings
local windowSize = Vector2(200, 133)--Vector2(235, 150)
local blipSize = 12

windowSize = Vector2(windowSize.x * (scy / 600), windowSize.y * (scy / 600))
--local windowStart = Vector2(scx * 0.012, scy * 0.97 - windowSize.y)
local windowStart = Vector2(scx * 0.022, scy * 0.98 - windowSize.y)
blipSize = blipSize * (scy / 600)

-- color settings
local healthOkay = Vector3(102, 204, 102)
local healthBad = Vector3(200, 200, 0)
local healthCritical = Vector3(200, 0, 0)
local armorColor = Vector3(0, 102, 255)
local oxygenColor = Vector3(255, 255, 0)

-- 3D map settings
local backgroundColor = tocolor(125, 168, 210, 255) -- map background
local renderTargetColor = tocolor(255, 255, 255, 190) -- map tiles, zones
local rectangleColor = tocolor(0, 0, 0, 175)
local camHeight = Vector2(355, 555) -- #1 for ped #2 for veh
local camAngle = Vector2(-90, -60) -- #1 for ped #2 for veh
local arrowSize = 30 -- player arrow

-- don't touch
local clipDistance = Vector2(0.3, 8500)
local fieldOfView = 70


------------------------------------------------------------------------------------------------------------------
-- onClientResourceStart/Stop
------------------------------------------------------------------------------------------------------------------
addEventHandler("onClientResourceStart", resourceRoot, function()
	--setPlayerHudComponentVisible("radar", false)
	radarTab.renderer = nil
	radarTab.renderTarget = nil
	radarTab.enabled = createAllTileTextures()
	radarTab.renderTarget = DxRenderTarget(windowSize.x, windowSize.y, true)
	if radarTab.enabled and radarTab.renderTarget then 
		radarTab.renderer = CImg3DMan:create()
		if radarTab.renderer then
			radarTab.renderer:setScreenRes(scx, scy)
			radarTab.renderer:setFOV(fieldOfView)
			radarTab.renderer:setFovAspect(windowSize.y / windowSize.x)
			radarTab.renderer:setClipDistance(clipDistance.x, clipDistance.y)
			radarTab.enabled = true
		else
			outputChatBox('Radar3D: Create shader fail')
			radarTab.enabled = false
		end
	else
		outputChatBox('Radar3D: Create tile textures fail')
		destroyAllTileTextures()
	end
end
)

addEventHandler("onClientResourceStop", resourceRoot, function()
	setPlayerHudComponentVisible("radar", true)
	destroyAllTileTextures()
	if radarTab.renderer then
		radarTab.renderer:destroy()
	end
	if isElement(radarTab.renderTarget) then
		radarTab.renderTarget:destroy()
	end
end
)

------------------------------------------------------------------------------------------------------------------
-- render 3dRadar
------------------------------------------------------------------------------------------------------------------
local timeValue = 0
local tickCount = getTickCount()
addEventHandler("onClientPreRender", root, function()
	if tickCount + 25 > getTickCount() then return end
	tickCount = getTickCount()
	if localPlayer.vehicle and timeValue < 1 then
		timeValue = timeValue + 0.025
	end
	if not localPlayer.vehicle and timeValue > 0 then
		timeValue = timeValue - 0.025
	end
	if isPlayerHudComponentVisible("radar") then
		setPlayerHudComponentVisible("radar", false)
	end
end
)

addEventHandler("onClientRender", root, function()
	if not radarTab.enabled then return end

    -- draw stats and stuff
	local hudPos = Vector2(windowStart.x - math.floor(windowSize.x / 100) * 2, windowStart.y - math.floor(windowSize.y / 75) * 2)
	local hudSiz = Vector2(windowSize.x + math.floor(windowSize.x / 100) * 4, windowSize.y + math.floor(windowSize.y / 75) * (4 + 5-5))
	
	dxDrawRectangle(hudPos.x, hudPos.y, hudSiz.x, hudSiz.y, rectangleColor)
	
	--local health = math.max(math.min(getElementHealth(localPlayer) / (0.232018558500192 * getPedStat(localPlayer, 24) -32.018558511152), 1), 0)
	--local armor = math.max(math.min(getPedArmor(localPlayer) / 100, 1), 0)
	--local oxygen = math.max(math.min(getPedOxygenLevel(localPlayer) / (1.5 * getPedStat(localPlayer, 225) + 1000), 1), 0)
	
	--local r, g, b
	--if health >= 0.25 then
	--	r, g, b = interpolateBetween(healthBad.x, healthBad.y, healthBad.z, healthOkay.x, healthOkay.y, healthOkay.z, math.floor(health*20)/10, "InOutQuad")
	--else
	--	r, g, b = interpolateBetween(healthCritical.x, healthCritical.y, healthCritical.z, healthBad.x, healthBad.y, healthBad.z, math.floor(health*20)/10, "InOutQuad")
	--end
	
	--local col = tocolor(r, g, b, 190)
	--local bg = tocolor(r, g, b, 100)

	--local rad1Pos = Vector2(windowStart.x, windowStart.y + windowSize.y + math.floor((windowSize.y / 75) * 1.5))
	--local rad2Pos = Vector2(windowStart.x + math.floor(windowSize.x / 2 + windowSize.x / 200), windowStart.y + windowSize.y + math.floor((windowSize.y / 75) * 1.5))
	--local radSiz = Vector2(math.floor(windowSize.x / 2 - windowSize.x / 400), math.floor(windowSize.y / 75) *  4)
	
	--dxDrawRectangle(rad1Pos.x, rad1Pos.y, radSiz.x, radSiz.y, bg)
	--dxDrawRectangle(rad1Pos.x, rad1Pos.y, radSiz.x * health, radSiz.y, col)
	
	--if alwaysRenderOxygen or (oxygen < 1 or isElementInWater(localPlayer)) then
	--	local rad3PosX = windowStart.x + math.floor(windowSize.x * 0.75 + windowSize.x / 150)
	--	local rad3SizX = math.floor(windowSize.x / 4 - windowSize.x / 200)
	--	dxDrawRectangle(rad2Pos.x, rad2Pos.y, rad3SizX, radSiz.y, tocolor(armorColor.x, armorColor.y, armorColor.z, 100))
	--	dxDrawRectangle(rad2Pos.x, rad2Pos.y, armor * rad3SizX, radSiz.y, tocolor(armorColor.x, armorColor.y, armorColor.z, 190))
	--	dxDrawRectangle(rad3PosX, rad2Pos.y, rad3SizX, radSiz.y, tocolor(oxygenColor.x, oxygenColor.y, oxygenColor.z, 100))
	--	dxDrawRectangle(rad3PosX, rad2Pos.y, oxygen * rad3SizX, radSiz.y, tocolor(oxygenColor.x, oxygenColor.y, oxygenColor.z, 190))
	--else
	--	dxDrawRectangle(rad2Pos.x, rad2Pos.y, radSiz.x, radSiz.y, tocolor(armorColor.x, armorColor.y, armorColor.z, 100))
	--	dxDrawRectangle(rad2Pos.x, rad2Pos.y, armor * radSiz.x, radSiz.y, tocolor(armorColor.x, armorColor.y, armorColor.x, 190))
	--end	
	
	-- switch to 3d map render target
	dxSetRenderTarget(radarTab.renderTarget)
	dxDrawRectangle(0, 0, scx, scy, backgroundColor)
	
	-- get camera matrix
	local camMat = getCamera().matrix

	-- calculate radar view
	local altPosZ = camHeight.x + ((camHeight.y - camHeight.x) * (timeValue + 0.05))
	local altRotX = camAngle.x - ((camAngle.x - camAngle.y) * (timeValue + 0.05))
	local altRotZ = vec2Angle(camMat:getForward().x, camMat:getForward().y)

	-- create a matrix based on above
	local thisPos = camMat:getPosition()
	if isElement(localPlayer) then
		if isElementStreamedIn(localPlayer) then
			thisPos = localPlayer.matrix:getPosition()
		end
	end
	local viewMat = Matrix(Vector3(thisPos.x, thisPos.y, altPosZ), Vector3(altRotX, 0, altRotZ))
	local viewPos = viewMat:transformPosition(Vector3(0, 0, (-600 * ((viewMat:getRotation().x - 270) / 90))))

	--viewPos = camPos --viewMat = camMat -- view from camera
	
	-- update camera properities
	local plaPos = localPlayer:getPosition()
	local camFwVec = viewMat:getForward()
	local camUpVec = viewMat:getUp()
	local camZAngle = vec2Angle(camFwVec.x, camFwVec.y)	
	
	radarTab.renderer:setCameraForward(camFwVec)
	radarTab.renderer:setCameraUp(camUpVec)
	radarTab.renderer:setCameraPosition(viewPos)
	radarTab.renderer:setRotation(Vector3(0, 0, 0))
	radarTab.renderer:setBillboard(false)
	radarTab.renderer:setCullMode(2)	
	radarTab.renderer:setColor(Vector4(255, 255, 255, 255))
	
	-- draw map tiles	
	if localPlayer:getInterior() == 0 then	
		for x=0, 5, 1 do
			for y=0, 5, 1 do
				if getObiectToCameraAngle(radarTab.tiles[x][y].position, viewPos, camFwVec) < math.rad(110) then
					radarTab.renderer:setTexture(radarTab.tiles[x][y].texture)
					radarTab.renderer:setPosition(radarTab.tiles[x][y].position)
					radarTab.renderer:setSize(radarTab.tiles[x][y].size)
					radarTab.renderer:draw()
				end
			end	
		end
	end

	for k, v in ipairs(radarTab.custom.tiles) do
		if v.enabled then
			if localPlayer:getInterior() == v.interior then	
				if getObiectToCameraAngle(v.position, viewPos, camFwVec) < math.rad(110) then
					if isElement(v.texture) then
						radarTab.renderer:setTexture(v.texture)
						radarTab.renderer:setPosition(v.position)
						radarTab.renderer:setRotation(v.rotation)
						radarTab.renderer:setSize(v.size)
						radarTab.renderer:setColor(v.color)
						radarTab.renderer:setBillboard(v.isBillboard)
						radarTab.renderer:setCullMode(v.cull)
						radarTab.renderer:draw()
					end
				end
			end
		end
	end

	radarTab.renderer:setBillboard(false)
	radarTab.renderer:setCullMode(2)

	-- draw radar areas
	for k, v in ipairs(getElementsByType("radararea")) do
		local raPos = v:getPosition()
		local raSizX, raSizY = getRadarAreaSize(v) -- oop getSize returns only 1 float

		if v:getDimension() == localPlayer:getDimension() and v:getInterior() == localPlayer:getInterior() then	
			local bcR, bcG, bcB, bcA = v:getColor()
			bcA = math.min(bcA, 200)

			radarTab.renderer:setTexture(radarTab.boxTex)
			radarTab.renderer:setPosition(Vector3(raPos.x + raSizX / 2, raPos.y + raSizY / 2, 0))
			radarTab.renderer:setSize(Vector2(raSizX, raSizY))
			radarTab.renderer:setColor(Vector4(bcR, bcG, bcB, bcA))
			radarTab.renderer:draw()
		end
	end

	-- skip to original RT
	dxSetRenderTarget()	
	
	-- draw map
	dxDrawImage(windowStart.x, windowStart.y, windowSize.x, windowSize.y, radarTab.renderTarget, 0, 0, 0, renderTargetColor)
	
	-- get viewProjection matrix for screen position calculations
	local projTabMat = createProjectionMatrixTab(clipDistance.x, clipDistance.y, math.rad(fieldOfView), windowSize.y / windowSize.x)
	local viewTabMat = createViewMatrixTab(viewMat:getForward(), viewMat:getUp(), viewPos)
	local viewProjTabMat = matrixMultiplyTab(viewTabMat, projTabMat)

	-- get ped arrow size
	local camPlaDist = getDistanceBetweenPoints3D(plaPos.x, plaPos.y, 0, viewPos.x, viewPos.y, viewPos.z)
	local scalePlaDist = camPlaDist * 0.0034
	
	-- get arrow texture
	radarTab.renderer:setTexture(radarTab.arrowTex)
	
	-- get ped arrow yaw
	local plVec = localPlayer.matrix:getForward()
	local angle = vec2Angle(plVec.x, plVec.y)
	radarTab.renderer:setRotation(Vector3(0, 0, angle))

	-- set and clear map RT
	dxSetRenderTarget(radarTab.renderTarget, true)

	-- set the remaining renderer stuff for arrow
	radarTab.renderer:setPosition(Vector3(plaPos.x, plaPos.y, 0))
	radarTab.renderer:setSize(Vector2(arrowSize * scalePlaDist,arrowSize * scalePlaDist))
	radarTab.renderer:setColor(Vector4(255, 255, 255, 255))
	radarTab.renderer:setBillboard(false)
	radarTab.renderer:draw()
	
	-- skip to original RT
	dxSetRenderTarget()	

	-- draw blips
	for k, v in ipairs(getElementsByType("blip")) do
		local bliPos = v:getPosition()
		local actualDist = getDistanceBetweenPoints2D(plaPos.x, plaPos.y, bliPos.x, bliPos.y)
		local maxDist = v:getVisibleDistance()
		if actualDist <= maxDist and v:getDimension() == localPlayer:getDimension() and v:getInterior() == localPlayer:getInterior() then
			local bid = v:getData("customIcon") or v:getIcon()		
			local _, _, _, bcA = v:getColor()
			local bcR, bcG, bcB = 255, 255, 255
			if v:getIcon() == 0 then
				bcR, bcG, bcB = v:getColor()
			end
			local bS = v:getSize()
			
			bliPos = clampWorldPos2Angle(viewPos, Vector3(bliPos.x, bliPos.y, 0), camFwVec, fieldOfView * 0.57, false)
			local scPos = getScreenFrom3DPosition(bliPos, viewProjTabMat, windowSize)

			scPos.x = math.max(math.min(scPos.x, windowSize.x),0)
			scPos.y = math.max(math.min(scPos.y, windowSize.y),0)
			dxDrawImage(windowStart.x + scPos.x -(blipSize * bS) / 2, windowStart.y + scPos.y -(blipSize * bS) / 2, (blipSize * bS), (blipSize * bS), "tex/blip/"..bid..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA))
		end
	end
	
	-- draw custom blips
	for k, v in ipairs(radarTab.custom.blips) do
		if v.enabled then
			local bliPos = v.position
			local actualDist = getDistanceBetweenPoints2D(plaPos.x, plaPos.y, bliPos.x, bliPos.y)
			local maxDist = v.distance
			if actualDist <= maxDist and v.dimension == localPlayer:getDimension() and v.interior == localPlayer:getInterior() then
				if isElement(v.texture) then
					local bS = v.size
			
					bliPos = clampWorldPos2Angle(viewPos, Vector3(bliPos.x, bliPos.y, 0), camFwVec, fieldOfView * 0.57, false)
					local scPos = getScreenFrom3DPosition(bliPos, viewProjTabMat, windowSize)

					scPos.x = math.max(math.min(scPos.x, windowSize.x),0)
					scPos.y = math.max(math.min(scPos.y, windowSize.y),0)
			
					dxDrawImage(windowStart.x + scPos.x -(blipSize * bS) / 2, windowStart.y + scPos.y -(blipSize * bS) / 2, (blipSize * bS), (blipSize * bS), v.texture, 0, 0, 0, v.color)
				end
			end
		end
	end
	
	-- draw north icon			
	bliPos = clampWorldPos2Angle(viewPos, Vector3(viewPos.x, viewPos.y + 3000, 0), camFwVec, fieldOfView * 0.57, true)		
	local scPos = getScreenFrom3DPosition(bliPos, viewProjTabMat, windowSize)
	scPos.x = math.max(math.min(scPos.x, windowSize.x),0)
	scPos.y = math.max(math.min(scPos.y, windowSize.y),0)

	dxDrawImage(windowStart.x + scPos.x - (blipSize * 2) / 2, windowStart.y + scPos.y - (blipSize * 2) / 2, blipSize * 2, blipSize * 2, "tex/blip/4.png")
	
	-- draw the player arrow
	dxDrawImage(windowStart.x, windowStart.y, windowSize.x, windowSize.y, radarTab.renderTarget, 0, 0, 0)
end
)

------------------------------------------------------------------------------------------------------------------
-- tile textures
------------------------------------------------------------------------------------------------------------------
function createAllTileTextures()
	local isTexValid = true
	radarTab.tiles = {}
	for x=0, 5, 1 do
		radarTab.tiles[x] = {}
		for y=0, 5, 1 do
			radarTab.tiles[x][y] = {}
			radarTab.tiles[x][y].position = Vector3(-3000 + 1000 * x + 500, 3000 - 1000 * y - 500, 0)
			radarTab.tiles[x][y].size = Vector2(1000, 1000)
 			radarTab.tiles[x][y].texture = dxCreateTexture("tex/radar/tile_"..y.."_"..x..".dds")
			isTexValid = isElement(radarTab.tiles[x][y].texture) and isTexValid
		end	
	end
	radarTab.arrowTex = dxCreateTexture("tex/blip/2.png")
	radarTab.boxTex = dxCreateTexture("tex/blip/64.png")
	isTexValid = isElement(radarTab.arrowTex) and radarTab.boxTex and isTexValid
	return isTexValid
end

function destroyAllTileTextures()
	local isTexValid = true
	for x=0, 5, 1 do
		for y=0, 5, 1 do
			if isElement(radarTab.tiles[x][y].texture) then
				isTexValid = radarTab.tiles[x][y].texture:destroy() and isTexValid
			end
		end	
	end
	isTexValid = radarTab.arrowTex:destroy() and radarTab.boxTex:destroy() and isTexValid
	return isTexValid
end

------------------------------------------------------------------------------------------------------------------
-- exports handling
------------------------------------------------------------------------------------------------------------------
customBlip = {}
function customBlip.create(posX, posY, posZ, tTexture, size, colR, colG, colB, colA, visibleDistance)
	local w = findEmptyEntry(radarTab.custom.blips)
	radarTab.custom.blips[w] = {}
	radarTab.custom.blips[w].texture = tTexture
	radarTab.custom.blips[w].position = Vector3(posX, posY, posZ)
	radarTab.custom.blips[w].size = size
	radarTab.custom.blips[w].color = tocolor(colR, colG, colB, colA)
	radarTab.custom.blips[w].distance = visibleDistance
	radarTab.custom.blips[w].interior = 0
	radarTab.custom.blips[w].dimension = 0
	radarTab.custom.blips[w].enabled = true	
	return w
end

function customBlip.destroy(w)
	radarTab.custom.blips[w].enabled = false
	radarTab.custom.blips[w].tTexture = nil	
end

function customBlip.setTexture(w, tTexture)
	radarTab.custom.blips[w].tTexture = tTexture	
end

function customBlip.setPosition(w, posX, posY, posZ)
	radarTab.custom.blips[w].position = Vector3(posX, posY, posZ)
end

function customBlip.setColor(w, colR, colG, colB, colA)
	radarTab.custom.blips[w].color = tocolor(colR, colG, colB, colA)
end

function customBlip.setSize(w, size)
	radarTab.custom.blips[w].size = size
end

function customBlip.setDistance(w, dist)
	radarTab.custom.blips[w].distance = dist
end

function customBlip.setInterior(w, interior)
	radarTab.custom.blips[w].interior = interior
end

function customBlip.setDimension(w, dimension)
	radarTab.custom.blips[w].dimension = dimension
end

customTile = {}
function customTile.create(tTexture, posX, posY, posZ, rotX, rotY, rotZ, sizX, sizY, colR, colG, colB, colA , isBill)
	local w = findEmptyEntry(radarTab.custom.tiles)
	radarTab.custom.tiles[w] = {}
	radarTab.custom.tiles[w].texture = tTexture
	radarTab.custom.tiles[w].position = Vector3(posX, posY, posZ)
	radarTab.custom.tiles[w].rotation = Vector3(rotX, rotY, rotZ)
	radarTab.custom.tiles[w].size = Vector2(sizX, sizY)
	radarTab.custom.tiles[w].color = Vector4(colR, colG, colB, colA)
	radarTab.custom.tiles[w].isBillboard = isBill
	radarTab.custom.tiles[w].cull = 2
	radarTab.custom.tiles[w].interior = 0
	radarTab.custom.tiles[w].enabled = true	
	return w
end

function customTile.destroy(w)
	radarTab.custom.tiles[w].enabled = false
	radarTab.custom.tiles[w].tTexture = nil
end

function customTile.setTexture(w, tTexture)
	radarTab.custom.tiles[w].tTexture = tTexture
end

function customTile.setPosition(w, posX, posY, posZ)
	radarTab.custom.tiles[w].position = Vector3(posX, posY, posZ)
end

function customTile.setRotation(w, rotX, rotY, rotZ)
	radarTab.custom.tiles[w].rotation = Vector3(rotX, rotY, rotZ)
end

function customTile.setColor(w, colR, colG, colB, colA)
	radarTab.custom.tiles[w].color = Vector4(colR, colG, colB, colA)
end

function customBlip.setSize(w, sizeX, sizeY)
	radarTab.custom.blips[w].size = Vector3(sizeX, sizeY)
end

function customTile.setInterior(w, interior)
	radarTab.custom.tiles[w].interior = interior
end

function customTile.setBillboard(w, isBill)
	radarTab.custom.tiles[w].isBillboard = isBill
end

function customTile.setCullMode(w, cull)
	radarTab.custom.tiles[w].cull = cull
end
