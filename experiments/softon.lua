function softon(n) for k=0,n or 100 do local s=(string.char(k,k,k)):rep(144) ws2812.write(1,s) ws2812.write(2,s) tmr.wdclr() end end
