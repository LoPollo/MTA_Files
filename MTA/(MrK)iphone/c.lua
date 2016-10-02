
x,y = guiGetScreenSize()
okno = guiCreateStaticImage( x*0.05, y*0.1, x*0.9, y*0.7, "tlo.png", false)      
local browser = guiCreateBrowser(x*0.113, y*0.045, x*0.673, y*0.605, false, false, false, okno)

guiSetVisible ( okno, false )

local theBrowser = guiGetBrowser(browser )

addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, "https://www.youtube.com/")
	end
)

function pokaz ()
if guiGetVisible ( okno ) == false then
showCursor ( true )
guiSetVisible ( okno, true)
setElementData ( localPlayer, "shader", true )
  setPlayerHudComponentVisible ( "all", false) 
  showChat(false) 
else
showCursor ( false)
setElementData ( localPlayer, "shader", false)
guiSetVisible ( okno, false)
  setPlayerHudComponentVisible ( "all", true ) 
  showChat(true) 
end
end
 bindKey ( "F4", "down", pokaz )

--[[function autor ()
outputChatBox("Przeglądarka iPhone stworzona przez Artystę dla Gtao.pl", 200,0,0 )
end
addCommandHandler("autor", autor )]]
