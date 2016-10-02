name = getResourceName(resource).."_"

addEvent(name.."c_raceStart",true)
l_markerposX={	-1382, 	-1342, 	-1278, 	-1186,	-1101,	-973,	-905,	-883,	-491,	-387,	-478,	-451,	-415,	-376,	-454,	-405,	-243,	-103,	90.0,	149,	228,	358,	405,	620,	662,	648,	777,	564,	412,	152,	-15,	-269,	-441,	-649,	-933,	-1281,	-1406,	-1438,	-1415}
l_markerposY={	2244, 	2124, 	1939, 	1834,	1813,	1837,	1792,	1971,	1992,	2081,	1943,	1759,	1920,	1797,	1588,	1338,	1240,	1257,	1231,	1164,	1195,	1443,	1587,	1738,	1935,	2511,	2648,	2657,	2698,	2740,	2639,	2633,	2719,	2750,	2720,	2663,	2543,	2391,	2316}
l_marketposZ={	55.0,	48.0,	44.5,	42.0,	44.0,	62.0,	60.0,	60.0,	60.0,	61.0,	86.0,	72.0,	57.0,	48.0,	36.0,	28.0,	24.0,	16.0,	20.0,	15.0,	15.0,	8.0,	18.0,	6.0,	5.0,	31.0,	16.0,	44.0,	60.0,	55.0,	63.0,	63.0,	63.0,	61.0,	46.0,	49.0,	61.0,	54.0,	54.0}
l_marker={}
l_blip={}
l_target=0
l_count=nil
l_racecar=nil
l_player=nil
local mSize = 10.0 --marker size

CPnumbers = 0
for Index, Value in pairs( l_markerposX ) do
  CPnumbers = CPnumbers + 1
end
--outputChatBox("There are "..CPnumbers.." checkpoints!")
function f_race(who,is)
	if(l_target>0)and(l_racecar~=nil)and(l_marker[l_target]==source)and(getPedOccupiedVehicle(who)==l_racecar)then
		triggerServerEvent(name.."s_checkpos",who,l_target)
		--outputChatBox("Checkpoint "..l_target.." Reached!")
		playSoundFrontEnd(43)
		destroyElement(source)
		destroyElement(l_blip[l_target])
		if(l_target<tonumber(CPnumbers)-1)then
			l_blip[l_target+1]=createBlipAttachedTo(l_marker[l_target+1],19)
			l_marker[l_target+2]=createMarker(l_markerposX[l_target+2],l_markerposY[l_target+2],l_marketposZ[l_target+2],"checkpoint",mSize,255,0,0,255)
			addEventHandler("onClientMarkerHit",l_marker[l_target+2],f_race)
			setMarkerTarget(l_marker[l_target+1],l_markerposX[l_target+2],l_markerposY[l_target+2],l_marketposZ[l_target+2]+0.3)
			l_target=l_target+1
		elseif(l_target == tonumber(CPnumbers)-1)then
			l_blip[l_target+1]=createBlipAttachedTo(l_marker[l_target+1],53)
			l_target=l_target+1
		elseif(l_target == tonumber(CPnumbers))then
			l_target=l_target+1
			playSound("sound/mission_accomplished.mp3")
			triggerServerEvent(name.."s_finish",who,who,1)
		end
		triggerEvent(name.."g_raceStart",localPlayer,l_target-1)
	end
end

function f_raceStart(num)
	l_player=num
	guiSetVisible(g_winlog,false)
	showCursor(false,false)
	l_racecar=getPedOccupiedVehicle(localPlayer)
	l_target=1
	l_count=4
	setTimer ( function()
		l_count=l_count-1
		if(l_count==3)then
			g_cntdwn=guiCreateLabel(0.5,0.4375,0.125,0.125,"3",true)
			guiSetFont(g_cntdwn,"sa-gothic")
			playSoundFrontEnd(44)
		elseif(l_count>0)then
			guiSetText(g_cntdwn,tostring(l_count))
			playSoundFrontEnd(44)
		elseif(l_count==0)then
			guiSetPosition(g_cntdwn,0.46875,0.4375,true)
			guiSetText(g_cntdwn,"GO")		
			playSoundFrontEnd(45)
		end
--		outputChatBox(tostring(l_count))
	end, 1000, 4 )
	setTimer(function()
		triggerServerEvent(name.."s_startEngine",localPlayer)
	end,4000,1)
	setTimer(function()
		destroyElement(g_cntdwn)
	end,5000,1)
	outputChatBox("Vehicle: "..getVehicleName(l_racecar))
	outputChatBox("Driver: "..getPlayerName(localPlayer))
	triggerEvent(name.."g_raceStart",localPlayer,l_target-1)
	for i=1,2,1 do
		l_marker[i]=createMarker(l_markerposX[i],l_markerposY[i],l_marketposZ[i],"checkpoint",mSize,255,0,0,255)
		addEventHandler("onClientMarkerHit",l_marker[i],f_race)
		if(i<2)then
			l_blip[i]=createBlipAttachedTo(l_marker[i],19)
			setMarkerTarget(l_marker[i],l_markerposX[i+1],l_markerposY[i+1],l_marketposZ[l_target+2]+0.3)
		end
	end
end
addEventHandler(name.."c_raceStart",getRootElement(),f_raceStart)
