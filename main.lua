plataforma = display.newRect(display.contentCenterX, display.contentHeight-60, 75, 15)

local function arrastar(event)
	print(event.phase)
	if event.phase == "began" then
		local parent = plataforma.parent
		parent:insert( plataforma )
		display.getCurrentStage():setFocus(plataforma)
		print(event.x)
	elseif event.phase == "moved" then
		print(event.x)
		if plataforma.x-37.5>=0 and plataforma.x+37.5<=display.contentWidth then
			print(event.phase)
			plataforma.x = event.x
		end
	elseif "ended" == phase or "cancelled" == phase then
		display.getCurrentStage():setFocus( nil )
		t:setStrokeColor( 1, 1, 1, 0 )
		t.isFocus = false
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