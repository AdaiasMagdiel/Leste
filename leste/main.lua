--- A CLI interface for running tests using the Leste testing framework.
-- @module LesteCLI

local Leste = require("leste.leste")
local fs = require("leste.utils.fs")
local cli = require("leste.utils.cli")

local LesteCLI = {}

-- @field LesteCLI.program string The program command to run.
LesteCLI.program = "leste"


-- @field LesteCLI.usage string Usage instructions for the CLI.
LesteCLI.usage = ([[
Usage: %s [options] [folder]

Arguments:
    folder                 Folder to find tests, default is "./tests"

Options:
    -d, --disable-color    Disable color for the output, print raw text
    -h, --help             Show this help message and exit.
    -v, --verbose          Display output of print function inside tests, default false
    -x, --exitfirst        Exit on first failure, default false
]]):format(LesteCLI.program)


--- Main function to run the Leste testing framework via CLI.
-- @function LesteCLI.main
LesteCLI.main = function()
	cli.parse()

	local testsFolder = "tests"
	local filePrefix = "test"

	-- update the Leste configs
	Leste.disableColor 	= cli.getFlag('-d', "--disable-color")
	Leste.verbose 		= cli.getFlag('-v', "--verbose")
	Leste.exitOnFirst 	= cli.getFlag('-x', "--exitfirst")

	-- help mode
	if cli.getFlag('-h', "--help") then
		print(LesteCLI.usage)
		os.exit(0)
	end

	-- get the tests folder or print the usage
	if #cli.args == 1 then
		testsFolder = cli.args[1]
	elseif #cli.args > 1 then
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
