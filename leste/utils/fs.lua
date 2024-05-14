--- Provides file system operations such as reading files, executing commands, and listing directory contents.
-- @module leste.utils.fs

local fs = {}

--- Returns the operating system type: "win" for Windows, "unix" for Unix-like systems.
-- @function fs.system
-- @treturn string The operating system type.
function fs.system()
	return package.config:sub(1,1) == "\\" and "win" or "unix"
end

--- Reads the content of a file.
-- @function fs.readFile
-- @tparam string filepath The path to the file to read.
-- @tparam function action Optional. The function to open the file. Defaults to `io.open`.
-- @treturn string The content of the file.
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

--- Executes a command and returns its output.
-- @function fs.exec
-- @tparam table commands A table with "win" and "unix" keys specifying the commands to execute on each OS.
-- @treturn string The output of the executed command.
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

--- Returns the file separator character based on the operating system.
-- @function fs.sep
-- @treturn string The file separator character.
function fs.sep()
	local sep = ""

	if fs.system == "win" then
		sep = "\\"
	else
		sep = "/"
	end

	return sep
end

--- Gets the current working directory.
-- @function fs.path
-- @treturn string The current working directory.
function fs.path()
	local content = fs.exec({
		win="cd",
		unix="pwd"
	})

	content = content:gsub("\n", "")
	return content
end

--- Lists the contents of a directory.
-- @function fs.listDir
-- @tparam string path Optional. The path to the directory. Defaults to the current working directory.
-- @treturn table A table of filenames in the directory.
function fs.listDir(path)
	path = path or fs.path()

	local content = fs.exec({
		win=('dir /b "%s"'):format(path),
		unix=('ls -a "%s"'):format(path)
	})

	local files = {}

	for str in content:gmatch("([^\n]+)") do
		-- function to trim string
		-- ref: https://www.lua.org/pil/20.3.html
		local file = (str:gsub("^%s*(.-)%s*$", "%1"))

		if file ~= "." and file ~= ".." then
			files[#files+1] = file
		end
	end

	return files
end

return fs
