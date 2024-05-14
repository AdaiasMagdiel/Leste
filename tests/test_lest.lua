local Leste = require("leste.leste")
local MockLeste = require("tests.mock_leste")


Leste.it("the it method can store tests", function ()
	local totalTests = #MockLeste.tests

	local testFunction = function() assert(true) end
	MockLeste.it("dummy test example", testFunction)

	assert(totalTests ~= #MockLeste.tests)
	assert(#MockLeste.tests == 1)
	assert(MockLeste.tests[1].action == testFunction)

	MockLeste.reset()
end)

Leste.it("the it method add the description with the test", function ()
	local totalTests = #MockLeste.tests

	MockLeste.it("a description example", function() end)

	assert(totalTests ~= #MockLeste.tests)
	assert(#MockLeste.tests == 1)
	assert(MockLeste.tests[1].description == "a description example")

	MockLeste.reset()
end)

Leste.it("leste can update the total of assertions", function ()
	MockLeste.it("a", function() assert(true) end)
	MockLeste.it("b", function() assert(true) end)
	MockLeste.it("c", function() assert(true) end)
	MockLeste.it("d", function() assert(true) assert(true) end)
	MockLeste.run()

	assert(MockLeste.assertions == 5)

	MockLeste.reset()
end)
