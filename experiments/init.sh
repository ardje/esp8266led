#!/bin/bash
init2() {
ip="$1"
echo 'if ls==nil then ls=net.createServer(net.UDP) ls:on("receive",function(srv,data) ws2812.write(2,data) ws2812.write(1,data) end) ls:listen(5556) else print "already active\n" end con_std:close()'|nc $ip 2323 2>&1
}
init() {
ip="$1"
echo 'if ls==nil then ws2812.init() ls=net.createServer(net.UDP) ls:on("receive",function(srv,data) ws2812.write(1,data) end) ls:listen(5556) else print "already active\n" end con_std:close()'|nc $ip 2323 2>&1
}

init2 192.168.0.152
#init 192.168.0.178
