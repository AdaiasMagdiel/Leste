local Leste = require("leste.leste")
local DummyLeste = require("tests.dummy_leste")


Leste.it("the it method can store tests", function ()
	local totalTests = #DummyLeste.tests

	local testFunction = function() assert(true) end
	DummyLeste.it("dummy test example", testFunction)

	assert(totalTests ~= #DummyLeste.tests)
	assert(#DummyLeste.tests == 1)
	assert(DummyLeste.tests[1].action == testFunction)

	DummyLeste.reset()
end)

Leste.it("the it method add the description with the test", function ()
	local totalTests = #DummyLeste.tests

	DummyLeste.it("a description example", function() end)

	assert(totalTests ~= #DummyLeste.tests)
	assert(#DummyLeste.tests == 1)
	assert(DummyLeste.tests[1].description == "a description example")

	DummyLeste.reset()
end)

Leste.it("leste can update the total of assertions", function ()
	DummyLeste.it("a", function() assert(true) end)
	DummyLeste.it("b", function() assert(true) end)
	DummyLeste.it("c", function() assert(true) end)
	DummyLeste.it("d", function() assert(true) assert(true) end)
	DummyLeste.run()

	assert(DummyLeste.assertions == 5)

	DummyLeste.reset()
end)
