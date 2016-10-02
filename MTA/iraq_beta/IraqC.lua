local ID 

local mapTable = {
	[19517] = 1681,
	[19518] = 1683,
	[19519]	= 2496,
	[19520]	= 2470,
	[19521]	= 2510,
	[19522]	= 2511,
}


--col = engineLoadCOL('Files/3dmodel.col')
--engineReplaceCOL(col, ID)
--engineSetModelLODDistance(ID, 0)
--engineSetModelLODDistance ( ID, 550 )


ID = mapTable[19518]
txd = engineLoadTXD('iraq.txd',true)
dff = engineLoadDFF('iraq2.dff')
col = engineLoadCOL('iraq.col')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )

ID = mapTable[19517]
dff = engineLoadDFF('iraq.dff')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )

ID = mapTable[19519]
dff = engineLoadDFF('iraq3.dff')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )

ID = mapTable[19520]
dff = engineLoadDFF('iraq4.dff')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )

ID = mapTable[19521]
dff = engineLoadDFF('iraq5.dff')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )

ID = mapTable[19522]
dff = engineLoadDFF('iraq6.dff')
engineImportTXD(txd, ID)
engineReplaceCOL(col, ID)
engineReplaceModel(dff, ID)
engineSetModelLODDistance(ID, 0)
engineSetModelLODDistance ( ID, 550 )
