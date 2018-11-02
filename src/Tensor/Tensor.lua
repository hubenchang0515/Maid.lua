#! /usr/bin/env lua
local Tensor = {}

Tensor.meta = {}
-- Forbid user to add element
function Tensor.meta.__newindex(t, k)
	error(string.format("Index %s by %d whose length is %d", t, k, #t), 2)
end

-- Create 1-Dimensional Vector
function Tensor:Vector(length)
	local vector = {}
	
	for i = 1, length do
		vector[i] = 10
	end
	
	setmetatable(vector, Tensor.meta)
	
	return vector
end


-- Create 2-Dimensional Matrix
function Tensor:Matrix(width, height)
	local matrix = {}
	
	for row = 1, height do
		matrix[row] = {}
		for column = 1, width do
			matrix[row][column] = 0
		end
		setmetatable(matrix[row], Tensor.meta)
	end
	setmetatable(matrix, Tensor.meta)
	
	return matrix
end

-- Create Multi-Dimensional Tensor
function Tensor:Tensor( ... )
	local args = { ... }
	local tensor = {} -- Create current dimension
	
	-- parameters of next dimensional tensor 
	local low = {}
	for i = 2,#args do
		low[i-1] = args[i]
	end
	
	for i = 1, args[1] do  -- Create next dimension
		if #args == 1 then -- current is 1-dimension
			tensor[i] = 0  -- next is 0-current dimension (scalar)
		else
			tensor[i] = Tensor:Tensor(table.unpack(low)) -- next dimension
		end
	end
	
	setmetatable(tensor, Tensor.meta)
		
	return tensor
end

return Tensor