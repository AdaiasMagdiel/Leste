--- A testing framework inspired by PestPHP and pytest, designed for Lua.
-- @module Leste

--- Leste 
-- @field verbose boolean Whether to show or not the print output.
-- @field exitOnFirst boolean Whether to stop running tests after the first failure.
-- @field print function A reference to the print function to use for output.
-- @field tests table An array of test cases, where each test case is a table with a string description and a function to execute.
-- @table Leste
local Leste = {
    verbose = false,
    exitOnFirst = false,
    print = print,
    tests = {}
}

--- Adds a new test case to the Leste.tests array.
-- @function it
-- @tparam string describe A description of the test case.
-- @tparam function test The actual test function to execute.
Leste.it = function(describe, test)
    -- I prefer to treat Leste.tests as an array rather than a table to preserve
    -- the order when verifying the Leste.exitOnFirst later.
    Leste.tests[#Leste.tests+1] = {
        describe=describe,
        action=test
    }
end

--- Executes all test cases stored in Leste.tests.
-- @function run
Leste.run = function()
    -- disable print function when is not verbose
    -- Leste saves a reference to print to use when needed.
    if not Leste.verbose then
        print = function() end
    end

    Leste.print('')

    -- run all tests
    for _, test in ipairs(Leste.tests) do
        local result = pcall(test.action)

        Leste.print(test.describe, '      |', result)

        -- exit on first error if exitOnFirst is true
        if result == false and Leste.exitOnFirst then
            break
        end
    end
end

return Leste
