local arg=...
local config=require"config"
ws2812.init()
local timer=tmr.create()
local softon=coroutine.wrap(function()
	local buffer=ws2812.newBuffer(config.pixels or 300,config.ledpp or 4)
	for i=1,arg.brightness or 100 do
		buffer:fill(0,0,0,i)
		coroutine.yield()
		ws2812.write(buffer)
	end
	timer:stop()
	timer:unregister()
end)
timer:alarm(arg.interval or 100,tmr.ALARM_AUTO,softon)
