local s=net.createServer(net.TCP)

local function newconnection(c)
	local f=file.open("newfile.tmp","w")
	c:on("receive",function(c,d)
		f:write(d)
	end)
	c:on("disconnection",function(c)
		f:close()
	end)
end
s:listen(2121,newconnection)
FileReceiver=s
