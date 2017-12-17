local composer = require( "composer" )
local physics = require( "physics" )
physics.start()
physics.setGravity(0,0)

local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
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

quantBlocos = 25;
function blocosListener(event)
    timer.performWithDelay(1, event.target:removeSelf())
    quantBlocos = quantBlocos - 1
    verificarGameOver()
end

function verificarGameOver()
    if(quantBlocos == 0) then
        mudarCena()
    end
end

function fundoListener( event )
    event.other:setLinearVelocity(0,0)
    mudarCena()
end

function mudarCena()
    composer.gotoScene("scenes.gameover")
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local esquerda = display.newRect(0,0,10,display.contentHeight*2)
    esquerda.anchorX=10
    physics.addBody( esquerda, "static" )
    local cima = display.newRect(0,0,display.contentWidth*2,10)
    cima:setFillColor(1)
    physics.addBody( cima, "static" )
    local direita = display.newRect(display.contentWidth,0,10,display.contentHeight*2)
    direita.anchorX=0
    physics.addBody( direita, "static" )
    local baixo = display.newRect(0,display.contentHeight,display.contentWidth*2,10)
    baixo:setFillColor(1)
    physics.addBody( baixo, "static" )
    baixo:addEventListener("collision", fundoListener)

    sceneGroup:insert(esquerda)
    sceneGroup:insert(direita)
    sceneGroup:insert(cima)
    sceneGroup:insert(baixo)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

        quantBlocos = 25
        local y = 0
        for i=1,5 do
            local x = 0
            for i=1,5 do
                local bloco = display.newRect(sceneGroup,x,y,64,20)
                bloco.anchorX = 0
                bloco.anchorY = 0
                bloco:setFillColor(math.random(),math.random(),math.random())
                physics.addBody( bloco, "static" )
                bloco:addEventListener( "collision", blocosListener )
                x = x + 64
            end
            y = y + 20
        end

        plataforma = display.newRect(sceneGroup,display.contentCenterX, display.contentHeight-60, 75, 15)
        physics.addBody( plataforma, "static" )
        plataforma:addEventListener("touch", arrastar)

        bolinha = display.newCircle(sceneGroup,display.contentCenterX,plataforma.y, 12)
        physics.addBody( bolinha, "dynamic", {density=0, friction=0, bounce=1, radius=15} )
        bolinha:setLinearVelocity( 10, -500 )
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        sceneGroup:removeSelf()
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene