local console = {}

console.new = function(print)
	local con = {
		write = print,
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

	function con.format(text, fg, bg, bold)
		local style = "\x1b["
		local sep = ""

		if bold then
			style = style .. "1"
		end

		if fg then
			sep = bold and ";" or ""
			style = style .. sep .. fg
		end

		if bg then
			sep = sep == ";" and ";" or ""
			style = style .. sep .. bg
		end

		return style .. "m" .. text .. "\x1b[0m"
	end

	function con.print(...)
		con.write(...)
	end

	return con
end

return console

-- format(fg, bg, bold)
