txd = engineLoadTXD("577.txd")
engineImportTXD(txd, 577)
dff = engineLoadDFF("577.dff", 577)
engineReplaceModel(dff, 577)

-- generated with http://mta.dzek.eu/