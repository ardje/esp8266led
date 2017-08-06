ws2812.init()
local timer=tmr.create()
local softon=coroutine.wrap(function()
	local buffer=ws2812.newBuffer(600,4)
	buffer:fill(0,0,0,0)
	local color={0,0,0,2}
	local n=4
	for i=1,600 do
		for j=0,n-1 do
			if i+j <= 600 then
				buffer:set(i+j,0,0,0,(150*(n-j))/n)
			end
		end
		coroutine.yield()
		ws2812.write(buffer)
	end
	timer:stop()
	timer:unregister()
end)
timer:alarm(40,tmr.ALARM_AUTO,softon)
