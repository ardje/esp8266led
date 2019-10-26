#!/bin/bash
N=(255,0,0,0 0,255,0,0 0,0,255,0 0,0,0,255 128,128,0,0 0,128,128,0 128,0,128,0 64,64,64,64 128,0,0,128 0,128,0,128 0,0,128,128)
echo ${#N[*]}
NR=${#N[*]}
selectcolor() {
	RI=$(od -An -N1 -i < /dev/urandom)
	Q=$((${NR}*${RI}/256))
	echo ${N[$Q]}
}
OC=""
C=$(selectcolor)
while true;do
until [ "$C" != "$OC" ]; do
C=$(selectcolor)
done
OC="$C"
./sendm.lua 'do ws2812.init() local B=ws2812.newBuffer(300,4) B:fill('$C') ws2812.write(B) end' /esp/a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2,02:e6}/lua
sleep .1
./sendm.lua 'do ws2812.init() local B=ws2812.newBuffer(300,4) B:fill(0,0,0,0) ws2812.write(B) end' /esp/a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2,02:e6}/lua
sleep .3
done
#while true;do for j in 255;do for i in "$j,0,0,0" "0,$j,0,0" "0,0,$j,0" "0,0,0,$j";do ./sendm.lua 'do ws2812.init() local B=ws2812.newBuffer(300,4) B:fill('$i') ws2812.write(B) end' /esp/a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2}/lua  ;sleep 0.4;done;done;done
