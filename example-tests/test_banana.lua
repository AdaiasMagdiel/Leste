local Leste = require("leste.leste")

local function delay()
	-- This serves as a delay function, simply intended to pause for a few seconds.
	local i = 0
	for j=1,math.random(10000000,100000000) do i = i+j end
end

local function randomBool()
	return ({true, false})[math.random(1,2)]
end

Leste.it("I should be happier, for living smiling and seeing the samba", function()
	-- Raul Seixas, Ouro de Tolo

 	delay()
	assert(randomBool())
	assert(randomBool())
end)

Leste.it("The journey of a thousand miles begins with a single step.", function()
	-- Lao Tzu, Tao Te Ching

	delay()
	assert(randomBool())
end)

Leste.it("You have power over your mind - not outside events. Realize this, and you will find strength.", function()
	-- Marcus Aurelius, Meditations

	delay()
	assert(randomBool())
end)
