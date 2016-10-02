local ID = 1836;
local colshape;
--addEvent( "onDriftMapFile" , true )


function importTextures3()
	txd = engineLoadTXD ( "Drift.txd" )
		engineImportTXD ( txd, ID )
	col = engineLoadCOL ( "Drift.col" )
	dff = engineLoadDFF ( "Drift.dff", 0 )
	engineReplaceCOL ( col, ID )
	engineReplaceModel ( dff, ID )
	engineSetModelLODDistance(ID, 2000)
end
--setTimer ( importTextures3, 3000, 1)
--addCommandHandler("replace",importTextures3)
--addEventHandler ( "onDriftMapFile", root, importTextures3 )

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		engineRestoreCOL(ID)
		engineRestoreModel(ID)
		if dff then destroyElement(dff) end
		if col then destroyElement(col) end
		if txd then destroyElement(txd) end
	end
)

addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
        colshape = createColSphere ( 4677.8999, -3864.7, 10.3, 500 );
        createBlipAttachedTo( colshape , 56, 2, 255, 0, 0, 255, 0, 1000 )
        engineSetModelLODDistance ( ID, 550 )
    end
);

function onClientColShapeHit( theElement, matchingDimension )
    if theElement == localPlayer and source == colshape then  -- Checks whether the entering element is the local player
    	--outputChatBox("In");
        importTextures3();
    end
end
addEventHandler("onClientColShapeHit",resourceRoot,onClientColShapeHit)

function onClientColShapeLeave( theElement, matchingDimension )
    if theElement == localPlayer and source == colshape then
    	--outputChatBox("Out");
        engineRestoreCOL(ID)
		engineRestoreModel(ID)
		destroyElement(dff)
		destroyElement(col)
		destroyElement(txd)
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onClientColShapeLeave)