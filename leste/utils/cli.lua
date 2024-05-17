--- Module leste.utils.cli for parsing command line arguments
-- @module leste.utils.cli

---
-- @field raw {string, ...} The original command line arguments passed to the script.
-- @field args {string, ...} Processed arguments after filtering out flags.
-- @field flags table A table of nested tables of strings containing short (-) and long (--flags) flags extracted from the command line arguments.
-- @table cli
local cli = {
	raw    = arg,
	args   = {},
	flags  = {
		short = {},
		long  = {}
	}
}

--- Checks if a string starts with another string.
-- @function startsWith
-- @tparam string str The string to check.
-- @tparam string value The substring to find at the beginning of `str`.
-- @treturn boolean True if `str` starts with `value`, otherwise false.
local function startsWith(str, value)
	return str:sub(1, #value) == value
end

--- Determines if a table contains a specific value.
-- @function tableContains
-- @tparam table tbl The table to search within.
-- @tparam string value The value to search for in `tbl`.
-- @treturn boolean True if `tbl` contains `value`, otherwise false.
local function tableContains(tbl, value)
	for _, v in pairs(tbl) do
		if v == value then
			return true
		end
	end

	return false
end

--- Removes out flags from the raw command line arguments and stores arguments in `args`.
-- @function fillArgs
cli.fillArgs = function()
	local args = {}

	for _, v in pairs(cli.raw) do
		if _ > 0 and not startsWith(v, "-") then
			args[#args+1] = v
		end
	end

	cli.args = args
end

--- Extracts both short and long flags from the raw command line arguments and categorizes them accordingly.
-- @function extractFlags
cli.extractFlags = function()
	for _, argument in pairs(cli.raw) do
		if startsWith(argument, "--") then
			local flag = argument:sub(3)

			if not tableContains(cli.flags.long, flag) then
				cli.flags.long[#cli.flags.long+1] = flag
			end
		elseif startsWith(argument, "-") then
			local flag = argument:sub(2)

			for char in flag:gmatch(".") do
				if not tableContains(cli.flags.short, char) then
					cli.flags.short[#cli.flags.short+1] = char
				end
			end
		end
	end

	cli.fillArgs()
end

--- Checks if a given short or long flag exists among the parsed flags.
-- @function getFlag
-- @tparam string? short The short flag to check, optional.
-- @tparam string? long The long flag to check, optional.
-- @treturn boolean True if either the short or long flag exists, otherwise false.
cli.getFlag = function(short, long)
	local inLong = tableContains(cli.flags.long, (long or ""):gsub("^-+", ""))
	local inShort = tableContains(cli.flags.short, (short or ""):gsub("^-+", ""))

	return (inLong or inShort)
end

--- Parses command line arguments by extracting flags and processing arguments.
-- @function parse
cli.parse = function()
	cli.extractFlags()
end

return cli
