txd = engineLoadTXD("592.txd")
engineImportTXD(txd, 592)
dff = engineLoadDFF("592.dff", 592)
engineReplaceModel(dff, 592)

-- generated with http://mta.dzek.eu/