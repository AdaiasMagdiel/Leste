local Leste = require("leste.leste")

local function delay()
	-- This serves as a delay function, simply intended to pause for a few seconds.
	local i = 0
	for j=1,math.random(10000000,100000000) do i = i+j end
end

local function randomBool()
	return ({true, false})[math.random(1,2)]
end

Leste.it("In a hole in the ground there lived a hobbit.", function()
	-- J.R.R. Tolkien, The Hobbit

 	delay()
	assert(randomBool())
end)

Leste.it("All animals are equal, but some animals are more equal than others.", function()
	-- George Orwell, Animal Farm

	delay()
	assert(randomBool())
	assert(randomBool())
	assert(randomBool())
end)

Leste.it("Whoever made you with iron, made you with fire, Pedro", function()
	-- Raul Seixas, Meu Amigo Pedro

	delay()
	assert(randomBool())
end)
