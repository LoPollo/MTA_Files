
local screenWidth, screenHeight = guiGetScreenSize()

-- settings
local bitDepth = 8 -- between 1 and 256
local tileFactor = 4 -- betweeb 1 and 64

local active = false

addEventHandler("onClientResourceStart", resourceRoot,
function()
    if getVersion().sortable < "1.5" then
        outputChatBox("Resource is not compatible with this client.")
        return
	else
		eightBitShader = dxCreateShader("shaders/eightBitShader.fx")
		screenSource = dxCreateScreenSource(screenWidth, screenHeight)
		
        if (not eightBitShader) or (not screenSource) then
            outputChatBox("Could not create 8Bit shader. Please use debugscript 3.")
        end
    end
end)




function updateScreen()
    if (eightBitShader) and (screenSource) then
        screenSource:update()
		
		local tiles = {screenWidth / tileFactor, screenHeight / tileFactor}
        
        eightBitShader:setValue("screenSource", screenSource)
        eightBitShader:setValue("bitDepth", bitDepth)
		eightBitShader:setValue("tiles", tiles)

        dxDrawImage(0, 0, screenWidth, screenHeight, eightBitShader)
    end
end
--addEventHandler("onClientHUDRender", root, updateScreen)


addEventHandler("onClientResourceStop", resourceRoot,
function()
	if (screenSource) then
		screenSource:destroy()
		screenSource = nil
	end
	
	if (eightBitShader) then
		eightBitShader:destroy()
		eightBitShader = nil
	end
end)


--[[function switch ( sourcePlayer, arg )
    if ( arg ) then
    	if (arg == "0" or arg == "off") then
    		removeEventHandler("onClientHUDRender", root , updateScreen)
    	elseif (arg == "1" or arg == "on") then
    		addEventHandler("onClientHUDRender", root, updateScreen)
    	end
    end
end]]
function switch ( sourcePlayer, arg )
	outputChatBox(active, sourcePlayer)
    if (active == true) then
    	removeEventHandler("onClientHUDRender", root , updateScreen)
    	active = false
    elseif (active == false) then
    	addEventHandler("onClientHUDRender", root, updateScreen)
    	active = true
    end
end
addCommandHandler ( "8bit", switch )