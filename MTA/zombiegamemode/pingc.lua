--[[
Pingkicker, thx myself
]]--

setTimer(function() 
mT=setTimer(
    function() 
        --if getPlayerPing(getLocalPlayer()) >= 350 then 
        --    triggerServerEvent("ping.onBigPing",getLocalPlayer(),getPlayerPing(getLocalPlayer()))
        --end
    end,
5000,0)
end,60000,1)

addEvent("ping.killPing",true)
addEventHandler("ping.killPing",getRootElement(),function() killTimer(mT) mT = nil end)
