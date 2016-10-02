local SW, SH = guiGetScreenSize()
local POS = { 
	x = 270,
	y = 150
}
local SIZE = { 
	h = 300,
	w = 500
}
local Obj_Size = {}
local TopBorder = {}
local BGCOLOUR = tocolor(0,0,0)
local OBJECTCOLOUR = tocolor(0,160,0)
local BorderGen = 1
local Moves = 0
local Score = 0
local BestScore = 0

addCommandHandler("copter",
function()
	if(not GameGrid) then
		setupGame()
	end
	if(GameIsLoaded) then
		removeEventHandler("onClientRender",getRootElement(),renderGame)
		removeEventHandler("onClientPreRender",getRootElement(),preRender)
		GameIsLoaded = false
	else
		addEventHandler("onClientRender",getRootElement(),renderGame)
		addEventHandler("onClientPreRender",getRootElement(),preRender)
		GameIsLoaded = true
	end
	showCursor(GameIsLoaded)
end)


function setupGame()
	Score = 0
	Moves = 0
	ObjectsCount = 0
	Started = false
	CopterPos = (SIZE.h/2) -20
	OBJECTCOLOUR = tocolor(0,160,0)
	GameOver = false
	GameGrid = { }
	for r = 0, 19 do
		GameGrid[r] = {}
	end
	for c=0,19 do
		addBorder(c)
	end
	Obj_Size.w = SIZE.w/20
	Obj_Size.h = SIZE.h/20
end

function preRender()
	local Change = 2.5
	if(getKeyState("mouse2") and (not RCTick or getTickCount() -  RCTick > 600) and not GameOver) then
		Paused = not Paused
		RCTick = getTickCount()
	end
	if(getKeyState("mouse1")) then
		Change = -2.5
		if(GameOver and GameOverTick and getTickCount() - GameOverTick > 800) then
			setupGame()
		else
			if(not Started) then
				Started = true
			end
		end
	end
	if(not GameOver and not Paused and Started) then
		if(not LastTickMove or getTickCount() - LastTickMove > 10) then
			CopterPos = CopterPos + Change
			
			for r,v in pairs(GameGrid) do
				for c,v2 in pairs(v) do
					if(v2 == 1 or r == 0 or r == #GameGrid) then 
						local x2 = POS.x+(Obj_Size.w*c)
						local y2 = POS.y+(Obj_Size.h*r)
						local x = POS.x+20
						local y = POS.y+CopterPos
						if(x < x2 + Obj_Size.w and x+Obj_Size.w*1.5 > x2 and y < y2+Obj_Size.h and y+Obj_Size.h*1.5 > y2) then
							GameOver = true
							if(Score > BestScore) then
								BestScore = Score
							end
							GameOverTick = getTickCount()
							OBJECTCOLOUR = tocolor(255,0,0)
							break
						end
					end
				end
			end
			LastTickMove = getTickCount()
		end
	end
end

function renderGame()
	dxDrawRectangle(POS.x,POS.y,SIZE.w,SIZE.h,BGCOLOUR)
	
	dxDrawImage(POS.x+20,POS.y+CopterPos,Obj_Size.w*1.5,Obj_Size.h*1.5,"copter.png")
	
	for r,v in pairs(GameGrid) do
		for c,v2 in pairs(v) do
			if(v2 == 1 and c <= 19) then
				dxDrawRectangle(POS.x+(Obj_Size.w*c),POS.y+(Obj_Size.h*r),Obj_Size.w,Obj_Size.h,OBJECTCOLOUR)
			end
		end
	end
	if(not GameOver and not Paused and Started) then
		if(not LastTick or getTickCount() - LastTick > 200-(Score/60)) then
			for r,v in pairs(GameGrid) do
				for c,v in pairs(v) do
					local newCol = c -1
					if(newCol ~= -1) then
						GameGrid[r][newCol] = v
						GameGrid[r][c] = 0
					end
				end
			end
			Moves = Moves +1
			addBorder(19)
			AddObject(19)
			Score = Score + Obj_Size.w/4
			LastTick = getTickCount()
		end
	end
	if(GameOver) then
		dxDrawText("Game Over Click to restart!",POS.x+(SIZE.w/2)-dxGetTextWidth("Game Over Click to restart!")/2,POS.y)
	end
	if(Paused) then
		dxDrawText("Click to unpause!",POS.x+(SIZE.w/2)-dxGetTextWidth("Click to unpause!")/2,POS.y)
	end
	
	dxDrawText("Score: "..Score,POS.x,POS.y)
	dxDrawText("Best: "..BestScore,POS.x+SIZE.w-dxGetTextWidth("Best: "..BestScore)-5,POS.y)
end

function addBorder(col)
	for r = 0, 19 do
		GameGrid[r][col] = 1
	end
	BorderGen = BorderGen + math.random(-1,1)
	if(BorderGen < 1) then
		BorderGen = 1
	elseif(BorderGen > 6) then
		BorderGen = 6
	end
	local s = BorderGen+math.random(11,12)
	for c = BorderGen,s do
		GameGrid[c][col] = 0
	end
	return BorderGen+(s/2)
end

function AddObject(col)
	if(math.random(0,100) > 40 and Moves > 6) then
		local rnd = math.random(BorderGen,BorderGen+12)
		GameGrid[rnd][col] = 1
		GameGrid[rnd-1][col] = 1
		GameGrid[rnd+1][col] = 1
		OBJECTCOLOUR = tocolor(math.random(30,255),math.random(30,255),math.random(30,255))
		Moves = 0
	end
end