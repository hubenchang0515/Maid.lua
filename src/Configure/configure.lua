#! /usr/bin/env lua

--[[
configure.load(file) 
configure.save(file, config)
configure.print(config)
--]]

local configure = {}

-- check argument type
function configure.type(value, typename, index)
	if type(value) ~= typename then
		error(string.format("bad argument #%d (%s expected, got %s)",
				index, typename, type(value))
				, 3)
	end
	
	return true
end


-- write text width enough \t
function configure.subwrite(text, deepth, fp)
	fp = fp or io.output()
	deepth = deepth or 0
	for i = 1,deepth do
		fp:write("\t")
	end
	fp:write(text)
end

-- write config to fp
function configure.write(config, deepth, fp)
	fp = fp or io.output()
	deepth = deepth or 0
	configure.subwrite("{\n", 0, fp)
	for key,value in pairs(config) do 
		configure.subwrite(key, deepth+1, fp)
		if type(value) == "table" then
			configure.subwrite(" \t= ", 0, fp)
			configure.write(value, deepth+1, fp)
		elseif type(value) == "string" then
			configure.subwrite(string.format(" \t= '%s'\n", value), 0, fp)
		else
			configure.subwrite(" \t= "..value.."\n", 0, fp)
		end
	end
	configure.subwrite("}\n", deepth, fp)
end

-- load config
function configure.load(file)
	configure.type(file, "string", 1)
	
	local config = loadfile(file, "t")
	local state , value = pcall(config)
	if type(value) == "table" then
		return value
	else
		return nil
	end
end

-- save config to file
function configure.save(file, config)
	configure.type(config, "table", 1)
	configure.type(file, "string", 2)

	fp = io.open(file, "w")
	fp:write("return ")
	configure.write(config, 0, fp)
	fp:close()
end

-- print config on stdout
function configure.print(config)
	io.write("return ")
	configure.write(config)
end



return configure