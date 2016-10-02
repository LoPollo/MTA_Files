if fileExists("codeClient.lua") then
	fileDelete("codeClient.lua")
end

local sX, sY = guiGetScreenSize()
--{"element neve", x, y}
local changeSizeUse = false
local dxFont = dxCreateFont("myriadproregular.ttf",15)

_getCursorPosition = getCursorPosition
function getCursorPosition()
	cX, cY = _getCursorPosition()
	cX, cY = cX*sX, cY*sY
	return cX, cY
end

function dobozbaVan(cx, cy, x, y, w, h)
	if cx > x and cx < x+w and cy > y and cy < y+h then
		return true
	else
		return false
	end
end

local counter = 0
local starttick
local currenttick

local showfps = false

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


addEventHandler ("onClientRender",root,
	function()
		if not starttick then
			starttick = getTickCount ()
		end
		counter = counter + 1
		currenttick = getTickCount ()
		if currenttick - starttick >= 1000 then
			setElementData (localPlayer, "FPS", counter)
			counter = 0
			starttick = false
		end
	end
)
 
fpstable = {}
function averageFPS()
	avgseconds = 10
	for i = 0, avgseconds do
		if i+1 <= avgseconds then
			fpstable[i+1] = fpstable[i]
		end
		fpstable[0] = getElementData (localPlayer, "FPS")
	end
	totalframes = 0
	for k, v in pairs(fpstable) do
		if v ~= false then
			totalframes = totalframes + v
		end
	end
	avgfps = math.round(totalframes / avgseconds, 0)
	setElementData (localPlayer, "avgfps", avgfps)
end
 
setTimer (averageFPS, 1000, 0)

local stat = dxGetStatus ( )
local szoveg = "#7CC576"
local szovegs ="#FFFFFF"
local hudElements = {{"showFPS", 10, 100, 75, 30}} 
addEventHandler("onClientRender", getRootElement(), function()
	if showfps then
	for i, k in ipairs(hudElements) do
		local x, y, w, h, m, r, ru = getElementData(localPlayer, k[1] .. "X") or k[2], getElementData(localPlayer, k[1] .. "Y") or k[3], getElementData(localPlayer, k[1] .. "W") or k[4], getElementData(localPlayer, k[1] .. "H") or k[5], getElementData(localPlayer,k[1] .. "Moving") or false, getElementData(localPlayer, k[1] .. "Resize") or false, getElementData(localPlayer, k[1] .. "ResizeUse") or false
		if k[1] == "showFPS" then
			dxDrawRectangle(x, y, w, h, tocolor(0, 0, 0, 0))
			dxDrawText(szovegs.. "#FFFFFF FPS: #7CC576" .. getElementData(localPlayer,"FPS"),x,y,w,h,tocolor(255,255,255,255),1,dxFont,"left","top",true,true,true,true,true)
			local fps = getElementData(localPlayer,"FPS")
			if fps <= 100 then
				fpscolor = "#7CC576"
			elseif fps < 100 and fps <= 30 then
				fpscolor = "#7CC576"
			elseif fps < 30 then
				fpscolor = "#7CC576"
			end 
			
			dxDrawText(szovegs.."#FFFFFF FPS: #7CC576" .. getElementData(localPlayer,"FPS"),x+1,y+1,w,h,tocolor(255,255,255,255),1,dxFont,"left","top",true,true,true,true,true)
			if m then
				local cX, cY = getCursorPosition()
				dxDrawRectangle(x, y, w, h, tocolor(166,196,103, 125))
				setElementData(localPlayer, k[1] .. "X", cX-defX)
				setElementData(localPlayer, k[1] .. "Y", cY-defY) 
			end
		else
			  dxDrawRectangle(x, y, w, h, tocolor(0, 0, 0, 125))
			if m then
				local cX, cY = getCursorPosition()
				dxDrawRectangle(x, y, w, h, tocolor(166,196,103, 125))
				setElementData(localPlayer, k[1] .. "X", cX-defX)
				setElementData(localPlayer, k[1] .. "Y", cY-defY)
			end
		end
	end
	end
end)

addEventHandler("onClientClick", getRootElement(), function(button, state, aX, aY, wX, wY, wZ, element)
	if showfps then
	if button == "left" then
		if state == "down" then
			for i, k in ipairs(hudElements) do
				local x, y, w, h, r = getElementData(localPlayer, k[1] .. "X") or k[2], getElementData(localPlayer, k[1] .. "Y") or k[3], getElementData(localPlayer, k[1] .. "W") or k[4], getElementData(localPlayer, k[1] .. "H") or k[5], getElementData(localPlayer, k[1] .. "Resize") or false
				local cX, cY = getCursorPosition()
				if dobozbaVan(cX, cY, x, y, w, h) then
					setElementData(localPlayer, k[1] .. "Moving", true)
					defX, defY = cX-x, cY-y
				end
			end
		elseif state == "up" then
			for i, k in ipairs(hudElements) do
				local m, r = getElementData(localPlayer,k[1] .. "Moving") or false, getElementData(localPlayer, k[1] .. "Resize") or false
				if m then
					setElementData(localPlayer, k[1].. "Moving", false)
				end
			end
		end
	end
	end
end)

function showFPSed()
	if not showfps then
		showfps = true
	else
		showfps = false
	end
end
addCommandHandler("showfps",showFPSed)
addCommandHandler("fps",showFPSed)

addEventHandler("onClientResourceStart", resourceRoot, function()
	local asd = jsonGET("fps_pos",false)
	if asd[1] and asd[2] and asd[3] then
		for v,k in ipairs(hudElements) do
			if k[1] == "showFPS" then
				defX = tonumber(asd[1])
				defY = tonumber(asd[2])
				setElementData(localPlayer,k[1].. "X",defX)
				setElementData(localPlayer,k[1].. "Y",defY)	
				setElementData(localPlayer,k[1].. "Moving",false)
			--	showfps = asd[3]
			end
		end
	end
end)

function saveInventoryPosition()
	for v,k in ipairs(hudElements) do
		if k[1] == "showFPS" then
			local x,y = getElementData(localPlayer, k[1] .. "X"), getElementData(localPlayer, k[1] .. "Y")
			jsonSAVE("fps_pos", {x, y}, false)
		end
	end
end

setTimer(function()
saveInventoryPosition()
end,1000,0)


local _toJSON = toJSON
function toJSON(str)
	return _toJSON(str)
end

local _fromJSON = fromJSON
function fromJSON(str)
	return _fromJSON(str)
end

function jsonGET(file, private)
	if private then
		file = "@JSON_FILES/"..file..".json"
	else
		file = "JSON_FILES/"..file..".json"
	end
	local fileHandle
	local jsonDATA = {}
	if not fileExists(file) then
		return {}
	else
		fileHandle = fileOpen(file)
	end
	if fileHandle then
		local buffer
		local allBuffer = ""
		while not fileIsEOF(fileHandle) do
			buffer = fileRead(fileHandle, 500)
			allBuffer = allBuffer..buffer
		end
		jsonDATA = fromJSON(allBuffer)
		fileClose(fileHandle)
	end
	return jsonDATA
end

function jsonSAVE(file, data, private)
	if private then
		file = "@JSON_FILES/"..file..".json"
	else
		file = "JSON_FILES/"..file..".json"
	end
	if fileExists(file) then
		fileDelete(file)
	end
	local fileHandle = fileCreate(file)
	--if not fileHandle then return end
	fileWrite(fileHandle, toJSON(data))
	fileFlush(fileHandle)
	fileClose(fileHandle)
	return true
end
