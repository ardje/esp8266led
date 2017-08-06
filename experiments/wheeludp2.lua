#!/usr/bin/lua
local p=require"posix"
local fv4=p.AF_INET
local fv6=p.AF_INET6
local fd = assert(p.socket(fv4, p.SOCK_DGRAM, 0))
assert(p.bind(fd, { family = fv4,addr="0.0.0.0" ,port=0 }))

local dest={ family=fv4,addr="192.168.0.178",port=5556}
local int={}

function wheel(p,n,brightness)
	local r,g,b
	brightness = brightness or 1
	if p<85 then
		r=255-p*3 g=0 b=p*3
	elseif p<170 then
		p=p-85
		r= 0 g=p*3 b=255-p*3
	else
		p=p-170
		r= p*3 g= 255-p*3 b=0
	end
	--return r/2,g/2,b/2
	return r*brightness,g*brightness,b*brightness
end
for k=1,144 do
	local s=''
	for j=k,144 do
	 s=s..string.char(wheel(j*255/144,1,0.5,0))
        end
	for j=1,k do
	 s=s..string.char(wheel(j*255/144,1,0.5,0))
        end
	int[k]=s
end
function spin(n,t)
	for j=1,n do
		for k=1,144 do
			assert(p.sendto(fd,int[k],dest))
			p.poll({},t)
		--print("round",j,k)
		end
	end
end
spin(tonumber(arg[2] or "20000"),tonumber(arg[1] or "10"))
