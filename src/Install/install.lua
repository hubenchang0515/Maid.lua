#! /usr/bin/env lua

function install(libname)
	local template = string.match(package.cpath, "(.-);")
	local target = string.gsub(template, "%?", libname)
	local source
	local cmd
	
	if string.sub(package.config, 1, 1) == "\\" then
		source = libname .. ".dll"
		cmd = "copy /B " .. source .. " " .. target .. "  >nul 2>nul"
	elseif string.sub(package.config, 1, 1) == "/" then
		source = libname .. ".so"
		cmd = "cp " .. source .. " " .. target .. "  >/dev/null 2>&1"
	else
		cmd = nil
	end
	
	if cmd == nil or true ~= os.execute(cmd) then
		print("Install <" .. libname .. "> failed.")
		print("Please copy <" .. source .. "> to LUA_CPATH by yourself.")
		print(string.format("LUA_CPATH : %s", package.cpath))
	else
		print("Install <" .. libname .. "> successful.")
	end
end



