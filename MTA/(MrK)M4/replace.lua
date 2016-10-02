txd = engineLoadTXD ( "m4.txd" )
engineImportTXD ( txd, 356 )
dff = engineLoadDFF ( "m4.dff", 0 )
engineReplaceModel ( dff, 356 )