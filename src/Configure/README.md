# Configure  
Load and save Lua table to file as configure.

## API
```Lua
configure.load(file) 
configure.save(file, conf)
configure.print(conf)
```

## Example
```Lua
local configure = require("configure")

local src = {
	window_title    = "Maid.lua",
	window_position = {
		x = 600,
		y = 600
	},
	window_size     = {
		width  = 1920,
		height = 1080
	}
}

configure.save("config.lua", src)
local dst = configure.load("config.lua")
configure.print(dst)
```