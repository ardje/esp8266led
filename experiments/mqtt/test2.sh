while true;do for j in 255;do for i in "$j,0,0,0" "0,$j,0,0" "0,0,$j,0" "0,0,0,$j";do ./sendm.lua 'do ws2812.init() local B=ws2812.newBuffer(300,4) B:fill('$i') ws2812.write(B) end' /esp/a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2}/lua  ;sleep 0.4;done;done;done
