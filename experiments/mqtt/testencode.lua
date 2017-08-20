#!/usr/bin/lua5.3
local encoder=require"encoder"

for l in encoder.lines(arg[1]) do
	io.write(l,"\n")
end
