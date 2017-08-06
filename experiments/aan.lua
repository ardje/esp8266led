#!/usr/bin/lua
local p=require"posix"
local fv4=p.AF_INET
local fv6=p.AF_INET6
local fd = assert(p.socket(fv4, p.SOCK_DGRAM, 0))
assert(p.bind(fd, { family = fv4,addr="0.0.0.0" ,port=0 }))

local dest={ family=fv4,addr="192.168.0.152",port=5556}
local int={}

local nleds=215
function softon(w,r,g,b)
	local iter=100
	if r == 0 and g == 0 and b == 0 then
		r=w
		g=w
		b=w
	end
	for k= 0,100 do
		local s=(string.char(r*k/iter,g*k/iter,b*k/iter)):rep(nleds)
		assert(p.sendto(fd,s,dest))
		p.poll({},10)
	end
end
softon(tonumber(arg[1] or "100"),tonumber(arg[2] or "0"),tonumber(arg[3] or "0"),tonumber(arg[4] or "0"))

