txd = engineLoadTXD("sparrow.txd")
engineImportTXD(txd, getVehicleModelFromName( "seasparrow" ))
dff = engineLoadDFF("sparrow.dff", getVehicleModelFromName( "seasparrow" ))
engineReplaceModel(dff, getVehicleModelFromName( "seasparrow" ))

-- generated with http://mta.dzek.eu/