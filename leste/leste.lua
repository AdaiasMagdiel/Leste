--- A testing framework inspired by PestPHP and pytest, designed for Lua.
-- @module Leste

local function formatSeconds(s)
   local minutes = s // 60
   local seconds = math.floor(s % 60)

   return ("%d.%02ds"):format(minutes, seconds)
end

--- Leste attributes
-- @field assertions number Total of assertions in all tests.
-- @field verbose boolean Whether to show or not the print output.
-- @field exitOnFirst boolean Whether to stop running tests after the first failure.
-- @field actualFile string Field used by CLI to store the file name to use later in output.
-- @field stdout table A table to store the arguments passed to the print function.
-- @field tests table An array of test cases, where each test case is a table with a string description and a function to execute.
-- @table Leste
local Leste = {
    assertions = 0,
    verbose = false,
    exitOnFirst = false,
    actualFile = "",
    stdout = {},
    tests = {}
}

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
    -- disable print function when is not verbose
    -- otherwise, modify the print function to only store the arguments
    -- Leste saves a reference to print to use when needed.
    if not Leste.verbose then
        print = function() end
    else
        print = function(...)
            Leste.stdout[#Leste.stdout+1] = {...}
        end
    end

    -- modify the assert function to count the assertions
    local assertTemp = assert
    assert = function(...)
        Leste.assertions = Leste.assertions + 1
        assertTemp(...)
    end

    -- run all tests
    local totalTime = 0
    local passed = 0
    local failed = 0
    local reset = "\x1b[0m"
    local margin = (" "):rep(4)

    -- run all tests
    for _, test in ipairs(Leste.tests) do
        -- we calculate the time it takes to run the code
        local start = os.clock()
        local result = pcall(test.action)
        local ellapsed = os.clock() - start
        totalTime = totalTime + ellapsed

        -- update passed and failed counter based in result value
        passed = passed + (result and 1 or 0)
        failed = failed + (result and 0 or 1)

        -- The code below appears to be overly complex
        -- perhaps in the future it would be more effective to break
        -- it down into smaller functions

        -- we choice the format and the style of the badge
        -- badge is the square with "pass" or "fail" message
        local badgeText = result and " PASS " or " FAIL "
        local badgeColor = result and "\x1b[1;37;42m" or "\x1b[1;37;41m"
        local badgeTopDown = margin .. badgeColor .. (" "):rep(#badgeText) .. reset
        local badgeCenter  = margin .. badgeColor .. badgeText .. reset

        local description = "  " .. "\x1b[1;37m" .. test.description .. reset

        io.write("\n")
        io.write(badgeTopDown , "\n")
        io.write(badgeCenter  , description , "\n")
        io.write(badgeTopDown , "\n")

        io.write("\n", margin .. "File: " .. test.file, "\n")
        io.write(      margin .. "Time: " .. formatSeconds(ellapsed), "\n")

        if Leste.verbose and #Leste.stdout > 0 then
            io.write("\nstdout:\n")

            for _, item in ipairs(Leste.stdout) do
                -- print each argument separated by a tab, like the original
                -- print function
                for _, arg in ipairs(item) do
                    io.write(tostring(arg) .. "\t")
                end

                -- the print function automatically adds a line break after each
                -- of its arguments.
                io.write('\n')
            end

            io.write("\n")
        end


        -- exit on first error if exitOnFirst is true
        if result == false and Leste.exitOnFirst then
            break
        end

        -- reset the "stdout" after each test
        -- this means to removing all print statements
        Leste.stdout = {}
    end

    local reset = "\x1b[0m"
    local totalTests = "\x1b[1;37m" .. #Leste.tests .. " tests" .. reset
    local testsPassed = "\x1b[32m" .. passed .. " passed"     .. reset
    local testsFailed = "\x1b[1;31m" .. failed .. " failed"     .. reset
    local testsAssertions = " (" .. Leste.assertions .. " assertions)"
    local resumeTestes =
        totalTests  .. (" "):rep(3) ..
        testsPassed .. (" "):rep(3) ..
        testsFailed .. (" "):rep(3) ..
        testsAssertions

    io.write("\n\n")

    if failed > 0 then
        io.write("    \x1b[1;31m" .. '⨯ Some tests failed' .. reset, '\n')
    else
        io.write("    \x1b[32m" .. '✓ All tests passed successfully' .. reset, '\n')
    end

    io.write("    Tests:    " .. resumeTestes, "\n")
    io.write("    Duration: " .. formatSeconds(totalTime), "\n")
end

return Leste
