local colshape;
local ID = 1836;
--addEventHandler('onClientResourceStart', resourceRoot,
--    function()
-- 
--        local txd = engineLoadTXD('Files/3dmodel.txd',true)
--        engineImportTXD(txd, 16209)
-- 
--        local dff = engineLoadDFF('Files/3dmodel.dff', 0)
--        engineReplaceModel(dff, 16209)
-- 
--        local col = engineLoadCOL('Files/3dmodel.col')
--        engineReplaceCOL(col, 16209)
--        engineSetModelLODDistance(16209, 0)
--
----txd = engineLoadTXD ( "Files/cmodel.txd" )	engineImportTXD ( txd, 496 )
----
----dff = engineLoadDFF ( "Files/cmodel.dff", 0 )   engineReplaceModel ( dff, 496 )
--	end 
--)
function importTextures()
	txd = engineLoadTXD('Files/3dmodel.txd',true)
	engineImportTXD(txd, ID)
	dff = engineLoadDFF('Files/3dmodel.dff', 0)
	engineReplaceModel(dff, ID)
	col = engineLoadCOL('Files/3dmodel.col')
	engineReplaceCOL(col, ID)
	engineSetModelLODDistance(ID, 0)
end


addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
        colshape = createColSphere ( -4032.4004, -2615.0996, -23, 500 );
        createBlipAttachedTo( colshape , 56, 2, 255, 0, 0, 255, 0, 1000 );
        engineSetModelLODDistance ( ID, 550 )
    end
);

function onClientColShapeHit( theElement, matchingDimension )
    if theElement == localPlayer and source == colshape then  -- Checks whether the entering element is the local player
    	--outputChatBox("In");
        importTextures();
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

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		engineRestoreCOL(ID)
		engineRestoreModel(ID)
		if dff then destroyElement(dff) end
		if col then destroyElement(col) end
		if txd then destroyElement(txd) end
	end
)