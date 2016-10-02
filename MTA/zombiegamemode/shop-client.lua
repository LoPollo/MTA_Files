--[[
Shop by Castillo

Thanks
]]--

shopWindow = guiCreateWindow(367,105,334,435,"Shop",false)
guiSetVisible (shopWindow, false)
guiSetAlpha(shopWindow,1)
guiWindowSetSizable(shopWindow,false)
tabPanel = guiCreateTabPanel(11,23,314,372,false,shopWindow)
tab2 = guiCreateTab("Weapons",tabPanel)
weapGrid = guiCreateGridList(4,6,305,291,false,tab2)
guiGridListSetSelectionMode(weapGrid,0)
weapColumn = guiGridListAddColumn(weapGrid,"Weapon",0.4)
costColumn = guiGridListAddColumn(weapGrid,"Price",0.2)
ammoColumn = guiGridListAddColumn(weapGrid,"Ammo",0.2)
weapButton = guiCreateButton(107,308,100,29,"Buy Weapon",false,tab2)
tab3 = guiCreateTab("Skills",tabPanel)
skillsGrid = guiCreateGridList(4,6,305,291,false,tab3)
guiGridListSetSelectionMode(skillsGrid,0)
costColumn = guiGridListAddColumn(skillsGrid,"ID",0.3)
skillsColumn = guiGridListAddColumn(skillsGrid,"Skill name",0.5)
costColumn = guiGridListAddColumn(skillsGrid,"Price",0.3)
skillsButton = guiCreateButton(107,308,100,29,"Buy Skill",false,tab3)
local weapons = {{5,100,1},{6,100,1},{8,1000,1},{9,10000,1},{16,18000,15},{22,1800,100},{23,1000,100},{24,2000,100},{25,8000,100},{26,2500,100},{27,2500,100},{28,1500,100},{29,2000,100},{30,2900,100},{31,3200,100},{32,2200,100},{33,5300,100},{34,5500,100},{46,500,1}}

for i,v in ipairs (weapons) do
    local itemName = getWeaponNameFromID (v[1])
    local row = guiGridListAddRow (weapGrid)
    local ammo = v[3] or 200
    guiGridListSetItemText (weapGrid, row, 1, itemName, false, true)
    guiGridListSetItemText (weapGrid, row, 2, tostring(v[2]), false, true)
    guiGridListSetItemText (weapGrid, row, 3, tostring(ammo), false, true)
end
guiSetAlpha(weapGrid,1)
closeButton = guiCreateButton(112,401,113,24,"Close Shop",false,shopWindow)


skillsTable = {{"0","Colt-45 Skill","250"},{"1","Silenced-Pistol Skill","2000"},{"2","Desert-Eagle Skill","5000"},{"3","Shotgun Skill","16000"},{"4","Sawed-off Skill","22000"},{"5","Spaz-12 Skill","15000"},{"6","Uzi Skill","11000"},{"7","MP5 Skill","14000"},{"8","AK-47 Skill","16000"},{"9","M4 Skill","20000"},{"10","Sniper","20000"}}
for i,v in ipairs (skillsTable) do
  local row = guiGridListAddRow (skillsGrid)
  guiGridListSetItemText (skillsGrid, row, 1, v[1], false, true)
  guiGridListSetItemText (skillsGrid, row, 2, v[2], false, true)
  guiGridListSetItemText (skillsGrid, row, 3, v[3], false, true)
end

function closeShop()
	if guiGetVisible(shopWindow) then 
		guiSetVisible(shopWindow,false)
		showCursor(false)
	end
end
addEventHandler ("onClientGUIClick", closeButton, closeShop)

addEvent ("viewGUI", true)
function viewGUI ()
  if (getLocalPlayer() == source) then
    guiSetVisible (shopWindow, true)
    showCursor (true)
  end
end
addEventHandler ("viewGUI", getRootElement(), viewGUI)

function onClientWeapBuy (button, state, absoluteX, absoluteYe)
 if (source == weapButton) then guiSetVisible (shopWindow, true) showCursor (true)
   if (guiGridListGetSelectedItem (weapGrid)) then
     local itemName = guiGridListGetItemText (weapGrid, guiGridListGetSelectedItem (weapGrid), 1)
     local itemID = getWeaponIDFromName (itemName)
     local itemCost = guiGridListGetItemText (weapGrid, guiGridListGetSelectedItem (weapGrid), 2)
     local itemAmmo = guiGridListGetItemText (weapGrid, guiGridListGetSelectedItem (weapGrid), 3)
     triggerServerEvent ("weapBuy", getLocalPlayer(), itemID, itemCost, itemName, itemAmmo)
    end
  end
end
addEventHandler ("onClientGUIClick", weapButton, onClientWeapBuy)



function onClientSkillBuy (button, state, absoluteX, absoluteYe)
 if (source == skillsButton) then guiSetVisible (shopWindow, true) showCursor (true)
    if (guiGridListGetSelectedItem (skillsGrid)) then
     local id = guiGridListGetItemText (skillsGrid, guiGridListGetSelectedItem (skillsGrid), 1)
      local cost = guiGridListGetItemText (skillsGrid, guiGridListGetSelectedItem (skillsGrid), 2)
      triggerServerEvent ("skillBuy", getLocalPlayer(), id, cost)
    end
 end
end
addEventHandler ("onClientGUIClick", skillsButton, onClientSkillBuy)
