local Leste = require("leste.leste")
local fs = require("leste.utils.fs")
local cli = require("leste.utils.cli")

local LesteCLI = {}

LesteCLI.main = function()
	local flags = cli.getFlags(true)

	Leste.verbose = flags.verbose
	Leste.exitOnFirst = flags.exitOnFirst

	for _, file in ipairs(fs.listDir()) do
		print(file)
	end

	-------------------------------------
	-- @todo: Get the tests folder from the command line, if none is passed, default to 'tests/'
	-- @todo: Iterate over all files that start with 'test' (e.g.: testLeste.lua or test_leste.lua)
	-- @todo: Collect all Leste.it functions from these files and execute all of them using Leste.run (I don't know how I will do this, but I will discover it) 
end

LesteCLI.main()
