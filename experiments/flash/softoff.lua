ws2812.init()
local timer=tmr.create()
local softon=coroutine.wrap(function()
	local buffer=ws2812.newBuffer(600,4)
	for i=100,0,-1 do
		buffer:fill(0,0,0,i)
		coroutine.yield()
		ws2812.write(buffer)
	end
	timer:stop()
	timer:unregister()
end)
timer:alarm(100,tmr.ALARM_AUTO,softon)
