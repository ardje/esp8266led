#!/usr/bin/lua
local p=require"posix"
local fv4=p.AF_INET
local fv6=p.AF_INET6
local fd = assert(p.socket(fv4, p.SOCK_DGRAM, 0))
assert(p.bind(fd, { family = fv4,addr="0.0.0.0" ,port=0 }))

local dest={ family=fv4,addr="192.168.0.152",port=5555}

assert(p.sendto(fd,
[[l=net.createServer(net.UDP) l:on("receive",function(srv,data) ws2812.writergb(1,data) end) l:listen(5556)]]
,dest))

