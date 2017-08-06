file.open("test.lua","w")
file.write[[
do ws2812.init() local B=ws2812.newBuffer(300,4) B:fill(0,0,0,100) ws2812.write(B) end
]]
file.close()
