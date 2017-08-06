local m={}
local config=require"config"
local cname=wifi.sta.getmac()
local sname="/esp/"..cname.."/lua"
local oname="/esp/"..cname.."/output"
local bname="/esp/"..cname.."/boot"
local client=mqtt.Client(cname,12)
m.client=client
local function node_output(str)
	return pcall(client.publish,client,oname,str,0,0)
end
local topicaction={}
m.topicaction=topicaction
topicaction[sname]=function(_,topic,data)
	if data then
		local f,r,e
		f,e=loadstring(data)
		if f==nil then
				node_output("string length: "..tostring(string.len(data)))
			pcall(node_output,e)
		else
			e,r=pcall(f)
			if r ~= nil then
				pcall(node_output,r)
			end
		end
	end
end
client:on("message",function(c,t,d)
	if topicaction[t] ~= nil then
		return topicaction[t](c,t,d)
	else
		node_output("unknown topic: " .. t)
	end
end)
client:on("connect",function(c)
	c:subscribe(sname,1)
	pcall(client.publish,client,bname,"boot()",0,0)
	pcall(client.lwt,client,bname,"offline()",0,0)
end)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function()
	client:connect(config.mqtthost,1883,0,1)
end)
wifi.sta.eventMonStart()
MQTT=m

