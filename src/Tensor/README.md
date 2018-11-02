# Tensor
Create fixed-size Tensor

## API
```Lua
-- require
Tensor = require("Tensor")

-- function
function Tensor:Vector(length)
function Tensor:Matrix(width, height)
function Tensor:Tensor( ... )
```

## Example
```Lua
Tensor = require("Tensor")

vector = Tensor:Vector(5)
matrix = Tensor:Matrix(5, 5)
tensor = Tensor:Tensor(5, 5, 5, 5, 5, 5)
```