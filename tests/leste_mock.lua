local fs = require("leste.utils.fs")

-- I need all the stuff to deepcopy the Leste module
-- otherwise, there may be some collateral effects.
local path = fs.path() .. fs.sep() .. "leste" .. fs.sep() .. "leste.lua"
local file = fs.readFile(path)

local LesteMock = load(file)()

-- Like the real module
LesteMock.beforeAll = function () end
LesteMock.afterAll = function () end
LesteMock.beforeEach = function () end
LesteMock.afterEach = function () end

-- Similar to the assert modification in Leste.init
LesteMock.assert = function(...)
    LesteMock.assertions = LesteMock.assertions + 1
    LesteMock.refs.assert(...)
end

-- This mock function aims to replicate the essence of Leste.run
-- in order to achieve a similar outcome.
LesteMock.run = function()
    LesteMock.beforeAll()

    local state = {
        totalRuntime = 0,
        testsPassed = 0,
        testsFailed = 0,
    }

    for _, test in ipairs(LesteMock.tests) do
        LesteMock.beforeEach()

        local result = pcall(test.action)

        state.testsPassed = state.testsPassed + (result and 1 or 0)
        state.testsFailed = state.testsFailed + (result and 0 or 1)

        LesteMock.afterEach()
    end

    LesteMock.afterAll()

    return state
end

-- Reset the module
LesteMock.reset = function()
    LesteMock.tests = {}
    LesteMock.assertions = 0
    LesteMock.beforeAll = function () end
    LesteMock.afterAll = function () end
    LesteMock.beforeEach = function () end
    LesteMock.afterEach = function () end
end

return LesteMock
