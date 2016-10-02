addEvent( "onRaceStart", true)
addEvent( "onPlayerWastedInRace", true )
addEvent( "onRaceJoin", true )
addEvent( "onPlayerInRaceQuit", true )

local window = nil
local racePlayersGridlist = nil
local joinVoteButton = nil
local joinCloseButton = nil
local raceCheckpoints = {}
local currentCheckpoint = nil

function raceStart(checkpoints)
	showJoinGUI(false)
	local countDown = 3
	playSoundFrontEnd( 44 )
	setTimer( playSoundFrontEnd, 1000, 1, 44 )
	setTimer( playSoundFrontEnd, 2000, 1, 44 )
	setTimer( playSoundFrontEnd, 3000, 1, 45 )
	raceCheckpoints = checkpoints
	currentCheckpoint = 0
	handleCheckPoints()
end
addEventHandler( "onRaceStart", localPlayer, raceStart)
function handleCheckPoints()
	currentCheckpoint = 0
	raceCheckpoints[1][4] = createMarker( raceCheckpoints[1][1], raceCheckpoints[1][2], raceCheckpoints[1][3], "checkpoint", 4.0, 255, 0, 0, 255, localPlayer )
	setMarkerTarget ( raceCheckpoints[1][4], raceCheckpoints[2][1], raceCheckpoints[2][2], raceCheckpoints[2][3] )
	raceCheckpoints[2][4] = createMarker( raceCheckpoints[2][1], raceCheckpoints[2][2], raceCheckpoints[2][3], "checkpoint", 4.0, 255, 0, 0, 255, localPlayer )
	addEventHandler( "onClientMarkerHit", resourceRoot, checkpointHit )
end

function checkpointHit(hitPlayer, matchingDimension)
	if currentCheckpoint <= table.length(raceCheckpoints) then
		if source == raceCheckpoints[currentCheckpoint+1][4] then
			if not currentCheckpoint == table.length(raceCheckpoints) then playSoundFrontEnd( 43 ) end
			currentCheckpoint = currentCheckpoint + 1
			destroyElement( raceCheckpoints[currentCheckpoint][4] )
			if currentCheckpoint+2 <= table.length(raceCheckpoints) then
				setMarkerTarget ( raceCheckpoints[currentCheckpoint+1][4], raceCheckpoints[currentCheckpoint+2][1], raceCheckpoints[currentCheckpoint+2][2], raceCheckpoints[currentCheckpoint+2][3] )
				raceCheckpoints[currentCheckpoint+2][4] = createMarker( raceCheckpoints[currentCheckpoint+2][1], raceCheckpoints[currentCheckpoint+2][2], raceCheckpoints[currentCheckpoint+2][3], "checkpoint", 4.0, 255, 0, 0, 255, localPlayer )
			end
			if currentCheckpoint+2 == table.length(raceCheckpoints) then
				setMarkerIcon ( raceCheckpoints[currentCheckpoint+2][4], "finish" )
			end
			if currentCheckpoint == table.length(raceCheckpoints) then
				playSoundFrontEnd( 43 )
				outputChatBox( "end of race... now handle this" )
				raceCheckpoints = nil
			end
		end
	end
end

function showJoinGUI(state)
	if not window then
		createJoinGUI()
	end
	if state then--show
		showCursor( true )
		guiSetVisible( window, true )
	else--hide
		showCursor( false )
		guiSetVisible( window, false )
	end
end

function raceJoinHandler(playerVehTable)
	outputChatBox( "raceJoinHandler called" )
	if source == localPlayer then
		showJoinGUI(true)
	end
	refreshGridList(playerVehTable)
end
addEventHandler( "onRaceJoin", localPlayer, raceJoinHandler)

function createJoinGUI()
	local screenW, screenH = guiGetScreenSize()
	window = guiCreateWindow((screenW - 438) / 2, (screenH - 311) / 2, 438, 311, "Race", false)
	guiWindowSetSizable(window, false)

	racePlayersGridlist = guiCreateGridList(0.03, 0.09, 0.95, 0.75, true, window)
	guiGridListAddColumn(racePlayersGridlist, "Player", 0.5)
	guiGridListAddColumn(racePlayersGridlist, "Vehicle", 0.5)
	joinVoteButton = guiCreateButton(0.51, 0.87, 0.47, 0.10, "Vote start!", true, window)
	addEventHandler( "onClientGUIClick", joinVoteButton, joinVoteButtonClick)
	joinCloseButton = guiCreateButton(0.02, 0.87, 0.47, 0.10, "Quit", true, window)
	addEventHandler( "onClientGUIClick", joinCloseButton, joinCloseButtonClick)
	guiSetVisible( window, false )
end

function joinVoteButtonClick(button, state, absoluteX, absoluteY)
	outputChatBox(tostring( triggerServerEvent( "onRaceJoinVote", localPlayer)))
end

function joinCloseButtonClick(button, state, absoluteX, absoluteY)
	showJoinGUI(false)
	triggerServerEvent( "onRaceJoinQuit", localPlayer, localPlayer, "joinQuit" )
end



function opponentQuit(playerVehTable)
	refreshGridList(playerVehTable)
end
addEventHandler( "onPlayerInRaceQuit", localPlayer, opponentQuit )

function refreshGridList(playerVehTable)
	--reset gridlist
	for i=0,guiGridListGetRowCount ( racePlayersGridlist ) do 
		guiGridListRemoveRow ( racePlayersGridlist, i )
	end
	--and add the players
	for k,v in pairs(playerVehTable) do
		local rowIndex = guiGridListAddRow( racePlayersGridlist )
		guiGridListSetItemText ( racePlayersGridlist, rowIndex, 1, getPlayerName( k ), false, false )
		guiGridListSetItemText ( racePlayersGridlist, rowIndex, 2, getVehicleName( v ), false, false )
	end
end

function table.length(table)
	local count = 0
	for k,v in pairs(table) do
		count = count + 1
	end
	return count
end