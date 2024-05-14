local fs = require("leste.utils.fs")

local path = fs.path() .. fs.sep() .. "leste" .. fs.sep() .. "leste.lua"
local file = fs.readFile(path)

local D = load(file)()

D.reset = function()
	D.assertions 	= 0
    D.verbose 		= false
    D.exitOnFirst 	= false
    D.actualFile 	= ""
    D.stdout 		= {}
    D.tests 		= {}
end

return D
