local plataforma = display.newRect(display.contentCenterX, display.contentHeight-60, 75, 15)

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
			table.insert(tabelas, bloco)
			x = x + 64
		end
		y = y + 20
	end
end

bolinha = display.newCircle(display.contentCenterX,display.contentCenterY, 7)

desenharBlocos()