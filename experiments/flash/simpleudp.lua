ws2812.init()
if ls ~= nil then
	ls:close()
	ls=nil
end
local timer=tmr.create()
local frames={}
timer:register(20, tmr.ALARM_AUTO, function ()
	if #frames > 0 then
--		print("timer")
		ws2812.write(table.remove(frames,1))
	else
		timer:stop()
--		print "animator stopped"
	end
end)
-- print "frame animator registered"
ls=net.createServer(net.UDP)
ls:on("receive",function(srv,data)
	frames[#frames+1]=data
--	print("udp frames:",#frames)
	if #frames > 5 then table.remove(frames,1) end
	if (timer:state()) ~= true then
--		print "animator started"
		timer:start()
	end
end)
ls:listen(5556)
