local Leste = require("leste.leste")
local Assertions = require("leste.assertions")

local function testAssertion(method, ...)
	-- reseting the assert function to the original
	local modAssert = assert
	assert = Leste.refs.assert

	local res = pcall(method, ...)

	-- changing the assert to modified version
	assert = modAssert

	return res
end

Leste.it("test the Assertions.assert method", function()
	local false_ = testAssertion(Assertions.assert, false)
	local true_ = testAssertion(Assertions.assert, true)

	Assertions.notAssert(false_)
	Assertions.assert(true_)
end)

Leste.it("test the Assertions.notAssert method", function()
	local false_ = testAssertion(Assertions.notAssert, true)
	local true_ = testAssertion(Assertions.notAssert, false)

	Assertions.notAssert(false_)
	Assertions.assert(true_)
end)

Leste.it("test the Assertions.equal method", function()
	local false_ = testAssertion(Assertions.equal, 1, 2)
	local true_ = testAssertion(Assertions.equal, 1, 1)

	Assertions.notAssert(false_)
	Assertions.assert(true_)
end)

Leste.it("test the Assertions.notEqual method", function()
	local false_ = testAssertion(Assertions.notEqual, 1, 1)
	local true_ = testAssertion(Assertions.notEqual, 1, 2)

	Assertions.notAssert(false_)
	Assertions.assert(true_)
end)

Leste.it("test the Assertions.tableHasKey method", function()
	local falseA = testAssertion(Assertions.tableHasKey, {1, 2, 3}, 4) --> arr[4]
	local falseB = testAssertion(Assertions.tableHasKey, {["a"] = 1, ["b"] = 2}, "c") --> arr["c"]

	Assertions.notAssert(falseA)
	Assertions.notAssert(falseB)

	local trueA = testAssertion(Assertions.tableHasKey, {1, 2, 3}, 3) --> arr[3]
	local trueB = testAssertion(Assertions.tableHasKey, {["a"] = 1, ["b"] = 2}, "b") --> arr["b"]

	Assertions.assert(trueA)
	Assertions.assert(trueB)
end)

Leste.it("test the Assertions.tableNotHasKey method", function()
	local falseA = testAssertion(Assertions.tableNotHasKey, {1, 2, 3}, 3) --> arr[3]
	local falseB = testAssertion(Assertions.tableNotHasKey, {["a"] = 1, ["b"] = 2}, "b") --> arr["b"]

	Assertions.notAssert(falseA)
	Assertions.notAssert(falseB)

	local trueA = testAssertion(Assertions.tableNotHasKey, {1, 2, 3}, 4) --> arr[4]
	local trueB = testAssertion(Assertions.tableNotHasKey, {["a"] = 1, ["b"] = 2}, "c") --> arr["c"]

	Assertions.assert(trueA)
	Assertions.assert(trueB)
end)

Leste.it("test the Assertions.tableContains method", function()
	local falseA = testAssertion(Assertions.tableContains, {1, 2, 3}                     , 4)
	local falseB = testAssertion(Assertions.tableContains, {["a"] = "foo", ["b"] = "bar"}, "foobar")
	local falseC = testAssertion(Assertions.tableContains, {["foo"] = 1, [1] = "string"} , 2)
	local falseD = testAssertion(Assertions.tableContains, {["foo"] = 1, [1] = "string"} , "bar")

	Assertions.notAssert(falseA)
	Assertions.notAssert(falseB)
	Assertions.notAssert(falseC)
	Assertions.notAssert(falseD)

	local trueA = testAssertion(Assertions.tableContains, {1, 2, 3}                     , 3)
	local trueB = testAssertion(Assertions.tableContains, {["a"] = "foo", ["b"] = "bar"}, "bar")
	local trueC = testAssertion(Assertions.tableContains, {["foo"] = 1, [1] = "string"} , 1)
	local trueD = testAssertion(Assertions.tableContains, {["foo"] = 1, [1] = "string"} , "string")

	Assertions.assert(trueA)
	Assertions.assert(trueB)
	Assertions.assert(trueC)
	Assertions.assert(trueD)
end)

Leste.it("test the Assertions.tableNotContains method", function()
	local falseA = testAssertion(Assertions.tableNotContains, {1, 2, 3}                     , 3)
	local falseB = testAssertion(Assertions.tableNotContains, {["a"] = "foo", ["b"] = "bar"}, "bar")
	local falseC = testAssertion(Assertions.tableNotContains, {["foo"] = 1, [1] = "string"} , 1)
	local falseD = testAssertion(Assertions.tableNotContains, {["foo"] = 1, [1] = "string"} , "string")

	Assertions.notAssert(falseA)
	Assertions.notAssert(falseB)
	Assertions.notAssert(falseC)
	Assertions.notAssert(falseD)

	local trueA = testAssertion(Assertions.tableNotContains, {1, 2, 3}                     , 4)
	local trueB = testAssertion(Assertions.tableNotContains, {["a"] = "foo", ["b"] = "bar"}, "foobar")
	local trueC = testAssertion(Assertions.tableNotContains, {["foo"] = 1, [1] = "string"} , 2)
	local trueD = testAssertion(Assertions.tableNotContains, {["foo"] = 1, [1] = "string"} , "bar")

	Assertions.assert(trueA)
	Assertions.assert(trueB)
	Assertions.assert(trueC)
	Assertions.assert(trueD)
end)
