addEvent( "onSpawnCam", true )
function CamView(x, y, z, rot, skin, interior, dimension, team)
	--if source == localPlayer then
		--local x, y, z = getElementPosition( localPlayer )
		--local rotX, rotY, rotZ = getElementRotation( localPlayer )
		--outputChatBox( rot )
		setTimer( 
			function(x, y, z, rot, skin, interior, dimension, team)
				smoothMoveCamera(x - math.cos((rot+90)/90*3.14/2) * 5.5, y - math.sin((rot+90)/90*3.14/2) * 5.5, z+700,x,y,z+2,x - math.cos((rot+90)/90*3.14/2) * 5.5, y - math.sin((rot+90)/90*3.14/2) * 5.5,z+1,x,y,z+0.5,1500)
				setTimer( 
					function()
						setCameraTarget( localPlayer, localPlayer )
					end, 
				1520, 1)
			end, 
		50, 1,  x, y, z, rot, skin, interior, dimension, team )
	--end
end

addEventHandler ( "onSpawnCam", localPlayer, CamView )

local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil
 
local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1)then return false end
	sm.object1 = createObject(1337,x1,y1,z1)
	sm.object2 = createObject(1337,x1t,y1t,z1t)
	setElementDimension( sm.object1, 1 )
	setElementDimension( sm.object2, 1 )
	setElementAlpha(sm.object1,0)
	setElementAlpha(sm.object2,0)
	setObjectScale(sm.object1,0.01)
	setObjectScale(sm.object2,0.01)
	moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
	moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
	sm.moov = 1
	setTimer(removeCamHandler,time,1)
	setTimer(destroyElement,time,1,sm.object1)
	setTimer(destroyElement,time,1,sm.object2)
	return true
end