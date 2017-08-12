#!/usr/bin/lua5.3
local mqttc=require"luamqttc.client"
local aclient=mqttc.new("director")
local Esp=require"esp"
Esp._aclient=aclient
local function send(id,data)
	local queue="/esp/"..id.."/lua"
	io.write(("---- SENDING\nSend(%s,%s)\n"):format(queue,data))
	print(pcall(aclient.publish,aclient,queue,data))
end
local function generic_cb(topic,data,packet_id,dup,qos,retained)
	print("--------- GENERIC CB")
	print("topic:",topic)
	print("data:",data)
	print("packet_id",packet_id)
	print("dup",dup)
	print("qos",qos)
	print("retained",retained)
end

local function boot_cb(topic,data,packet_id,dup,qos,retained)
	print("---------- BOOT CB")
	print("topic:",topic)
	local esp=Esp:fromtopic(topic)
	print("esp:",esp)
	local commands={
		boot=function(...)
			print("esp:",esp)
			esp:boot(...)
		end,
		upload=function(...)
			esp:upload(...)
		end,
		continue=function(...)
			esp:continue(...)
		end,
		done=function(...)
			esp:done(...)
		end,
	}
	local f=load(data,nil,"t",commands)
	print("data:",data)
	print("packet_id",packet_id)
	print("dup",dup)
	print("qos",qos)
	print("retained",retained)
	print(pcall(f))
end
assert(aclient:connect("151.216.22.121",1883))
assert(aclient:subscribe("/esp/+/boot",1,boot_cb))
assert(aclient:subscribe("/esp/+/+",1,generic_cb))
--send("a0:20:a6:04:01:c8","node.restart()")
aclient:message_loop()

