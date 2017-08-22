ws2812.init()
local frame = ws2812.newBuffer(300, 4)
local timer=tmr.create()
local function wheel(g,n)
	n=n or 100
	if g<85 then
		return (255-g*3)*n/100, 0,(g*3)*n/100,0
	elseif g<170 then
		g=g-85
		return 0,(g*3)*n/100,(255-g*3)*n/100,0
	else
		g=g-170
		return (g*3)*n/100,(255-g*3)*n/100,0,0
	end
end
local s=300
for j=1,s do
 frame:set(j,wheel(j*255.0/s,10))
end
timer:alarm(30,tmr.ALARM_AUTO,function()
	frame:shift(1,ws2812.SHIFT_CIRCULAR)
	ws2812.write(frame)
end)
