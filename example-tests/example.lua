-- these tests won't be loaded because this file doesn't start with 'test'.

local Leste = require("leste.leste")

Leste.it("should be true", function()
	assert(1 == 1)
end)

Leste.it("should be false", function()
	assert(1 == 0)
end)

Leste.it("should be true again", function()
	assert(1 == 1)
end)
