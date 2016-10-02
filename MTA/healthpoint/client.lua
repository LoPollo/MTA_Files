-- **************************************************
-- **
-- ** Name: Recarregar Vida
-- ** Author: ~#Blood, #RooTs
-- ** Version: 1.0.0
-- ** Date: 10/07/2016
-- ** File: client.lua
-- **
-- **************************************************


local vdp_Textura1 = dxCreateTexture("files/mark1.png")
local vdp_Textura2 = dxCreateTexture("files/mark2.png")
local vdp_Textura3 = dxCreateTexture("files/mark3.png")
local vdp_Textura4 = dxCreateTexture("files/mark4.png")

local renderTarget1 = dxCreateRenderTarget(1024, 1024, true)
local renderTarget2 = dxCreateRenderTarget(400, 20, true)

local vdp_Marker1 = createMarker(2041.71411, -1426.72, 16, "cylinder", 3, 0, 200, 255, 10)
local vdp_Marker2 = createMarker(2041.71411, -1426.72, 16, "cylinder", 1.5, 0, 0, 0, 0)

local r, g, b = 0, 200, 255

function vdpVidaCriar()
	dxSetRenderTarget(renderTarget1, true)
	dxDrawImage(250, 250, 274, 274, vdp_Textura1, getTickCount() / 10, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 274, 274, vdp_Textura2, getTickCount() / -15, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 274, 274, vdp_Textura3, getTickCount() / 50, 0, 0, tocolor(r, g, b, 200), false)
	dxDrawImage(250, 250, 274, 274, vdp_Textura4, getTickCount() / -100, 0, 0, tocolor(r, g, b, 200), false)
	dxSetRenderTarget()
	dxSetRenderTarget(renderTarget2, true)
	dxDrawRectangle(0, 0, 300, 20, tocolor(0, 0, 0, 150), false)
	dxDrawRectangle(0, 0, 300 / getPedMaxHealth(getLocalPlayer()) * math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596), 20, tocolor(r, g, b, 200), false)
	dxDrawText("HP: "..math.floor(getElementHealth(getLocalPlayer()) + 0.40000152596).."%", 0, 0, 300, 20, tocolor(255, 255, 255, 255), 1.2, "arial", "center", "center", true, true)
	dxSetRenderTarget()
	dxDrawMaterialLine3D(2040, -1432, 16.168, 2040, -1418, 16.168, renderTarget1, 14, tocolor(255, 255, 255, 255), 2040, -1432, 16.168 + 500000000)
	dxDrawMaterialLine3D(2039.99878, -1427.12, 16.168, 2039.79878, -1427.12, 16.168, renderTarget2, 3, tocolor(255, 255, 255, 255), 2039.99878, -1419.96094, 17.168 + 500000000)
end
addEventHandler("onClientRender", getRootElement(), vdpVidaCriar)

function vdpVidaMarkerEntrar(player)
	if (player == getLocalPlayer()) and (source == vdp_Marker2) then
		r, g, b = 0, 255, 255
		setMarkerColor(vdp_Marker1, 0, 255, 255, 10)
		setElementData(getLocalPlayer(), "Recarregar Vida", true)
	end
end
addEventHandler("onClientMarkerHit", getRootElement(), vdpVidaMarkerEntrar)

function vdpVidaMarkerSair(player)
	if (player == getLocalPlayer()) and (source == vdp_Marker2) then
		r, g, b = 0, 200, 255
		setMarkerColor(vdp_Marker1, 0, 200, 255, 10)
		setElementData(getLocalPlayer(), "Recarregar Vida", false)
	end
end
addEventHandler("onClientMarkerLeave", getRootElement(), vdpVidaMarkerSair)

setTimer(function(player)
	if (getElementData(getLocalPlayer(), "Recarregar Vida") == true) then
		if (isElementWithinMarker(getLocalPlayer(), vdp_Marker2)) then
			setElementHealth(getLocalPlayer(), getElementHealth(getLocalPlayer()) + 1)
		end
	end
end, 75, 0)

function getPedMaxHealth(ped)
	assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got "..tostring(ped).."]")
	local stat = getPedStat(ped, 24)
	local maxhealth = 100 + (stat - 569) / 4.31
	return math.max(1, maxhealth)
end