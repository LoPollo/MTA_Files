local screenWidth, screenHeight = guiGetScreenSize ( )
local _stuntType = nil
local _stuntTime = nil
local _stuntTimer = nil
local _killTimer = nil

addEventHandler( "onClientPlayerStuntStart", root,
    function ( stuntType )
        --outputChatBox( "You started stunt: " .. stuntType );
        _stuntType = stuntType
        _stuntTime = 0
        if isTimer(_killTimer) then
        	killTimer( _killTimer )
        	removeEventHandler("onClientRender", root, draw)
        end
        addEventHandler( "onClientRender", root, draw )
        _stuntTimer = setTimer( function() _stuntTime = _stuntTime + 0.1 end, 100, 0 )
    end
)

addEventHandler( "onClientPlayerStuntFinish", root,
    function ( stuntType, stuntTime, distance )
    	if isTimer( _stuntTimer ) then 
    		killTimer( _stuntTimer ) 
    	end
    	_killTimer = setTimer(function() removeEventHandler("onClientRender", root, draw) end, _stuntTime>0.5 and 1500 or 50, 1)
        --outputChatBox( "You finished stunt: " .. stuntType ..", Time: " .. tostring( stuntTime ) .. ", Distance: " .. tostring( distance ) );
    end
)

function draw()
	dxDrawText( 
				_stuntType..": ".._stuntTime.."s", screenWidth/2-200, screenHeight-50, screenWidth/2+200, screenHeight-20, tocolor ( 255, 255, 255, 255 ), 1.3,
    			"pricedown", "center", "center", false, false,
    			false, true, true,
    			0, 0, 0 
    )
end
