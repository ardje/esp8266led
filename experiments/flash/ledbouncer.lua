ws2812.init()
local i, buffer = 0, ws2812.newBuffer(300, 4); buffer:fill(0, 0, 0, 0); tmr.alarm(0, 20, 1, function()
        i=i+1
	if i >= 300 then i=-299 end
        buffer:fade(2)
	if i<0 then
		buffer:set((-i)%buffer:size()+1, 0, 0, 0, 255)
	else
		buffer:set(i%buffer:size()+1, 0, 0, 0, 255)
	end
        ws2812.write(buffer)
end)
