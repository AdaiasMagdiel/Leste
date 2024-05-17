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
Usage: %s [options] [file/folder...]

Arguments:
	file                   File (or files) with tests to run.
    folder                 Folder (or folders) to find tests, default is "./tests"

Options:
    -d, --disable-color    Disable color for the output, print raw text
    -h, --help             Show this help message and exit.
    -v, --verbose          Display output of print function inside tests, default false
    -x, --exitfirst        Exit on first failure, default false

Examples:
    leste -v
    leste -vx
    leste --disable-color -x
    leste -v my-tests-folder
    leste my_test.lua
    leste test_file.lua folder-with-tests -vx
]]):format(LesteCLI.program)

local function loadFile(file, prefix)
	-- print('>', file, fs.filename(file))

	if fs.filename(file):sub(1, #prefix) == prefix then
		-- print('>>')
		-- save the actual file name to use when `Leste.it` will be triggered.
		Leste.actualFile = file
		dofile(file)

		-- reset
		Leste.actualFile = ""
	end
end

local function loadFolder(folder, prefix)
	local path = fs.path() .. fs.sep() .. folder .. fs.sep()

	for _, file in ipairs(fs.listDir(path)) do
		loadFile(path .. file, prefix)
	end
end

--- Main function to run the Leste testing framework via CLI.
-- @function LesteCLI.main
LesteCLI.main = function()
	cli.parse()

	local filePrefix = "test"
	local testsFolder = "tests"

	-- update the Leste configs
	Leste.disableColor 	= cli.getFlag('-d', "--disable-color")
	Leste.verbose 		= cli.getFlag('-v', "--verbose")
	Leste.exitOnFirst 	= cli.getFlag('-x', "--exitfirst")

	-- help mode
	if cli.getFlag('-h', "--help") then
		print(LesteCLI.usage)
		os.exit(0)
	end

	if #cli.args == 0 then
		if not fs.exists(testsFolder) then
			print("Error: Unable to locate the './tests' folder.")
			os.exit(1)
		else
			loadFolder(testsFolder, filePrefix)
			Leste.run()
		end
	else
		local loaded = 0

		for _, argument in ipairs(cli.args) do
			if not fs.exists(fs.path() .. fs.sep() .. argument) then
				print("Warning: '"..argument.."' is not found.")
			else
				if fs.isFile(argument) then
					local path = fs.path() .. fs.sep()
					loadFile(path .. argument, "")
				else
					loadFolder(argument, filePrefix)
				end

				loaded = loaded + 1
			end
		end

		if loaded > 0 then
			Leste.run()
		end
	end
end

LesteCLI.main()
