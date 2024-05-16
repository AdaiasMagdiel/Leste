--- A testing framework inspired by PestPHP and pytest, designed for Lua.
-- @module Leste

local console = require("leste.utils.console")


------------------------------------------------------------------------------
-- @field assertions number Total of assertions in all tests.
-- @field disableColor boolean Whether to disable or not the colors in output.
-- @field verbose boolean Whether to show or not the print output.
-- @field exitOnFirst boolean Whether to stop running tests after the first failure.
-- @field actualFile string Field used by CLI to store the file name to use later in output.
-- @field stdout table A table to store the arguments passed to the print function.
-- @field refs table A table with references to functions that will be modified.
-- @field tests table An array of test cases, where each test case is a table with a string description and a function to execute.
-- @table Leste
local Leste = {
    assertions = 0,
    disableColor = false,
    verbose = false,
    exitOnFirst = false,
    actualFile = "",
    stdout = {},
    refs = {
        print = print,
        write = io.write,
        assert = assert
    },
    tests = {},
    errors = {}, -- need documentation
    assertionsReport = ""-- need documentation
}

Leste.beforeAll = function() end
Leste.afterAll = function() end
Leste.beforeEach = function() end
Leste.afterEach = function() end

--- Initializes the testing framework.
-- Modifies the assert and print functions based on the framework's settings.
-- @function init
Leste.init = function()
    -- change the console option to use or not colors in output
    console.disableColor = Leste.disableColor

    -- modify the assert function to count the assertions and save a ref
    -- to the file and line who call
    assert = function(...)
        Leste.assertions = Leste.assertions + 1

        local info = debug.getinfo(3, "Sl")
        if info.short_src == '[C]' then
            info = debug.getinfo(2, "Sl")
        end

        local file = info.short_src
        local line = info.currentline
        local message = ({...})[2] or "Assertion failed: Expected condition to be true, but it's false."

        local ok = pcall(Leste.refs.assert, ...)
        if not ok then
            Leste.errors[#Leste.errors+1] = {
                file=file,
                line=line,
                message=message
            }
            Leste.assertionsReport =
                Leste.assertionsReport ..
                console.format('F', console.FG.RED)
        else
            Leste.assertionsReport =
                Leste.assertionsReport ..
                console.format('.', console.FG.GREEN)
        end
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

--- Resets the testing framework to its initial state.
-- Restores original assert, print, and io.write functions.
-- @function cleanup
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
    Leste.errors = {}
    Leste.assertionsReport = ""
end

--- Adds a new test case to the Leste.tests array.
-- @function it
-- @tparam string describe A description of the test case.
-- @tparam function test The actual test function to execute.
-- @usage Leste.it("This should be true", function()
--     assert(1 == 1)
-- end)
Leste.it = function(describe, test)
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
-- @treturn table Table with the state after all tests with these fields: totalRuntime, testsPassed and testsFailed
Leste.run = function()
    Leste.init()
    Leste.beforeAll()

    local state = {
        totalRuntime = 0,
        testsPassed = 0,
        testsFailed = 0,
    }
    local margin = (" "):rep(4)

    -- Formats seconds into a string representation of minutes and seconds.
    local function formatSeconds(s)
        local minutes = s // 60
        local seconds = math.floor(s % 60)

        return ("%d.%02ds"):format(minutes, seconds)
    end

    -- Calculate the time to execute a function and returns the time, the function status and the err or nil
    local function getExecutionTime(func)
        local start = os.clock()
        local result, err = pcall(func)
        local ellapsed = os.clock() - start

        return ellapsed, result, err
    end

    local function printOverview(test)
        local description = console.format(test.description, console.FG.WHITE, nil, true)
        local overview = ""

        if #Leste.errors == 0 then
            overview = console.format(" PASS ", console.FG.WHITE, console.BG.GREEN, true)
        else
            overview = console.format(" FAIL ", console.FG.WHITE, console.BG.RED, true)
        end

        console.print("\n", margin, overview, "  ", description, "\n")
    end

    local function printConclusion()
        local totalTests  = console.format(("%d tests"):format(#Leste.tests), console.FG.WHITE, nil, true)
        local testsPassed = console.format(("%d passed"):format(state.testsPassed), console.FG.GREEN)
        local testsFailed = console.format(("%d failed"):format(state.testsFailed), console.FG.RED)
        local testsAssertions = ("(%s assertions)"):format(Leste.assertions)
        local resume =
            totalTests .. margin ..
            testsPassed .. margin ..
            testsFailed .. margin ..
            testsAssertions

        if #Leste.tests == 0 then
            console.print(
                "\n", margin,
                console.format("- There's no test to run", console.FG.YELLOW),
                "\n\n"
            )
        elseif Leste.assertions == 0 then
            console.print(
                "\n", margin,
                console.format("- There's no assertion to verify", console.FG.YELLOW),
                "\n\n"
            )
        elseif state.testsFailed > 0 then
            console.print(
                "\n", margin,
                console.format("⨯ Some tests failed", console.FG.RED),
                "\n\n"
            )
        else
            console.print(
                "\n", margin,
                console.format("✓ All tests passed successfully", console.FG.GREEN),
                "\n\n"
            )
        end

        console.print(margin, "Tests:      ", resume, "\n")
        console.print(margin, "Duration:   ", formatSeconds(state.totalRuntime), "\n")
    end

    -- run all tests
    for _, test in ipairs(Leste.tests) do
        Leste.beforeEach()

        local executionTime, result, err = getExecutionTime(test.action)
        state.totalRuntime = state.totalRuntime + executionTime

        -- update passed and failed counter based in result value
        state.testsPassed = state.testsPassed + (#Leste.errors == 0 and 1 or 0)
        state.testsFailed = state.testsFailed + (#Leste.errors == 0 and 0 or 1)

        -- The code below appears to be overly complex
        -- perhaps in the future it would be more effective to break
        -- it down into smaller functions

        printOverview(test)

        console.print("\n", margin, "File:    ", test.file)
        console.print("\n", margin, "Time:    ", formatSeconds(executionTime))
        console.print("\n", margin, "Asserts: ", Leste.assertionsReport, "\n")

        -- Here go the traceback
        if #Leste.errors > 0 then
            console.print(
                "\n",
                console.format("Assertions errors:", console.FG.RED),
                "\n"
            )

            for _, errL in ipairs(Leste.errors) do
                local loc = console.format(errL.file..":"..errL.line..": ", console.FG.WHITE)

                console.print(margin, loc, errL.message, "\n")
            end
        end

        -- Other errors
        if err then
            console.print(
                "\n",
                console.format("Errors:", console.FG.RED),
                "\n"
            )

            console.print(err, "\n")
        end

        -- emulate the print function
        if Leste.verbose and #Leste.stdout > 0 then
            console.print(
                "\n",
                console.format("STDOUT:", console.FG.WHITE),
                "\n"
            )

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
        if (result == false or #Leste.errors > 0) and Leste.exitOnFirst then
            break
        end

        -- Clean up errors after the test
        Leste.errors = {}
        Leste.assertionsReport = ""

        Leste.afterEach()
    end

    printConclusion()

    Leste.afterAll()
    Leste.cleanup()

    return state
end

return Leste
