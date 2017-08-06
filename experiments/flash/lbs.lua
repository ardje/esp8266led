ws2812.init()
local i, buffer = 0, ws2812.newBuffer(21, 3); buffer:fill(0, 0, 0); tmr.alarm(0, 20, 1, function()
        i=i+1
	if i >= 21 then i=-20 end
        buffer:fade(2)
	if i<0 then
		buffer:set((-i)%buffer:size()+1, 128,128,128)
	else
		buffer:set(i%buffer:size()+1, 128,128,128)
	end
        ws2812.write(buffer)
end)
