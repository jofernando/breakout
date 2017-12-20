plataforma = {}

function plataforma:criar(x, y, l, a)
	local novo = display.newRect(x, y, l, a)
	return novo
end

return plataforma