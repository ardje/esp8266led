function same(gpio,rep,colors)
  local strings=colors:rep(rep)
  ws2812.write(gpio,strings)
end
=node.heap()
int={}
function wheel(g)
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
for i=1,1000 do
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
int[k]=string.char(k-1,k-1,k-1):rep(50) end
for k=1,50 do ws2812.write(1,int[k]) tmr.delay(10000) tmr.wdclr()  end
print(node.heap())
tmr.wdclr()
for k=100,0,-1 do ws2812.write(1,(string.char(k,k,k)):rep(51)) tmr.wdclr() end
end


