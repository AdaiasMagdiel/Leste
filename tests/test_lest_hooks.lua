local Assertions = require("leste.assertions")
local Leste = require("leste.leste")
local LesteMock = require("tests.leste_mock")

Leste.it("call beforeAll once before all tests", function ()
	LesteMock.counter = 0

	LesteMock.beforeAll = function()
		LesteMock.counter = LesteMock.counter + 1
	end

	LesteMock.it("1", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("2", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("3", function() LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("4", function() LesteMock.assert(LesteMock.counter == 1) end)
	local state = LesteMock.run()

	Assertions.equal(#LesteMock.tests, 4)
	Assertions.equal(state.testsFailed, 0)

	LesteMock.reset()
end)

Leste.it("call afterAll once after all tests", function ()
	LesteMock.counter = 0

	LesteMock.afterAll = function()
		LesteMock.counter = -1
	end

	LesteMock.it("1", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("2", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("3", function() LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("4", function() LesteMock.assert(LesteMock.counter == 0) end)
	local state = LesteMock.run()

	Assertions.equal(#LesteMock.tests, 4)
	Assertions.equal(state.testsFailed, 0)
	Assertions.equal(LesteMock.counter, -1)

	LesteMock.reset()
end)

Leste.it("call beforeEach before each test", function ()
	LesteMock.counter = 0

	LesteMock.beforeEach = function ()
		LesteMock.counter = LesteMock.counter + 1
	end

	LesteMock.it("1", function () LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("2", function () LesteMock.assert(LesteMock.counter == 2) end)
	LesteMock.it("3", function () LesteMock.assert(LesteMock.counter == 3) end)
	LesteMock.it("4", function () LesteMock.assert(LesteMock.counter == 4) end)
	local state = LesteMock.run()

	Assertions.equal(#LesteMock.tests, 4)
	Assertions.equal(LesteMock.counter, #LesteMock.tests)
	Assertions.equal(state.testsFailed, 0)

	LesteMock.reset()
end)

Leste.it("call afterEach after each test", function ()
	LesteMock.counter = 0

	LesteMock.afterEach = function ()
		LesteMock.counter = LesteMock.counter + 1
	end

	LesteMock.it("1", function () LesteMock.assert(LesteMock.counter == 0) end)
	LesteMock.it("2", function () LesteMock.assert(LesteMock.counter == 1) end)
	LesteMock.it("3", function () LesteMock.assert(LesteMock.counter == 2) end)
	LesteMock.it("4", function () LesteMock.assert(LesteMock.counter == 3) end)
	local state = LesteMock.run()

	Assertions.equal(#LesteMock.tests, 4)
	Assertions.equal(LesteMock.counter, #LesteMock.tests)
	Assertions.equal(state.testsFailed, 0)

	LesteMock.reset()
end)
