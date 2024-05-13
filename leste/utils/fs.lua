local fs = {}

function fs.system()
	return package.config:sub(1,1) == "\\" and "win" or "unix"
end

function fs.readFile(filepath, action)
	action = action or io.open
	local file = action(filepath, "r")

	if file == nil then
		error("An error occurred while trying to read file.")
	end

	local content = file:read("*a")
	file:close()

	return content
end

function fs.exec(commands)
	local command = ""
	if fs.system() == "win" then
		command = commands.win
	else
		command = commands.unix
	end

	local content = fs.readFile(command, io.popen)
	return content
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
	local content = fs.exec({
		win="cd",
		unix="pwd"
	})

	content = content:gsub("\n", "")
	return content
end

function fs.listDir(path)
	path = path or fs.path()

	local content = fs.exec({
		win=('dir /b "%s"'):format(path),
		unix=('ls -a "%s"'):format(path)
	})

	local files = {}

	---------------------------------------------------
	-- @todo: split the content in \n and trim each file to get files

	return files
end

return fs
