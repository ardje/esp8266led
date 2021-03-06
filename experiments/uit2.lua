#!/usr/bin/lua
local p=require"posix"
local fv4=p.AF_INET
local fv6=p.AF_INET6
local fd = assert(p.socket(fv4, p.SOCK_DGRAM, 0))
assert(p.bind(fd, { family = fv4,addr="0.0.0.0" ,port=0 }))

local dest={ family=fv4,addr="192.168.0.178",port=5556}
local int={}

function softoff(n)
	for k= 100,0,-1 do
		local s=(string.char(n*k/100,n*k/100,n*k/100,n*k/100)):rep(300)
		assert(p.sendto(fd,s,dest))
		p.poll({},40)
	end
end
softoff(100)
