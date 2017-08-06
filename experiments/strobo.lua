#!/usr/bin/lua
local p=require"posix"
local fv4=p.AF_INET
local fv6=p.AF_INET6
local fd = assert(p.socket(fv4, p.SOCK_DGRAM, 0))
assert(p.bind(fd, { family = fv4,addr="0.0.0.0" ,port=0 }))

local dest={ family=fv4,addr="192.168.0.152",port=5556}
local int={}

function flash(t)
	local s
	local k=100
	local n=100
	s=(string.char(2*n*k/100,1.5*n*k/100,n*k/100)):rep(144)
	assert(p.sendto(fd,s,dest))
	p.poll({},t)
	k=0
	s=(string.char(2*n*k/100,1.5*n*k/100,n*k/100)):rep(144)
	assert(p.sendto(fd,s,dest))
end
function strobo(t,i)
	while true do
		flash(t)
		p.poll({},i)
	end
end
strobo(tonumber(arg[1] or "5"),tonumber(arg[2]or"250"))
