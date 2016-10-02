txd = engineLoadTXD("hunter.txd")
engineImportTXD(txd, 425)
dff = engineLoadDFF("hunter.dff", 425)
engineReplaceModel(dff, 425)

-- generated with http://mta.dzek.eu/