#!/bin/bash
./sendm.lua 'do ws2812.init() local B=ws2812.newBuffer(300,4) for i=1,300,'$2' do B:set(i,'$1') end ws2812.write(B) end' /esp/a0:20:a6:04:{05:1f,03:b7,03:76,01:c8,02:d2}/lua
