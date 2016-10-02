local colshape;

function importTextures3()
	txd = engineLoadTXD("textures/Ground.txd")
		engineImportTXD(txd, 13100)
	txd2 = engineLoadTXD("textures/Walls.txd")
		engineImportTXD(txd2, 13370)
		engineImportTXD(txd2, 13371)
	txd3 = engineLoadTXD("textures/Entrance.txd")
		engineImportTXD(txd3, 13157)
	txd4 = engineLoadTXD("textures/House.txd")
		engineImportTXD(txd4, 18267)
		engineImportTXD(txd4, 18259)
	txd5 = engineLoadTXD("textures/Rocks.txd")
		engineImportTXD(txd5, 18225)
	txd6 = engineLoadTXD("textures/Trees.txd")
		engineImportTXD(txd6, 689)
	txd7 = engineLoadTXD("textures/Walls2.txd")
		engineImportTXD(txd7, 18300)
	txd8 = engineLoadTXD("textures/Plants.txd")
		engineImportTXD(txd8, 825)
	txd9 = engineLoadTXD("textures/Plants2.txd")
		engineImportTXD(txd9, 820)
	txd10 = engineLoadTXD("textures/swat.txd")
		engineImportTXD(txd10, 285)
	txd11 = engineLoadTXD("textures/spy.txd")
		engineImportTXD(txd11, 163)
end

addEventHandler("onClientResourceStop", resourceRoot,
	function()
		if txd then destroyElement(txd) end
		if txd2 then destroyElement(txd2) end
		if txd3 then destroyElement(txd3) end
		if txd4 then destroyElement(txd4) end
		if txd5 then destroyElement(txd5) end
		if txd6 then destroyElement(txd6) end
		if txd7 then destroyElement(txd7) end
		if txd8 then destroyElement(txd8) end
		if txd9 then destroyElement(txd9) end
		if txd10 then destroyElement(txd10) end
		if txd11 then destroyElement(txd11) end
	end
)

function onClientColShapeHit( theElement, matchingDimension )
    if theElement == localPlayer and source == colshape then  -- Checks whether the entering element is the local player
    	--outputChatBox("In");
        importTextures3();
    end
end
addEventHandler("onClientColShapeHit",resourceRoot,onClientColShapeHit)

function onClientColShapeLeave( theElement, matchingDimension )
    if theElement == localPlayer and source == colshape then
    	destroyElement(txd)
		destroyElement(txd2)
		destroyElement(txd3)
		destroyElement(txd4)
		destroyElement(txd5)
		destroyElement(txd6)
		destroyElement(txd7)
		destroyElement(txd8)
		destroyElement(txd9)
		destroyElement(txd10)
		destroyElement(txd11)
    end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onClientColShapeLeave)

addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
        colshape = createColSphere ( 1946, -4326-500, 10, 900 );--colshape = createColSphere ( 1946, -4326, 10, 900 );
        --createBlipAttachedTo( colshape , 56, 2, 255, 0, 0, 255, 0, 1400 );
    end
);