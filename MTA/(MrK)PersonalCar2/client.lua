local window
local closebtn
local column
local column2
local delbtn
local delwindow
local delclosebtn
local delyesbtn

local cargrid
local column
local column2
local column3

local cars = {}

function listcars()
	showCursor ( true )
	if not window then
		local ResX, ResY = guiGetScreenSize ()
		window = guiCreateWindow ( ResX*0.5-500/2, ResY*0.5-350/2, 500, 350, "Car List", false )
		guiWindowSetMovable ( window, true )
		closebtn = guiCreateButton ( 0.75, 0.9, 0.2, 0.1, "Close", true, window )

		addEventHandler ( "onClientGUIClick", closebtn, function()
		showCursor ( false )
		guiSetVisible( window, false )--destroyElement(window)-- <--change this to guivisible false
		end, false )

		cargrid = guiCreateGridList ( 0.05, 0.1, 0.90, 0.78, true, window)
		addEventHandler ( "onClientGUIDoubleClick", cargrid, click, false)
		guiGridListSetSelectionMode ( cargrid, 1)
		guiGridListSetSortingEnabled ( cargrid, false)
		column = guiGridListAddColumn( cargrid, "Name", 0.5 )
		column2 = guiGridListAddColumn( cargrid, "Model", 0.4 )
	else
		guiSetVisible ( window, true )--set visible true
		guiGridListClear ( cargrid )
	end
	

	--Load Cars
	cars = {}
	cars = getElementData(localPlayer, "PersonalCarList")
	if not cars then 
		outputChatBox("Error: car list is nil")
		guiSetVisible ( window, false )-- guivisible false
		showCursor ( false )
		return
	end

	table.sort(cars, function( a,b )
    	if (a["Name"] < b["Name"]) then
    	    -- primary sort on position -> a before b
    	    return true
    	elseif (a["Name"] > b["Name"]) then
    	    -- primary sort on position -> b before a
    	    return false
    	end
	end)

	for i,v in pairs(cars) do 
		local row = guiGridListAddRow ( cargrid )
		guiGridListSetItemText ( cargrid, row, column2, v["ID"], false, false )
        guiGridListSetItemText ( cargrid, row, column, v["Name"], false, false )
    end
    
    --Load Cars End

    delbtn = guiCreateButton( 0.05, 0.9, 0.2, 0.1, "Delete selected", true, window )

    addEventHandler ( "onClientGUIClick", delbtn, function()
    	local ResX, ResY = guiGetScreenSize ()
    	row = guiGridListGetSelectedItem ( cargrid )
    	delwindow = guiCreateWindow ( ResX*0.45, ResY*0.45, 160, 60, "Are you sure?", false )
    	delclosebtn = guiCreateButton ( 0.75, 0.5, 0.2, 0.4, "No", true, delwindow )
		addEventHandler ( "onClientGUIClick", delclosebtn, function()
			destroyElement(delwindow)
		end, false )

		delyesbtn = guiCreateButton ( 0.05, 0.5, 0.2, 0.4, "Yes", true, delwindow )
		addEventHandler ( "onClientGUIClick", delyesbtn, function()
			triggerServerEvent ( "dcar", resourceRoot, localPlayer, "dcar", guiGridListGetItemText( cargrid, row, 1 ) )
			destroyElement(delwindow)
			guiGridListRemoveRow ( cargrid, row )
		end, false )

	end, false )
end

addEvent( "onLsCars", true)
addEventHandler( "onLsCars", localPlayer, 
	function()
		if not window then --if the GUI is not defined, not yet created
			listcars() --create it
		else
			if guiGetVisible( window ) then --if it's visible hide it
				showCursor ( not isCursorShowing( localPlayer ) )
				guiSetVisible( window, not guiGetVisible( window ) )
			else
				listcars()--to refresh too
			end
		end
	end )
addCommandHandler("lscars",listcars)
addCommandHandler("listcars",listcars)

function click( button, state, sx, sy, x, y, z, elem, gui )
	local row = guiGridListGetSelectedItem ( cargrid )
	local cond = guiGridListGetItemText(cargrid, row, 1) == ""
	if not cond then
		--executeCommandHandler("lcar", guiGridListGetItemText( cargrid, guiGridListGetSelectedItem ( cargrid ), 1 ) )
		triggerServerEvent ( "lcar", resourceRoot, localPlayer, "lcar", guiGridListGetItemText( cargrid, row, 1 ) )
		--outputChatBox("/lcar "..guiGridListGetItemText ( cargrid, guiGridListGetSelectedItem ( cargrid ), 1 ))
		showCursor(false)
		guiSetVisible ( window, false )--destroyElement(window)
	end
end
