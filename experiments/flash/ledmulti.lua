ws2812.init()
local function chaser(speed,color)
	local  buffer = ws2812.newBuffer(300, 4)
	buffer:fill(0, 0, 0, 0)
	local timer=tmr.create()
	timer:alarm(speed,tmr.ALARM_AUTO,coroutine.wrap(function()
		while true do
			for i=1,300 do
				buffer:fade(2)
				buffer:set(i, color)
				coroutine.yield()
			end
			for i=300,1,-1 do
				buffer:fade(2)
				buffer:set(i, color)
				coroutine.yield()
			end
		end
	end))
	return buffer
end
local timer=tmr.create()
local frame = ws2812.newBuffer(300, 4)
local red=chaser(30,{255,0,0,0})
local green=chaser(25,{0,255,0,0})
local blue=chaser(18,{0,0,255,0})
local white=chaser(100,{0,0,0,255})
timer:alarm(50,tmr.ALARM_AUTO,function()
	frame:mix(256,red,256,green,256,blue,256,white)
	ws2812.write(frame)
end)
