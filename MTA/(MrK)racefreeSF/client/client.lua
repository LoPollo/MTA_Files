name = getResourceName(resource).."_"

addEvent(name.."c_raceStart",true)
--l_markerposX={	-2006,	-2003,	-2157,	-2347,	-2507,	-2685,	-2778,	-2809,	-2853,	-2826,	-2847,	-2823,	-2878,	-2872,	-2666,	-2487,	-2455,	-2460,	-2318,	-2164,	-2116,	-1909,	-1861,	-1714,	-1614,	-1562,	-1627,	-1635,	-1714,	-1724,	-1859,	-2065,	-2213,	-2226,	-2274,	-2252,	-2252,	-2255,	-2156,	-2042,	-2006,	-2006,	-2004	}
--l_markerposY={	234,	298,	319,	303,	164,	157,	157,	286,	363,	553,	712,	871,	1029,	1205,	1290,	1376,	1263,	1214,	1176,	1176,	1176,	1177,	1253,	1291,	1194,	952,	909,	852,	791,	618,	605,	565,	566,	477,	398,	272,	83.0,	-47,	-70,	-70,	2.00,	105,	267.0	}
--l_marketposZ={	28.0,	34.0,	34.0,	37.0,	4.0,	3.0,	6.0,	6.0,	3.0,	4.0,	26.0,	43.0,	35.0,	5.0,	6.0,	6.0,	28.0,	34.0,	48.0,	55.0,	55.0,	44.0,	23.0,	6.0,	6.0,	6.0,	10.0,	9.0,	24.0,	24.0,	34.0,	34.0,	34.0,	34.0,	34.0,	34.0,	34.0,	34.0,	34.0,	34.0,	33.0,	27.0,	31.0	}
l_markerposX={ -2005.9, -2003.9, -2149.7, -2305.7, -2379.9, -2438.5, -2546.1, -2645.1, -2733.2, -2788.6, -2808.8, -2809.3, -2849.9, -2852.3, -2826.1, -2823.8, -2845.2, -2852.9, -2827.6, -2880, -2881.1, -2852, -2677.6, -2587.7, -2481.9, -2455.9, -2455.8, -2384.4, -2318.9, -2231.4, -2120.9, -1975.9, -1885.7, -1807.3, -1713, -1628.2, -1604.8, -1573.6, -1628.9, -1631.6, -1649.9, -1658.5, -1694.8, -1712.8, -1793.7, -1976.3, -2005, -2084.6, -2223, -2229.2, -2271.5, -2252.6, -2251.3, -2252.2, -2255, -2256.4, -2219.9, -2208.6, -2125.7, -2009.4, -2005.8, -2006.6, -2007.4, -2007.9, -2007.2 }
l_markerposY={ 257.1, 304.6, 319.5, 318.1, 277.7, 218.2, 158.8, 157.4, 157.4, 157.4, 221.1, 288.8, 345.1, 465.7, 558.1, 662.6, 710.4, 809.2, 954, 1044.1, 1123.4, 1229.9, 1289.9, 1344.8, 1376.5, 1307.8, 1239.7, 1176, 1176.1, 1176.4, 1176.5, 1175.8, 1203, 1271.1, 1292.8, 1211.3, 1110.4, 971.5, 904.4, 860.9, 838.4, 741.4, 728.4, 647.7, 605.5, 605, 586.3, 565.6, 562.6, 461.5, 401.9, 322.8, 214.5, 94.5, -47.1, -170, -192.2, -278.6, -292.1, -288.3, -219.4, -75.2, 29.5, 144, 222.5 }
l_marketposZ={ 30.2, 34.4, 34.7, 38.4, 32, 18, 3.8, 3.7, 6, 6.6, 6.6, 6.6, 3.9, 3.6, 4.9, 15.2, 26.4, 38.4, 43.5, 33.4, 22.6, 5, 6.6, 6.6, 6.6, 16.4, 34.8, 38.3, 48.3, 55.1, 55.1, 44.9, 42.5, 13.9, 6.6, 6.6, 6.6, 6.6, 10.7, 7.9, 15.2, 16.9, 23.4, 24.3, 32.5, 34.6, 34.6, 34.6, 34.6, 34.6, 34.3, 34.7, 34.7, 34.7, 34.7, 34.7, 34.8, 34.9, 35, 34.9, 35.3, 34.7, 32.4, 27.1, 27.4 }
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
