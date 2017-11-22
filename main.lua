local physics = require( "physics" )
physics.start()

local plataforma = display.newRect(display.contentCenterX, display.contentHeight-60, 75, 15)
physics.addBody( plataforma, "static", { density=3.0, friction=0.5, bounce=1.2 } )

local function arrastar(event)
	if event.phase == "began" then
		display.getCurrentStage():setFocus(plataforma)
	elseif event.phase == "moved" then
		if (plataforma.x - plataforma.width/2 > 0 and plataforma.x + plataforma.width/2 < display.contentWidth) and 
			(event.x - plataforma.width/2 > 0 and event.x + plataforma.width/2 < display.contentWidth) then
			plataforma.x = event.x
		end
	elseif event.phase == "ended" or event.phase == "cancelled" then
		display.getCurrentStage():setFocus( nil )
		plataforma.isFocus = false
	end
end

plataforma:addEventListener("touch", arrastar)

local function blocosListener(event)
	timer.performWithDelay(5, function()
        event.target:removeSelf()
    end)
end

tabelas = {}
local function desenharBlocos()
	local y	= 0
	for i=1,5 do
		local x = 0
		for i=1,5 do
			local bloco = display.newRect(x,y,64,20)
			bloco.anchorX = 0
			bloco.anchorY = 0
			bloco:setFillColor(math.random(),math.random(),math.random())
			physics.addBody( bloco, "static", { density=3.0, friction=0.5, bounce=1 } )
			bloco:addEventListener( "postCollision", blocosListener )
			table.insert(tabelas, bloco)
			x = x + 64
		end
		y = y + 20
	end
end

cantos = {}
local function desenharCantos()
	local esquerda = display.newRect(-1,0,1,10000)
	physics.addBody( esquerda, "static",{ density=3.0, friction=0.5, bounce=1 } )
	local cima = display.newRect(0,0,10000,1)
	cima.anxhorY=0
	physics.addBody( cima, "static",{ density=3.0, friction=0.5, bounce=1 } )
	local direita = display.newRect(display.contentWidth+1,0,1,10000)
	physics.addBody( direita, "static",{ density=3.0, friction=0.5, bounce=1 } )
	local baixo = display.newRect(0,display.contentHeight-1,10000,1)
	physics.addBody( baixo, "static",{ density=3.0, friction=0.5, bounce=1 } )
	display.anchorY=-100
end

bolinha = display.newCircle(display.contentCenterX,display.contentCenterY, 12)
physics.addBody( bolinha, { density=3.0, friction=0.5, bounce=0.3, radius=12 } )

desenharBlocos()
desenharCantos()