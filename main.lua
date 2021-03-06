local composer = require("composer")
composer.gotoScene("scenes.menu")

--[[local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)




local function blocosListener(event)
	timer.performWithDelay(1, event.target:removeSelf())
end

local function fundoListener( event )
	event.other:setLinearVelocity(0,0)
end

cantos = {}
local function desenharCantos()
	local esquerda = display.newRect(0,0,10,display.contentHeight*2)
	esquerda.anchorX=10
	physics.addBody( esquerda, "static" )
	local cima = display.newRect(0,0,display.contentWidth*2,10)
	cima:setFillColor(0)
	physics.addBody( cima, "static" )
	local direita = display.newRect(display.contentWidth,0,10,display.contentHeight*2)
	direita.anchorX=0
	physics.addBody( direita, "static" )
	local baixo = display.newRect(0,display.contentHeight,display.contentWidth*2,10)
	baixo:setFillColor(0)
	physics.addBody( baixo, "static" )
	baixo:addEventListener("collision", fundoListener)
end

local function arrastar(event)
	local plataforma = event.target
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
			physics.addBody( bloco, "static" )
			bloco:addEventListener( "collision", blocosListener )
			table.insert(tabelas, bloco)
			x = x + 64
		end
		y = y + 20
	end
end

local function bolinhaListener(event)
	local bolinha = event.target
	bolinha:setLinearVelocity( 20, 20 )
end

local plataforma = display.newRect(display.contentCenterX, display.contentHeight-60, 75, 15)
physics.addBody( plataforma, "static" )
plataforma:addEventListener("touch", arrastar)

bolinha = display.newCircle(display.contentCenterX,display.contentCenterY, 12)
physics.addBody( bolinha, "dynamic", {density=0, friction=0, bounce=1, radius=15} )
bolinha:setLinearVelocity( 150, 150 )
--bolinha:addEventListener("collision", bolinhaListener)
--bolinha:applyForce(0,1,0,0)

desenharBlocos()
desenharCantos()]]