--- The `cli` module provides functions for parsing command-line arguments.
-- @module leste.utils.cli

local cli = {}

--- Removes flags (arguments starting with "-") from the given table of arguments.
-- @tparam table args The table of arguments to process.
-- @treturn table A new table containing only non-flag arguments, can be assigned to the global `arg` table.
cli.removeFlags = function(args)
	local items = {}

	for _, option in ipairs(args) do
		if option:sub(1, 1) ~= "-" then
			items[#items+1] = option
		end
	end

	return items
end

--- Parses command-line arguments and returns a table containing parsed flags.
-- @tparam boolean removeFromArg If true, removes parsed flags from the global `arg` table. Defaults to false.
-- @treturn table A table containing parsed flags:<br>
-- `verbose` (boolean): True if the `--verbose` or `-v` flag is present.<br>
-- `exitOnFirst` (boolean): True if the `--exitfirst` or `-x` flag is present.
cli.getFlags = function(removeFromArg)
	local flags = {
		disableColor = false,
		verbose = false,
		exitOnFirst = false,
	}

	for _, flag in ipairs(arg) do
		-- verify if argument starts with --
		if flag:sub(1, 2) == "--" then
			-- compare the option or get the current state, if don't match
			-- but flag is already true then don't change to false
			flags.disableColor 	= flag:sub(3) == "disable-color"  or flags.disableColor
			flags.verbose 		= flag:sub(3) == "verbose" 		  or flags.verbose
      		flags.exitOnFirst 	= flag:sub(3) == "exitfirst" 	  or flags.exitOnFirst

		-- short option, single -
		elseif flag:sub(1, 1) == "-" then
			-- get the option without -
			local option = flag:sub(2)

			-- iters over each char of option and compare
			local i = 1
			while i <= #option do
				local c = option:sub(i, i)

				if c == "d" then
					flags.disableColor = true
				elseif c == "v" then
					flags.verbose = true
				elseif c == "x" then
					flags.exitOnFirst = true
				end

				i = i + 1
			end
		end
	end

	if removeFromArg then
		arg = cli.removeFlags(arg)
	end

	return flags
end

return cli
