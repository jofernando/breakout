bola = {}

function bola:criar(x,y,r)
	local novo = display.newCircle(x, y, r)
	return novo
end

function bola:setarVelocidade(i)
	if i == 0 then
		timer.performWithDelay(4000, self:setLinearVelocity( 130, -600 ))
	end
end

return bola