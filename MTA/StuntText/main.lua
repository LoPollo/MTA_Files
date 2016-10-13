local screenWidth, screenHeight = guiGetScreenSize ( )
local _stuntType = nil
local _stuntTimeStart = nil
local _stuntTime = nil
local _stuntDistance = nil

local coordX, coordY, coordZ = nil, nil, nil

local _stuntTimer = nil
local _killTimer = nil

addEventHandler( "onClientPlayerStuntStart", root,
    function ( stuntType )
    	if getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Plane" and getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Helicopter" and getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Boat" then
        	--outputChatBox( "You started stunt: " .. stuntType );
        	_stuntType = stuntType
        	_stuntTimeStart = getTickCount()
        	_stuntDistance = 0

        	if isTimer(_killTimer) then
        		killTimer( _killTimer )
        		removeEventHandler("onClientRender", root, draw)
        	end

        	_stuntTimer = setTimer( 
        		function() 
        			_stuntTime = getTickCount( ) - _stuntTimeStart
        		end
        	, 100, 0)

			coordX, coordY, coordZ = getElementPosition(getPedOccupiedVehicle( localPlayer ))

        	addEventHandler( "onClientRender", root, draw )
        end
    end
)

addEventHandler( "onClientPlayerStuntFinish", root,
    function ( stuntType, stuntTime, distance )
    	if getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Plane" and getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Helicopter" and getVehicleType( getPedOccupiedVehicle( localPlayer )) ~= "Boat" then
    		if isTimer( _stuntTimer ) then 
	    		killTimer( _stuntTimer ) 
	    	end
	
    		--if _stuntTime>350 then
    			_killTimer = setTimer(
    				function() 
    					removeEventHandler("onClientRender", root, draw) 
    				end
    			, 1500, 1)
    		--else
    		--	removeEventHandler("onClientRender", root, draw) 
    		--end
        	--outputChatBox( "You finished stunt: " .. stuntType ..", Time: " .. tostring( stuntTime ) .. ", Distance: " .. tostring( distance ) );
    	end
    end
)

function draw()
	if isTimer(_stuntTimer) then --currently stunting
		local newCoordX, newCoordY, newCoordZ = getElementPosition(getPedOccupiedVehicle(localPlayer))
		_stuntDistance = _stuntDistance + getDistanceBetweenPoints3D( newCoordX, newCoordY, newCoordZ, coordX, coordY, coordZ )
		coordX, coordY, coordZ = newCoordX, newCoordY, newCoordZ
	end
	dxDrawText( 
				_stuntType..": "..string.format("%.2f",(math.floor(_stuntTime/10)/100)).."s "..math.floor(_stuntDistance).."m", screenWidth/2-200, screenHeight-50, screenWidth/2+200, screenHeight-20, tocolor ( 255, 255, 255, 255 ), 1.3,
    			"pricedown", "center", "center", false, false,
    			false, true, true,
    			0, 0, 0 
    )
end