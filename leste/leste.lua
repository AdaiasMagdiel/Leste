--- A testing framework inspired by PestPHP and pytest, designed for Lua.
-- @module Leste

local console = require("leste.utils.console")

local function formatSeconds(s)
   local minutes = s // 60
   local seconds = math.floor(s % 60)

   return ("%d.%02ds"):format(minutes, seconds)
end

------------------------------------------------------------
-- @field assertions number Total of assertions in all tests.
-- @field verbose boolean Whether to show or not the print output.
-- @field exitOnFirst boolean Whether to stop running tests after the first failure.
-- @field actualFile string Field used by CLI to store the file name to use later in output.
-- @field stdout table A table to store the arguments passed to the print function.
-- @field refs table A table with references to functions that will be modified.
-- @field tests table An array of test cases, where each test case is a table with a string description and a function to execute.
-- @table Leste
local Leste = {
    assertions = 0,
    verbose = false,
    exitOnFirst = false,
    actualFile = "",
    stdout = {},
    refs = {
        print = print,
        write = io.write,
        assert = assert
    },
    tests = {}
}

Leste.init = function()
    -- modify the assert function to count the assertions
    assert = function(...)
        Leste.assertions = Leste.assertions + 1
        Leste.refs.assert(...)
    end

    -- disable print function when is not verbose
    -- otherwise, modify the print function to only store the arguments
    -- Leste saves a reference to print to reset later.
    if not Leste.verbose then
        print = function() end
    else
        print = function(...)
            Leste.stdout[#Leste.stdout+1] = {...}
        end
    end
end

Leste.cleanup = function()
    -- reset print, io.write and assert functions
    print = Leste.refs.print
    io.write = Leste.refs.write
    assert = Leste.refs.assert

    -- Reset params
    Leste.assertions = 0
    Leste.verbose = false
    Leste.exitOnFirst = false
    Leste.actualFile = ""
    Leste.stdout = {}
    Leste.tests = {}
end

--- Adds a new test case to the Leste.tests array.
-- @function it
-- @tparam string describe A description of the test case.
-- @tparam function test The actual test function to execute.
-- @usage Leste.it("This should be true", function()
--     assert(1 == 1)
-- end)
Leste.it = function(describe, test)
    -- I prefer to handle Leste.tests as an array rather than a table to preserve
    -- the order when verifying the Leste.exitOnFirst later.
    Leste.tests[#Leste.tests+1] = {
        file=Leste.actualFile,
        description=describe,
        action=test
    }
end

--- Executes all test cases stored in Leste.tests.
-- @function run
-- @usage -- Define the tests
-- Leste.it("This should be true", function()
--     assert(1 == 1)
-- end)
--
-- -- Then, call the run
-- Leste.run()
Leste.run = function()
    Leste.init()

    local console = console.new(Leste.refs.write)

    local state = {
        totalRuntime = 0,
        testsPassed = 0,
        testsFailed = 0,
        margin = (" "):rep(4),
    }

    -- we calculate the time it takes to run each test
    local function getExecutionTime(func)
        local start = os.clock()
        local result = pcall(func)
        local ellapsed = os.clock() - start

        return ellapsed, result
    end

    local function printOverview(result, test)
        local description = console.format(test.description, console.FG.WHITE, nil, true)
        local overview = ""
        if result then
            overview = console.format(" PASS ", console.FG.WHITE, console.BG.GREEN, true)
        else
            overview = console.format(" FAIL ", console.FG.WHITE, console.BG.RED, true)
        end

        console.print("\n", state.margin, overview, "  ", description, "\n")
    end

    local function printConclusion()
        local totalTests  = console.format(("%d tests"):format(#Leste.tests), console.FG.WHITE, nil, true)
        local testsPassed = console.format(("%d passed"):format(state.testsPassed), console.FG.GREEN)
        local testsFailed = console.format(("%d failed"):format(state.testsFailed), console.FG.RED, nil, true)
        local testsAssertions = ("(%s assertions)"):format(Leste.assertions)
        local resume =
            totalTests .. state.margin ..
            testsPassed .. state.margin ..
            testsFailed .. state.margin ..
            testsAssertions

        if state.testsFailed > 0 then
            console.print(
                "\n",
                console.format(("%s⨯ Some tests failed"):format(state.margin), console.FG.WHITE, nil, true),
                "\n\n"
            )
        else
            console.print(
                "\n",
                console.format(("%s✓ All tests passed successfully"):format(state.margin), console.FG.GREEN),
                "\n\n"
            )
        end

        console.print(state.margin, "Tests:    ", resume, "\n")
        console.print(state.margin, "Duration: ", formatSeconds(state.totalRuntime), "\n")
    end

    -- run all tests
    for _, test in ipairs(Leste.tests) do
        local executionTime, result = getExecutionTime(test.action)
        state.totalRuntime = state.totalRuntime + executionTime

        -- update passed and failed counter based in result value
        state.testsPassed = state.testsPassed + (result and 1 or 0)
        state.testsFailed = state.testsFailed + (result and 0 or 1)

        -- The code below appears to be overly complex
        -- perhaps in the future it would be more effective to break
        -- it down into smaller functions

        printOverview(result, test)

        console.print("\n", state.margin, "File: ", test.file)
        console.print("\n", state.margin, "Time: ", formatSeconds(executionTime), "\n\n")

        if Leste.verbose and #Leste.stdout > 0 then
            console.print("stdout:", "\n")

            for _, item in ipairs(Leste.stdout) do
                -- print each argument separated by a tab, like the original
                -- print function
                for _, arg in ipairs(item) do
                    console.print(tostring(arg), "\t")
                end

                -- the print function automatically adds a line break.
                console.print('\n')
            end

            -- reset the "stdout" after priting
            Leste.stdout = {}
            console.print('\n')
        end

        -- exit on first error if exitOnFirst is true
        if result == false and Leste.exitOnFirst then
            break
        end
    end

    printConclusion()

    Leste.cleanup()
end

return Leste
