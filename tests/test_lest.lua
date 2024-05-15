local Assertions = require("leste.assertions")
local Leste = require("leste.leste")
local LesteMock = require("tests.leste_mock")

Leste.it("verify if it method can store tests", function ()
	Assertions.equal(#LesteMock.tests, 0)

	local testFunction = function() end
	LesteMock.it("add a new test", testFunction)

	Assertions.equal(#LesteMock.tests, 1)
	Assertions.equal(LesteMock.tests[1].action, testFunction)
	LesteMock.reset()
end)

Leste.it("verify if the it method add the description with the test", function ()
	LesteMock.it("add a description to test", function() end)

	Assertions.equal(#LesteMock.tests, 1)
	Assertions.equal(LesteMock.tests[1].description, "add a description to test")
	LesteMock.reset()
end)

Leste.it("verify if it can update the total of assertions", function ()
	LesteMock.it("1", function() LesteMock.assert(true) end)
	LesteMock.it("2", function() LesteMock.assert(true) end)
	LesteMock.it("3", function() LesteMock.assert(true) LesteMock.assert(true) end)
	LesteMock.run()

	Assertions.equal(#LesteMock.tests, 3)
	Assertions.equal(LesteMock.assertions, 4)
	LesteMock.reset()
end)
