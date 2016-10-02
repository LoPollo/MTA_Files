txd = engineLoadTXD("433.txd")
engineImportTXD(txd, 433)
dff = engineLoadDFF("433.dff", 433)
engineReplaceModel(dff, 433)

-- generated with http://mta.dzek.eu/