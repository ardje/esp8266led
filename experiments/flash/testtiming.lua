ws2812.init()
local timer=tmr.create()
local softon=coroutine.wrap(function()
	local off=ws2812.newBuffer(600,4)
	local on=ws2812.newBuffer(600,4)
	off:fill(0,0,0,0)
	on:fill(0,0,0,255)
	for i=1,300 do
		coroutine.yield()
		ws2812.write(off)
		coroutine.yield()
		ws2812.write(off)
	end
	for i=1,300 do
		coroutine.yield()
		ws2812.write(on)
		coroutine.yield()
		ws2812.write(on)
	end
	for i=1,100 do
		coroutine.yield()
		ws2812.write(on)
		coroutine.yield()
		ws2812.write(off)
	end
	timer:stop()
	timer:unregister()
end)
timer:alarm(28,tmr.ALARM_AUTO,softon)
