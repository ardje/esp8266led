ws2812.init()
local function chaser(speed,color)
	local  buffer = ws2812.newBuffer(300, 4)
	buffer:fill(0, 0, 0, 0)
	local timer=tmr.create()
	timer:alarm(speed,tmr.ALARM_AUTO,coroutine.wrap(function()
		for i=1,300 do
			buffer:fade(2)
			buffer:set(i, color)
			coroutine.yield()
			ws2812.write(buffer)
		end
		for i=300,1,-1 do
			buffer:fade(2)
			buffer:set(i, color)
			coroutine.yield()
			ws2812.write(buffer)
		end
		buffer:fill(0, 0, 0, 0)
		coroutine.yield()
		ws2812.write(buffer)
		timer:stop()
		timer:unregister()
		print("stopped chasing")
	end))
	return buffer
end
local white=chaser(20,{0,0,0,255})
