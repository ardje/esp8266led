local M={}
--[[
local function encode(filename,maxlength)
	print(filename, maxlength)
	local file=assert(io.open(filename,"r"))
	local block=""
	while true do
		if block:len()<maxlength then
			local data=file:read(maxlength-2)
			if (data == nil or data:len() == 0) and block:len()==0 then
				return nil
			end
			block=block..(data or "")
		end
		local t=string.format("%q",block)
		local n=t:len()-maxlength
		if n>0 then
			t=string.format("%q",block:sub(1,block:len()-n))
			block=block:sub(block:len()-n)
		else
			block=""
		end
		io.write(t,"\n")
	--	return 1
	end
end
]]
function M.lines(file,maxlength)
	maxlength=maxlength or 64
	if type(file) == "string" then
		file=assert(io.open(file,"r"))
	end
	return coroutine.wrap(function()
		local block=""
		while true do
			if block:len()<maxlength then
				local data=file:read(maxlength-2)
				if (data == nil or data:len() == 0) and block:len()==0 then
					file:close()
					return nil
				end
				block=block..(data or "")
			end
			local t=string.format("%q",block)
			local n=t:len()-maxlength
			if n>0 then
				t=string.format("%q",block:sub(1,block:len()-n))
				block=block:sub(block:len()-n+1)
			else
				block=""
			end
			coroutine.yield(t)
		end
	end)
end
return M
