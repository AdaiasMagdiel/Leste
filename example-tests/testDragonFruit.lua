local Leste = require("leste.leste")

local function delay()
	-- This serves as a delay function, simply intended to pause for a few seconds.
	local i = 0
	for j=1,math.random(1000000,100000000) do i = i+j end
end

local function randomBool()
	return ({true, false})[math.random(1,2)]
end

Leste.it("Inside us there is something that has no name, that something is what we are.", function()
	--  José Saramago, Blindness

 	delay()
	assert(randomBool())
	assert(randomBool())
end)

Leste.it("Each of us is a universe, Pedro", function()
	-- Raul Seixas, Meu Amigo Pedro

	delay()
	assert(randomBool())
end)

Leste.it("What is essential is invisible to the eye.", function()
	-- Antoine de Saint-Exupéry, The Little Prince

	delay()
	assert(randomBool())
end)
