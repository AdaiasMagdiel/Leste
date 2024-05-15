local Leste = require("leste.leste")
local LesteMock = require("tests.leste_mock")


Leste.it("the it method can store tests", function ()
	assert(#LesteMock.tests == 0)

	local testFunction = function() end
	LesteMock.it("add a new test", testFunction)

	assert(#LesteMock.tests == 1)
	assert(LesteMock.tests[1].action == testFunction)

	LesteMock.reset()
end)

Leste.it("the it method add the description with the test", function ()
	LesteMock.it("add a description to test", function() end)

	assert(#LesteMock.tests == 1)
	assert(LesteMock.tests[1].description == "add a description to test")

	LesteMock.reset()
end)

Leste.it("leste can update the total of assertions", function ()
	LesteMock.it("1", function() LesteMock.assert(true) end)
	LesteMock.it("2", function() LesteMock.assert(true) end)
	LesteMock.it("3", function() LesteMock.assert(true) LesteMock.assert(true) end)
	LesteMock.run()

	assert(#LesteMock.tests == 3)
	assert(LesteMock.assertions == 4)

	LesteMock.reset()
end)

Leste.it("leste call beforeAll once before all tests", function ()
	LesteMock.counter = 0

	LesteMock.beforeAll = function()
		LesteMock.counter = LesteMock.counter + 1
	end

	LesteMock.it("1", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("2", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("3", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("4", function() LesteMock.assert(LesteMock.counter == 1) end)
	local state = LesteMock.run()

	assert(#LesteMock.tests == 4)
	assert(state.testsFailed == 0)

	LesteMock.counter = nil
	LesteMock.reset()
end)

Leste.it("leste call afterAll once before all tests", function ()
	-- This test is not working but I will fix then later.
	LesteMock.counter = 0

	LesteMock.afterAll = function()
		LesteMock.counter = -1
	end

	LesteMock.it("1", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("2", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("3", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("4", function() LesteMock.assert(LesteMock.counter == 0) end)
	local state = LesteMock.run()

	assert(#LesteMock.tests == 4)
	assert(state.testsFailed == 0)
	assert(LesteMock.counter == -1)

	LesteMock.counter = nil
	LesteMock.reset()
end)
