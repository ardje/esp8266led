ws2812.init()
local frame = ws2812.newBuffer(300, 4)
local function chaser(speed,color)
	local timer=tmr.create()
	timer:alarm(speed,tmr.ALARM_AUTO,coroutine.wrap(function()
		while true do
			for i=1,300 do
				frame:set(i, color)
				coroutine.yield()
			end
			for i=300,1,-1 do
				frame:set(i, color)
				coroutine.yield()
			end
		end
	end))
	return buffer
end
local timer=tmr.create()
chaser(30,{255,0,0,0})
chaser(25,{0,255,0,0})
chaser(20,{0,0,255,0})
chaser(100,{0,0,0,255})
timer:alarm(50,tmr.ALARM_AUTO,function()
	frame:fade(2)
	ws2812.write(frame)
end)
