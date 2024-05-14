local Leste = require("leste.leste")
local fs = require("leste.utils.fs")
local cli = require("leste.utils.cli")

local LesteCLI = {}

LesteCLI.program = "lua leste/main.lua"
LesteCLI.usage = ([[
Usage: %s [options] [folder]

Arguments:
    folder                 folder to find tests, default is "./tests"

Options:
    -v, --verbose          display output of print function inside tests, default false
    -x, --exitfirst        exit on first failure, default false
]]):format(LesteCLI.program)

LesteCLI.main = function()
	local flags = cli.getFlags(true)
	local testsFolder = "tests"
	local filePrefix = "test"

	-- update the Leste configs
	Leste.verbose = flags.verbose
	Leste.exitOnFirst = flags.exitOnFirst

	-- get the tests folder or print the usage
	if #arg == 1 then
		testsFolder = arg[1]
	elseif #arg > 1 then
		print(LesteCLI.usage)
	end

	-- apparently, with this code I can load the tests of all files
	-- and put to the `Leste.tests`.
	local path = fs.path() .. fs.sep() .. testsFolder .. fs.sep()
	for _, file in ipairs(fs.listDir(path)) do
		if file:sub(1, #filePrefix) == filePrefix then
			-- save the actual file name to use when `Leste.it` will be triggered.
			Leste.actualFile = file
			dofile(path .. file)

			-- reset
			Leste.actualFile = ""
		end
	end

	-- finally, run the tests. Is that all?
	Leste.run()
end

LesteCLI.main()
