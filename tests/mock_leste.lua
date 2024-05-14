local fs = require("leste.utils.fs")

local path = fs.path() .. fs.sep() .. "leste" .. fs.sep() .. "leste.lua"
local file = fs.readFile(path)

local MockLeste = load(file)()

MockLeste.run = function()
	local assertTemp = assert
    assert = function(...)
    	MockLeste.assertions = MockLeste.assertions + 1
        assertTemp(...)
    end

    for _, test in ipairs(MockLeste.tests) do
        pcall(test.action)
    end

    assert = assertTemp
end

MockLeste.reset = function()
	MockLeste.assertions 	= 0
    MockLeste.verbose 		= false
    MockLeste.exitOnFirst 	= false
    MockLeste.actualFile 	= ""
    MockLeste.stdout 		= {}
    MockLeste.tests 		= {}
end

return MockLeste
