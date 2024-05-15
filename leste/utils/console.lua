--- Console module for output and style.
-- @module leste.utils.console

------------------------------------------------------------------------------
-- @field print function Function to print text, defaults to io.write
-- @field FG Foreground color codes.
-- @field BG Background color codes.
-- @table console
local console = {
	print = io.write,
	FG = {
		BLACK 	= 30,
		RED 	= 31,
		GREEN 	= 32,
		YELLOW 	= 33,
		BLUE 	= 34,
		MAGENTA = 35,
		CYAN 	= 36,
		WHITE 	= 37
	},
	BG = {
		BLACK 	= 40,
		RED 	= 41,
		GREEN 	= 42,
		YELLOW 	= 43,
		BLUE 	= 44,
		MAGENTA = 45,
		CYAN 	= 46,
		WHITE 	= 47
	}
}

--- Formats text with specified foreground and background colors, and optionally bold.
-- @tparam string text The text to format.
-- @tparam number|nil fg The foreground color code, or nil for default.
-- @tparam number|nil bg The background color code, or nil for default.
-- @tparam boolean bold Whether to apply bold styling.
-- @treturn string The formatted text.
function console.format(text, fg, bg, bold)
	local style = "\27["
	local sep = ""

	if bold then
		style = style .. "1;"
	end

	if fg then
		style = style .. fg .. ";"
	end

	if bg then
		style = style .. sep .. bg .. ";"
	end

	style = style:gsub(";$", "")

	return style .. "m" .. text .. "\27[0m"
end

return console
