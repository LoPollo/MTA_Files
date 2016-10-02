function boom (x,y,z,boomType)
	triggerServerEvent("onBoom",getLocalPlayer(),x,y,z,boomType)
end

addEventHandler("onClientExplosion",getRootElement(),boom)

