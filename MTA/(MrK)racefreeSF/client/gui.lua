
addEvent(name.."g_raceStart",true)
addEvent(name.."g_start",true)
addEvent(name.."g_show",true)
addEvent(name.."g_reset",true)
addEvent(name.."g_exit",true)
addEvent(name.."g_posShow",true)
g_id=nil

function g_pos(num)
	guiSetText(g_posbar,"Pos: "..num.."/"..l_player)
end
addEventHandler(name.."g_posShow",getLocalPlayer(),g_pos)

function g_vote(button)
	if(button=="left")then
		triggerServerEvent(name.."s_vote",localPlayer)
--		outputChatBox("sss")
	end
end

function g_cancel(button)
	if(button=="left")then
		triggerServerEvent(name.."s_finish",localPlayer,localPlayer,0,g_id)
--		outputChatBox("sss")
	end
	guiSetVisible(g_winlog,false)
	showCursor(false,false)
end

function g_votereset()
	if(isElement(g_listlog))then
		destroyElement(g_winlog)
		destroyElement(g_listlog)
		destroyElement(g_listbtn)
		removeEventHandler("onClientGUIClick",g_listbtn,g_vote,false)
	end
	g_win()
end
addEventHandler(name.."g_reset",getRootElement(),g_votereset)

function g_win()
--	outputChatBox("Welcome!!!!!!~~~(debugstring)")
	g_winlog=guiCreateWindow(0.25,0.25,0.5,0.5,"Race",true)
	g_listlog=guiCreateGridList(0.04,0.04,0.92,0.76,true,g_winlog)
	guiGridListSetSelectionMode(g_listlog,0)
	g_listclm=guiGridListAddColumn(g_listlog,"Player(s)",0.48)
	g_listclm2=guiGridListAddColumn(g_listlog,"Car",0.48)
	g_listbtn=guiCreateButton(0.75,0.85,0.2,0.1,"Vote Start",true,g_winlog)
	g_listbtn2=guiCreateButton(0.5,0.85,0.2,0.1,"Cancel",true,g_winlog)
	addEventHandler("onClientGUIClick",g_listbtn,g_vote,false)
	addEventHandler("onClientGUIClick",g_listbtn2,g_cancel,false)
	guiSetVisible(g_winlog,false)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),g_win)

function g_startgui(list)
	--outputChatBox(name.."g_start")
	local g_listrow=guiGridListAddRow(g_listlog)
	guiGridListSetItemText(g_listlog,g_listrow,g_listclm,getPlayerName(list),false,false)
	guiGridListSetItemText(g_listlog,g_listrow,g_listclm2,getVehicleName(getPedOccupiedVehicle(list)),false,false)
	if(list==localPlayer)then
		g_id=g_listrow
	end
end
addEventHandler(name.."g_start",getRootElement(),g_startgui)

function g_edit(id)
	guiGridListRemoveRow(g_listlog,id)
end
addEventHandler(name.."g_exit",getRootElement(),g_edit)

function g_showwin()
	--outputChatBox(name.."g_show")
	guiSetVisible(g_winlog,true)
	showCursor(true,false)
end
addEventHandler(name.."g_show",getLocalPlayer(),g_showwin)

function g_prolabel(num)
	if(not isElement(g_posbar))then
		g_posbar=guiCreateLabel(0.05,0.3,0.4,0.4,"Pos: 0/"..l_player,true)
		guiSetFont(g_posbar,"sa-gothic")
	end
	if(not isElement(g_chklbl))then
		g_chklbl=guiCreateLabel(0.333,0.8125,0.25,0.0625,"",true)
		guiSetFont(g_chklbl,"sa-header")
	end
	guiSetText(g_chklbl,"Chekpoint: "..num.."/"..CPnumbers)
	if(num==CPnumbers)then
		setTimer(function()destroyElement(g_chklbl)end,1500,1)
	end
end

function g_progress(num)
	if(num=="max")then
		--num=tonumber(CPnumbers)
		setTimer(function()destroyElement(g_probar)destroyElement(g_posbar)end,500,1)
		setTimer(function()destroyElement(g_chklbl)end,500,1)
		destroyElement(l_marker[l_target])
		destroyElement(l_marker[l_target+1])
		destroyElement(l_blip[l_target])
		setPedCanBeKnockedOffBike(localPlayer,true)
		return
	end
	g_prolabel(num)
	if(not isElement(g_probar))then
		g_probar=guiCreateProgressBar(0.333,0.875,0.333,0.0625,true)
		setPedCanBeKnockedOffBike(localPlayer,false)
--		outputChatBox("Race Started")
	end
	guiProgressBarSetProgress(g_probar,(100.000/CPnumbers)*num)
	if(num==CPnumbers)then
		setPedCanBeKnockedOffBike(localPlayer,true)
		setTimer(function()destroyElement(g_probar)destroyElement(g_posbar)end,1500,1)
	end
end
addEventHandler(name.."g_raceStart",getLocalPlayer(),g_progress)