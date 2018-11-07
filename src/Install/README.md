#Install
Install shared library to LUA_CPATH

## API
```Lua
function install(libname)
```

## Example
```Lua
require("install")
install("libsdluna")
-- Copy the shared library to correct path.
-- May be
--   Linux: cp libsdluna.so /usr/local/lib/lua/5.3/libsdluna.so
-- Windows: copy /B libsdluna.dll C:\{path to lua}\lua\5.3\libsdluna.dll
```