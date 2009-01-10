--------------------------------------------------------------------------------
-- This library contains a function for invoking tools from properties files.
-- It also contains numerous general tools.
-- The function InvokeTool() can be called from properties files.  Pass the name
-- of either a global function or a name in object.method notation.  Example:
-- 	command.name.11.*=Test
-- 	command.mode.11.*=subsystem:lua
-- 	command.11.*=InvokeTool GlobalFunction
-- Or:
-- 	command.name.11.*=Test
-- 	command.mode.11.*=subsystem:lua
-- 	command.11.*=InvokeTool TheObject.TheFunction
-- It is also possible to pass arguments to the function.  Arguments may appear
-- as a whitespace delimited list after the function name.  Example:
-- 	command.name.11.*=Test
-- 	command.mode.11.*=subsystem:lua
-- 	command.11.*=InvokeTool TheObject.TheFunction Arg1 Arg2
-- The function will receive each argument separately using conventional syntax.
--------------------------------------------------------------------------------
Tools = Class:new(Common)

--------------------------------------------------------------------------------
-- InvokeTool(s)
--
-- Invokes a tool.  This can be called from commands as: InvokeTool <function>.
--
-- Parameters:
--	s - A string containing the name of a function.  The accepted syntax is
-- 	either the name of a global function or object.method notation.  Other
--	arguments may be specified after the string name.  These are whitespace
--	delimited and will be passed as arguments to the invoked function.
--
-- Returns:
--	The return value of the invoked tool.
--------------------------------------------------------------------------------
function InvokeTool(s)
	-- Look for object.method notation.
	local obj, fn = s:match("([^%s]+)%.([^%s]+)")
	local args = { }

	-- Iterate the string building an argument table
	for arg in s:gmatch("[^%s]+") do
		table.insert(args, arg)
	end

	if obj and fn then
		-- Look up the object in the global table.
		obj = _G[obj]
		if obj then
			-- Look up the function in the object's table.
			fn = obj[fn]
			if fn then
				-- Call the function and pass obj as self.  Also unpack the
				-- args array to the called function.  The first element is the
				-- function name so skip it.
				return fn(obj, unpack(args, 2))
			end
		end
	else
		fn = s:match("([^%s]+)")
		print("fn: " .. fn)
		-- Look up the function in the global table.
		if fn then
			fn = _G[fn]
		end
		if fn then
			-- Call the function.  Also unpack the args array to the called
			-- function.  The first element is the function name so skip it.
			return fn(unpack(args, 2))
		end
	end
	-- If we fall through to here, print an error.
	error('工具 "' .. s .. '" 不存在.')
end	-- InvokeTool()

--------------------------------------------------------------------------------
-- CreateTools()
--
-- Scans the global table LoadLuaFileList (auto-generated by LoadLuaFile.
-- For each file in the list, it opens it and iterates each line looking for
-- "-- Tool <function> <file pattern> <mode> <shortcut> <name>".  A
-- "shortcuts.properties" file is generated form any matching lines.  The
-- location of this file can be specified by setting the property
-- "shortcuts.properties=Full\Path\To\File".  Otherwise, the default path of
-- "$(SciTEDefaultHome)\shortcuts.properties" will be used.
--
-- The format of each field is as follows:
--	function - The name of the function to invoke, either in method or
--		object.method notation.
-- 	file pattern - Can be *.pat, *, or $(var)
-- 	mode - A command.mode string (except the subsystem).  savebefore is required
--		or the tool will not be created.
-- 	shortcut - Can be a shortcut or none
-- 	name - What will appear in the Tools menu
--
-- Tool: Tools.CreateTools * savebefore:no none Create Tools and Shortcuts
--------------------------------------------------------------------------------
function Tools:CreateTools()
	-- If the global table doesn't exist, we need to fail.
	if not LoadLuaFileList then
		error("File list not found.")
		return
	end
	-- The pattern we search for.
	local pattern = "^-- Tool:%s+([%w%.]+)%s+(%S+)%s+(%S+)%s+(%S+)%s+(.+)"
	-- The start index for the tool commands.
	local n = 11
	-- The output data.
	local data = "# Auto-generated by Tools:CreateTools()\n\n"
	-- Iterate each file in the table.
	for i, path in ipairs(LoadLuaFileList) do
		-- Open the file and iterate over each line.
		for line in io.lines(path)do
			local from, to, name, pat, mode, keys, description = line:find(pattern)
			if from then
				if mode:match("[Ss][Aa][Vv][Ee][Bb][Ee][Ff][Oo][Rr][Ee]:") then
					-- Build the command.
					data = data ..
						"command.name." .. n .. "." .. pat .. "=" .. description .. "\n" ..
						"command.mode." .. n .. "." .. pat .. "=subsystem:lua," .. mode .. "\n" ..
						"command." .. n .. "." .. pat .. "=InvokeTool " .. name .. "\n"
					if keys ~= "none" then
						data = data .. "command.shortcut." .. n .. "." .. pat .. "=" .. keys .. "\n"
					end
					data = data .. "\n"
					n = n + 1
				else
					print("Invalid tool mode specification: " .. mode .. " for tool \"" .. description .. "\"")
				end
			end
		end
	end
	-- Default to using $(SciTEDefaultHome\shortcut.properties
	local out_file = props["SciteDefaultHome"] .. "\\shortcuts.properties"
	-- If this property is set, use that path instead of the default.
	if props["shortcuts.properties"] ~= "" then
		out_file = props["shortcuts.properties"]
	end
	-- Write the output file.
	local out = io.open(out_file, "w")
	if out then
		out:write(data)
		out:close()
		-- Let the user know things went okay.
		print(out_file .. " 已经更新.")
	else
		print("写入失败: " .. out_file)
	end
end	-- CreateTools()

--------------------------------------------------------------------------------
-- InsertNull()
--
-- Inserts a NULL character into the document.
--
-- Tool: Tools.InsertNull * savebefore:no,groupundo:yes Ctrl+0 Insert Null Character
--------------------------------------------------------------------------------
function Tools:InsertNull()
	editor:AddText(string.char(0))
end	-- InsertNull()

--------------------------------------------------------------------------------
-- ReplaceTabsWithSpaces()
--
-- Replaces tab characters with space characters.
--
-- Tool: Tools.ReplaceTabsWithSpaces * savebefore:no,groupundo:yes none Replace Tabs With Spaces
--------------------------------------------------------------------------------
function Tools:ReplaceTabsWithSpaces()
	self:ReplaceCharacters("\t", string.rep(" ", editor.TabWidth))
end	-- ReplaceTabsWithSpaces()

--------------------------------------------------------------------------------
-- ReplaceSpacesWithTabs()
--
-- Replaces space characters with tabs.
--
-- Tool: Tools.ReplaceSpacesWithTabs * savebefore:no,groupundo:yes none Replace Spaces With Tabs
--------------------------------------------------------------------------------
function Tools:ReplaceSpacesWithTabs()
	self:ReplaceCharacters(string.rep(" ", editor.TabWidth), "\t")
end	-- ReplaceSpacesWithTabs()
