local Leste = require("leste.leste")

local function delay()
	-- This serves as a delay function, simply intended to pause for a few seconds.
	local i = 0
	for j=1,math.random(1000000,100000000) do i = i+j end
end

local function randomBool()
	return ({true, false})[math.random(1,2)]
end

Leste.it("It's the possibility of having a dream come true that makes life interesting.", function()
	-- Paulo Coelho, The Alchemist

 	delay()
	assert(randomBool())
end)

Leste.it("Do androids dream of electric sheep?", function()
	-- Philip K. Dick, Do Androids Dream of Electric Sheep?

	delay()
	assert(randomBool())
end)

Leste.it("And there's nothing in this world that I don't know too much about", function()
	-- Raul Seixas, Eu Nasci Há 10 Mil Anos Atrás

	delay()
	assert(randomBool())
end)
