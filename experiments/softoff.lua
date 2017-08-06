function softoff(n) for k=n or 50,0,-1 do ws2812.write(1,(string.char(k,k,k)):rep(144)) tmr.wdclr() end end
