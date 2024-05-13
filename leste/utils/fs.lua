local fs = {}

function fs.system()
	return package.config:sub(1,1) == "\\" and "win" or "unix"
end

function fs.sep()
	local sep = ""

	if fs.system == "win" then
		sep = "\\"
	else
		sep = "/"
	end

	return sep
end

function fs.path()
	local command = ""

	if fs.system == "win" then
		command = "cd"
	else
		command = "pwd"
	end

	local handle = io.popen(command, "r")

	if handle == nil then
		error("An error occurred while trying to get path.")
	end

	local content = handle:read("*a")
	handle:close()

	return string.gsub(content, "\n", "")
end

function fs.readFile(filepath)
	local file = io.open(filepath, "r")

	if file == nil then
		error("An error occurred while trying to read file.")
	end

	local content = file:read("*a")
	file:close()

	return content
end

return fs
