print"begin"
do
int={}
function wheel(g,n)
	if g<85 then
		return 255-g*3, 0,g*3
	elseif g<170 then
		g=g-85
		return 0,g*3,255-g*3
	else
		g=g-170
		return g*3,255-g*3,0
	end
end
for k=1,50 do
	local s=''
	for j=k,50 do
	 s=s..string.char(wheel(j*255/50))
        end
	for j=1,k do
	 s=s..string.char(wheel(j*255/50))
        end
	int[k]=s
	print(node.heap)
	tmr.wdclr()
end
function spin(n)
	for j=1,n do
		for k=1,50 do ws2812.write(1,int[k]) tmr.delay(10000) tmr.wdclr()  end
	end
end
function softoff()
	for k=100,0,-1 do ws2812.write(1,(string.char(k,k,k)):rep(51)) tmr.wdclr() end
end
function softon(n)
	for k=0,n or 100 do ws2812.write(1,(string.char(k,k,k)):rep(51)) tmr.wdclr() end
end
end
print"end"
