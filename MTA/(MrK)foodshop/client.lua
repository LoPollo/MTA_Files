foodwindow = guiCreateWindow(0.3,0.2,0.4,0.8,"",true)
guiSetAlpha(foodwindow,225)
guiSetProperty(foodwindow, "ImageColours", "tl:FFFFFE0C tr:FF0000FF bl:FF0000FF br:FFFFFE0C")                                           guiCreateStaticImage ( 0, 0, 1, 0.5,"image.png",true,foodwindow)
pizzaimg = guiCreateStaticImage(0.52, 0.70, 0.45, 0.1, "pizza.png", true, foodwindow)
chickenimg = guiCreateStaticImage(0.52, 0.85, 0.45, 0.1, "chicken.png", true, foodwindow)
saladimg = guiCreateStaticImage(0, 0.85, 0.45, 0.1, "salad.png", true, foodwindow)
burgerimg = guiCreateStaticImage(0, 0.70, 0.45, 0.1, "burger.png", true, foodwindow)
closebtn = guiCreateButton(0.1, 0.58, 0.75, 0.1, "close", true, foodwindow)
guiSetProperty(closebtn, "NormalTextColour", "FFAAAAAA")
guiSetVisible(foodwindow, false)   

function lol (hitElement)
local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(foodwindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(foodwindow,x,y,false)
if hitElement == getLocalPlayer() then
guiSetVisible(foodwindow, true)
showCursor(true)
--centerWindow(foodwindow)
end
end

function createburgers()
burger = createMarker(377.10623168945, -67.435386657715, 1000.5078125,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 0) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                                                                         
                                                                                     function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 1) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)
                                                                                      function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 7) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                                                                                                                                                              function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 8) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                                                                                                                                                              function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 5) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                                                                                                                                                              
                                                                                      function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 6) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                        function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 9) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                             function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 3) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement            (),createburgers)                      
                                                                                                                                                                              function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 2) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                              function createburgers()
burger = createMarker(376.70318603516, -68.459686279297, 1000,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(burger, 4) 
setElementInterior(burger, 10)
addEventHandler('onClientMarkerHit', burger, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createburgers)                      
                                                                                                                                                                                                                                                            function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 0) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 1) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 2) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 3) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 4) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 5) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 6) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 7) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 8) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 9) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 10) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
function createpizza()
pizza = createMarker(373.43643188477, -118.8117980957, 1000.4921875,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(pizza, 11) 
setElementInterior(pizza, 5)
addEventHandler('onClientMarkerHit', pizza, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createpizza)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 0) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)

function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 1) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 2) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 3) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 4) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 5) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 6) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 7) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 8) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 9) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 10) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)


function createchicken()
chicken = createMarker(369.17388916016, -6.0179758071899, 1000.8515625,"cylinder", 1.5, 60, 60, 60,250) 
setElementDimension(chicken, 11) 
setElementInterior(chicken, 9)
addEventHandler('onClientMarkerHit', chicken, lol)
end
addEventHandler('onClientResourceStart', getResourceRootElement(),createchicken)




function close ()
guiSetVisible(foodwindow, false)
showCursor(false)
end
addEventHandler("onClientGUIClick", closebtn, close)

function salad()
if getPlayerMoney(player) >= 0 then--20 then
inc = 15
player = getLocalPlayer ()
local hp = getElementHealth( player )
setElementHealth(player, getElementHealth(player) + inc)
triggerServerEvent("salad", getLocalPlayer())
guiSetVisible( foodwindow, false )
local cond = hp == getElementHealth(player)
if cond then 
  triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Vomit_P", 7500)
else
	--setPedAnimation( player, "FOOD", "EAT_Chicken", -1, false, false, false, false )
end
setTimer( 
	function()
		guiSetVisible( foodwindow, true )
		--setPedAnimation( player )
	end, 
cond and 7500 or 5000, 1 )
--outputChatBox("you have bought a salad meal Enjoy your food", 0, 255, 0, player)
else
--outputChatBox("You need more money to buy a meal ",255,0,250)
end
end
addEventHandler("onClientGUIDoubleClick", saladimg, salad)

function pizza()
if getPlayerMoney(player) >= 0 then --30 then
inc = 30
player = getLocalPlayer ()
local hp = getElementHealth( player )
setElementHealth(player, getElementHealth(player) + inc)
triggerServerEvent("pizza", getLocalPlayer())
guiSetVisible( foodwindow, false )
local cond = hp == getElementHealth(player)
if cond then 
	triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Vomit_P", 7500)
else
  triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Pizza", 5500)
	--setPedAnimation( player, "FOOD", "EAT_Pizza", -1, false, false, false, false )
	--setPedAnimationProgress( player, "EAT_Pizza", 0.8 )
end
setTimer( 
	function()
		guiSetVisible( foodwindow, true )
		--setPedAnimation( player )
	end, 
cond and 7000 or 5500, 1 )
--outputChatBox("you have bought a pizza meal Enjoy your food", 0, 255, 250, player)
else
--outputChatBox("You need more money to buy a meal ",255,0,250)
end
end
addEventHandler("onClientGUIDoubleClick", pizzaimg, pizza)

function chicken()
if getPlayerMoney(player) >= 0 then --40 then
inc = 45
player = getLocalPlayer ()
local hp = getElementHealth( player )
setElementHealth(player, getElementHealth(player) + inc)
triggerServerEvent("chicken", getLocalPlayer())
--outputChatBox("you have bought a chicken meal Enjoy your food", 0, 255, 0, player)
guiSetVisible( foodwindow, false )
local cond = hp == getElementHealth(player)
if cond then 
	--setPedAnimation( player, "FOOD", "EAT_Vomit_P", -1, false, false, false, false ) --it is interruptable even if interruptable is false
  triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Vomit_P", 7500)
else
	--setPedAnimation( player, "FOOD", "EAT_Chicken", -1, false, false, false, false )
  triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Chicken", 5500)
	--setPedAnimationProgress( player, "EAT_Pizza", 0.76 )
end
setTimer( 
	function()
		guiSetVisible( foodwindow, true )
		--setPedAnimation( player )
	end, 
cond and 7500 or 5500, 1 )
else
--outputChatBox("You need more money to buy a meal ",255,0,250)
end
end
addEventHandler("onClientGUIDoubleClick", chickenimg, chicken)

function burger()
if getPlayerMoney(player) >= 0 then --50 then
inc = 60
player = getLocalPlayer ()
local hp = getElementHealth( player )
setElementHealth(player, getElementHealth(player) + inc)
triggerServerEvent("burger", getLocalPlayer())
--outputChatBox("you have bought a burger meal Enjoy your food", 0, 255, 0, player)
guiSetVisible( foodwindow, false )
local cond = hp == getElementHealth(player)
if cond then 
	triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Vomit_P", 7500)
else
  triggerServerEvent( "onFoodEat", resourceRoot, "FOOD", "EAT_Burger", 5500)
	--setPedAnimation( player, "FOOD", "EAT_Burger", -1, false, false, false, false )
end
setTimer( 
	function()
		guiSetVisible( foodwindow, true )
		--setPedAnimation( player )
	end, 
cond and 7000 or 5500, 1 )

else
--outputChatBox("You need more money to buy a meal ",255,0,250)
end
end
addEventHandler("onClientGUIDoubleClick", burgerimg, burger)


