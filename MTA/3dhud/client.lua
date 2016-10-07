--//
--|| Created by KryPtoHolYx
--|| for More free Scripts visit kryptoholyx.com
--|| Thanks for Downloading
--\\



--// Settings
C_Disable_GTA_HUD = false
C_Creator_ScreenWidth = 1440
C_Creator_ScreenHeight = 900
s = {guiGetScreenSize()}
--AMMO
offsetboneAmmo = 23;--"muzzle" --// valid are "muzzle" and all bones
offsetdistAmmo1 = 0.20
offsetdistAmmo2 = 0.15
rotoffsetAmmo1 = 0
rotoffsetAmmo2 = -90
zoffsetAmmo = -0.2
--HEALTH
offsetboneHealth = 32 --// valid are all bones
offsetdistHealth1 = 0.2
offsetdistHealth2 = 0.1
rotoffsetHealth1 = 150
rotoffsetHealth2 = -90
zoffsetHealth = 0.1
--MONEY
offsetboneMoney = 41 --// valid are all bones
offsetdistMoney1 = 0.25
offsetdistMoney2 = 0.25
rotoffsetMoney1 = 230
rotoffsetMoney2 = -90
zoffsetMoney = -0.2
--Clock
offsetboneClock = 34
offsetdistClock1 = -0.2
offsetdistClock2 = 0.15
rotoffsetClock1 = 0
rotoffsetClock2 = -90
zoffsetClock = -0.1

debug = false
drawboxes = true
drawammo = true
drawhp = true
drawmoney = false
drawClock = true

magazines = {
		[22]=17,
		[23]=17,
		[24]=7,
		[25]=1,
		[26]=2,
		[27]=7,
		[28]=50,
		[29]=30,
		[30]=30,
		[31]=50,
		[32]=50,
		[33]=1,
		[34]=1,
		[35]=1,
		[36]=1,
		[37]=50,
		[38]=500,
		[41]=500,
		[42]=500,
		[43]=36,
		[16]=1,
		[17]=1,
		[18]=1,
		[39]=1,
}
--\\
local function dxDrawTextBordered(text,x,y,tx,ty, color, size, font,right,top, clip, wordBreak, postGUI,colorCoded, subPixelPositioning)
	local sWidth,sHeight = guiGetScreenSize() -- The variables
	local size2 = size / 768 * sHeight;
	dxDrawText(text,x-1,y,tx-1,ty, tocolor(0, 0, 0, 255), size2, font,right,top, clip, wordBreak, postGUI,colorCoded, subPixelPositioning)
	dxDrawText(text,x,y-1,tx,ty-1, tocolor(0, 0, 0, 255), size2, font,right,top, clip, wordBreak, postGUI,colorCoded, subPixelPositioning)
	dxDrawText(text,x+1,y,tx+1,ty, tocolor(0, 0, 0, 255), size2, font,right,top, clip, wordBreak, postGUI,colorCoded, subPixelPositioning)
	dxDrawText(text,x,y+1,tx,ty+1, tocolor(0, 0, 0, 255), size2, font,right,top, clip, wordBreak, postGUI,colorCoded, subPixelPositioningpo)
	dxDrawText(text,x,y,tx,ty, color, size2, font,right,top)
end

addEventHandler( "onClientResourceStart", resourceRoot,
    function ( startedRes )
        showPlayerHudComponent ( "armour",	false );
		showPlayerHudComponent ( "breath",	false );
		showPlayerHudComponent ( "clock",	false );
		showPlayerHudComponent ( "health",	false );
		showPlayerHudComponent ( "money",	false );
		showPlayerHudComponent ( "weapon",	false );
		showPlayerHudComponent ( "wanted",	false );
		showPlayerHudComponent ( "ammo",	false );
    end
);

addEventHandler( "onClientResourceStop", resourceRoot,
    function ( stoppedRes )
        showPlayerHudComponent ( "armour",	true );
		showPlayerHudComponent ( "breath",	true );
		showPlayerHudComponent ( "clock",	true );
		showPlayerHudComponent ( "health",	true );
		showPlayerHudComponent ( "money",	true );
		showPlayerHudComponent ( "weapon",	true );
		showPlayerHudComponent ( "wanted",	true );
		showPlayerHudComponent ( "ammo",	true );
    end
);

function findrotation (x,y,rz,dist,rot)
	local x = x+dist*math.cos(math.rad(rz+rot))
	local y = y+dist*math.sin(math.rad(rz+rot))
	return x,y
end

--// Making the dxdraws fit on all Resolutions !
_dxDrawRectangle = dxDrawRectangle
_dxDrawText = dxDrawText
function dxDrawRectangle(x,y,w,h,...)
	local x = s[1]*(x)/C_Creator_ScreenWidth
	local y = s[2]*(y)/C_Creator_ScreenHeight
	local w = s[1]*(w)/C_Creator_ScreenWidth
	local h = s[2]*(h)/C_Creator_ScreenHeight
	return _dxDrawRectangle(x,y,w,h,...)
end

function dxDrawText(text,x,y,w,h,...)
	local x = s[1]*(x)/C_Creator_ScreenWidth
	local y = s[2]*(y)/C_Creator_ScreenHeight
	local w = s[1]*(w)/C_Creator_ScreenWidth
	local h = s[2]*(h)/C_Creator_ScreenHeight
	return _dxDrawText(text,x,y,w,h,...)
end
--\\

--// Syncing the Fucking money 
--setTimer(function ()
--setElementData(localPlayer,"money",getPlayerMoney())
--
--end,1000,0)
--\\

--// Createds rTargets
local rTarget = {}
rTarget[localPlayer] = {}

rTarget[localPlayer]["ammo"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)
rTarget[localPlayer]["health"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)
rTarget[localPlayer]["Money"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)
rTarget[localPlayer]["Clock"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)


addEventHandler("onClientPreRender",root, function()
	if isPlayerHudComponentVisible( "health" ) then
		showPlayerHudComponent ( "armour",	false );
		showPlayerHudComponent ( "breath",	false );
		showPlayerHudComponent ( "clock",	false );
		showPlayerHudComponent ( "health",	false );
		showPlayerHudComponent ( "money",	false );
		showPlayerHudComponent ( "weapon",	false );
		showPlayerHudComponent ( "wanted",	false );
		showPlayerHudComponent ( "ammo",	false );
	end
	--[[for index,player in ipairs(getElementsByType("player")) do
		if not isElementStreamedIn (player) then return end
		if getElementDimension(player) ~= getElementDimension(localPlayer) then return end
		if getElementInterior(player) ~= getElementInterior(localPlayer) then return end

		if not rTarget[player] then
			rTarget[player] = {}
				rTarget[player]["ammo"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth,s[2]*(400)/C_Creator_ScreenHeight,true)
				rTarget[player]["health"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)
				rTarget[player]["Money"] = dxCreateRenderTarget(s[1]*(400)/C_Creator_ScreenWidth, s[2]*(400)/C_Creator_ScreenHeight,true)
		end]]
		player = localPlayer
		if getPedOccupiedVehicle ( player ) then return end
		if isPedAiming( player ) and ( getPedWeapon( player ) == 35 or getPedWeapon( player ) == 36 or getPedWeapon( player ) == 34 ) then return end
		-- // Total Ammo and Ammo for rTarget["ammo"]
		ammo = getPedAmmoInClip(player)
		atammo = getPedTotalAmmo(player)
		if magazines[getPedWeapon(player)] then
			tammo = math.floor(((atammo-ammo)/magazines[getPedWeapon(player)])*100)/100
			-- // Updates the rTarget Ammo with the Informations from above
			dxSetRenderTarget ( rTarget[player]["ammo"],true )
			if drawboxes then
			--// Draws the Borders around the Ammo 
				local bbox = 0
				for i=0,75,2 do
					bbox = bbox +1
					if bbox == 1	then
						dxDrawRectangle(160,143+i,80,2,tocolor(0,0,0,96))
					else
						bbox = 0
					end
				end			
			
				dxDrawRectangle(160,140,5,80,tocolor(0,242,236,150))
				dxDrawRectangle(160+5,140,15,5,tocolor(0,242,236,150))
				dxDrawRectangle(160+5,140+75,15,5,tocolor(0,242,236,150))
				
				dxDrawRectangle(160+75,140,5,80,tocolor(0,242,236,150))
				dxDrawRectangle(160+60,140,15,5,tocolor(0,242,236,150))
				dxDrawRectangle(160+60,140+75,15,5,tocolor(0,242,236,150))
				--\\
			end
			dxDrawTextBordered (ammo,200,170,200,170,tocolor(255,255,255,255),3,"default","center", "center")
			if atammo > 9999 then tammo = "∞" end
			dxDrawTextBordered (tammo, 200,200,200,200,tocolor(255,255,255,255),1.5,"default","center", "center")
			dxSetRenderTarget ()
		end
		
		dxSetRenderTarget (rTarget[player]["health"],true )
		if drawboxes then
			--// Draws the Borders around the Ammo 
			local bbox = 0
			for i=0,75,2 do
				bbox = bbox +1
				if bbox == 1 then
					dxDrawRectangle(150,(133+i),100,2,tocolor(0,0,0,96))
				else
					bbox = 0
				end
			end
				
			dxDrawRectangle(150,130,5,80,tocolor(0,242,236,150))
			dxDrawRectangle(150+5,130,15,5,tocolor(0,242,236,150))
			dxDrawRectangle(150+5,130+75,15,5,tocolor(0,242,236,150))
			
			dxDrawRectangle(150+95,130,5,80,tocolor(0,242,236,150))
			dxDrawRectangle(150+80,130,15,5,tocolor(0,242,236,150))
			dxDrawRectangle(150+80,130+75,15,5,tocolor(0,242,236,150))
			--\\
		end
		
		dxDrawTextBordered (math.floor(getElementHealth(player)), 200,160,200,160,tocolor(200,0,0,255),3,"default","center", "center")
		dxDrawTextBordered (math.floor(getPedArmor(player)), 200,190,200,190,tocolor(150,150,150,255),2,"default","center", "center")
		if not ((getPedOxygenLevel(player)/40) >= 100) then
			dxDrawTextBordered (" "..math.floor(getPedOxygenLevel(player)/40).."%", 200,110,200,110,tocolor(0,196,196,255),2,"default","center", "center")
			if drawboxes then
				local bbox = 0
				for i=0,30,2 do
					bbox = bbox +1
					if bbox == 1 then
						dxDrawRectangle(150,(95+i),100,2,tocolor(0,0,0,96))
					else
						bbox = 0
					end
				end
				
				dxDrawRectangle(150,	-7+100,	5,	35,tocolor(0,242,236,150))
				dxDrawRectangle(150+5,	-7+100,	15,	5,tocolor(0,242,236,150))
				dxDrawRectangle(150+5,	-7+100+30,	15,	5,tocolor(0,242,236,150))
				dxDrawRectangle(150+95,	-7+100,	5,	35,tocolor(0,242,236,150))
				dxDrawRectangle(150+80,	-7+100,	15,	5,tocolor(0,242,236,150))
				dxDrawRectangle(150+80,	-7+100+30,	15,	5,tocolor(0,242,236,150))
			end
		end

		dxSetRenderTarget (rTarget[player]["Clock"],true )
		if drawboxes then
			local bbox = 0
			for i=0,35,2 do
				bbox = bbox +1
				if bbox == 1 then
					dxDrawRectangle(150+20,(133+i),100-20,2,tocolor(0,0,0,96))
				else
					bbox = 0
				end
			end
				
			dxDrawRectangle(20+150, 	130,	5,	40,tocolor(0,242,236,150))
			dxDrawRectangle(20+150+5,	130,	15,	5,tocolor(0,242,236,150))
			dxDrawRectangle(20+150+5,	130+35,	15,	5,tocolor(0,242,236,150))
			
			dxDrawRectangle(-00+150+95,	130,	5,	40,tocolor(0,242,236,150))
			dxDrawRectangle(-00+150+80,	130,	15,	5,tocolor(0,242,236,150))
			dxDrawRectangle(-00+150+80,	130+35,	15,	5,tocolor(0,242,236,150))
		end
		dxDrawTextBordered (string.format("%02s:%02s",getTime()), 210,150,210,150,tocolor(255,255,255,255),1.5,"default","center", "center")

		dxSetRenderTarget ()

		dxSetRenderTarget ( rTarget[player]["Money"],true )
		dxDrawTextBordered ("$"..math.floor(getElementData(player,"money") or 0), 200,160,200,160,tocolor(0,200,0,255),4,"default","center", "center")
		dxSetRenderTarget ()	

		--// Finds Positions for the rTarget Ammo
		if offsetboneAmmo ~= "muzzle" then
			sx,sy,z = getPedBonePosition(player,offsetboneAmmo)
		else
			sx,sy,z = getPedWeaponMuzzlePosition(player)
		end
			
		local rz = getPedRotation(player)
		x1,y1 = findrotation (sx,sy,rz,offsetdistAmmo1,rotoffsetAmmo1)
		x,y = findrotation (x1,y1,rz,offsetdistAmmo2, (getPedTask(player, "secondary", 0) == "TASK_SIMPLE_USE_GUN") and rotoffsetAmmo2-20 or rotoffsetAmmo2)
		--// Draws Ammo rTarget
		if drawammo then
			if magazines[getPedWeapon(player)] then
				dxDrawMaterialLine3D ( x1,y1,z+zoffsetAmmo+0.5,x1,y1,z+zoffsetAmmo-0.5,rTarget[player]["ammo"], 1, tocolor(255,255,255,255),x,y,z)
			end
		end
		--// for Testing 
		if debug then
			dxDrawLine3D(sx,sy,z,x1,y1,z+zoffsetAmmo)
			dxDrawLine3D(x1,y1,z+zoffsetAmmo,x,y,z+zoffsetAmmo)
		end
		
		--// Finds Positions for the rTarget Health
		local sx,sy,z = getPedBonePosition(player,offsetboneHealth)
		local rz = getPedRotation(player)
		x1,y1 = findrotation (sx,sy,rz,offsetdistHealth1,rotoffsetHealth1)
		x,y = findrotation (x1,y1,rz,offsetdistHealth2, getPedTask(player, "secondary", 0) == "TASK_SIMPLE_USE_GUN" and rotoffsetHealth2+20 or rotoffsetHealth2 )
		--// Draws health rTarget
		if drawhp then
			dxDrawMaterialLine3D ( x1,y1,z+zoffsetHealth+0.5,x1,y1,z+zoffsetHealth-0.5,rTarget[player]["health"], 1, tocolor(255,255,255,255),x,y,z)
		end
		--// for Testing 
		if debug then
			dxDrawLine3D(sx,sy,z,x1,y1,z+zoffsetHealth)
			dxDrawLine3D(x1,y1,z+zoffsetHealth,x,y,z+zoffsetHealth)
		end
			
		--// Finds Positions for the rTarget Money
		
		local sx,sy,z = getPedBonePosition(player,offsetboneMoney)
		local rz = getPedRotation(player)
		x1,y1 = findrotation (sx,sy,rz,offsetdistMoney1,rotoffsetMoney1)
		x,y = findrotation (x1,y1,rz,offsetdistMoney2,rotoffsetMoney2)
		--// Draws Money rTarget
		if drawmoney then
			dxDrawMaterialLine3D ( x1,y1,z+zoffsetMoney+0.5,x1,y1,z+zoffsetMoney-0.5,rTarget[player]["Money"], 1, tocolor(255,255,255,255),x,y,z)
		end
		--// for Testing 
		if debug then
			dxDrawLine3D(sx,sy,z,x1,y1,z+zoffsetMoney)
			dxDrawLine3D(x1,y1,z+zoffsetMoney,x,y,z+zoffsetMoney)
		end

		--// Finds Positions for the rTarget Clock
		local sx,sy,z = getPedBonePosition(player,offsetboneClock)
		local rz = getPedRotation(player)
		x1,y1 = findrotation (sx,sy,rz,offsetdistClock1,rotoffsetClock1)
		x,y = findrotation (x1,y1,rz,offsetdistClock2, rotoffsetClock2 )
		--// Draws clock rTarget
		if drawClock and getPedTask(player, "secondary", 0) ~= "TASK_SIMPLE_USE_GUN" then
			dxDrawMaterialLine3D ( x1,y1,z+zoffsetClock+0.5,x1,y1,z+zoffsetClock-0.5,rTarget[player]["Clock"], 1, tocolor(255,255,255,255),x,y,z)
		end
		--// for Testing 
		if debug then
			dxDrawLine3D(sx,sy,z,x1,y1,z+zoffsetClock)
			dxDrawLine3D(x1,y1,z+zoffsetClock,x,y,z+zoffsetClock)
		end
	--end --End of for loop
end)

function isPedAiming ( thePedToCheck )
	if isElement(thePedToCheck) then
		if getElementType(thePedToCheck) == "player" or getElementType(thePedToCheck) == "ped" then
			if getPedTask(thePedToCheck, "secondary", 0) == "TASK_SIMPLE_USE_GUN" then
				return true
			end
		end
	end
	return false
end
