#!/usr/bin/lua5.3

local encoder=require"encoder"
local config=require"config"
local target=table.remove(arg,1)

local mqttc=require"luamqttc.client"
local aclient=mqttc.new("upload")

local function send(id,data)
	local queue="/esp/"..id.."/lua"
	io.write(("---- SENDING\nSend(%s,%s)\n"):format(queue,data))
	print(pcall(aclient.publish,aclient,queue,data))
end

local function upload(id,fn)
	local qfn=string.format("%q",fn)
	local fopen=string.format([[F=file.open(%s,"w") return F ~= nil and "open" or "error"]],qfn)
	send(id,fopen)
	coroutine.yield()
	for l in encoder.lines(fn) do
		local fwrite=string.format([[F:write(%s) return "wrote"]],l)
		send(id,fwrite)
		coroutine.yield()
	end
	local fclose=[[F:close() return "closed"]]
	send(id,fclose)
	coroutine.yield()
end
local uploader=coroutine.wrap(function ()
	for _,fn in ipairs(arg) do
		upload(target,fn)
	end
	aclient.transport:close()
end)

local queue={}
local function generic_cb(topic,data,packet_id,dup,qos,retained)
	local q=topic:match"/esp/[^/]+/([^/]+)"
	print("--------- GENERIC CB")
	print("topic:",topic)
	print("q:",q)
	print("data:",data)
	print("packet_id",packet_id)
	print("dup",dup)
	print("qos",qos)
	print("retained",retained)
	if queue[q] then
		return queue[q](topic,data,packet_id,dup,qos,retained)
	else
		print("Ignored Q:",q)
	end
end
--function queue.output(topic,data,packet_id,dup,qos,retained)
function queue.output()
	print("yielding uploader")
	uploader()
end

assert(aclient:connect(config.mqtthost,1883))
assert(aclient:subscribe("/esp/+/+",1,generic_cb))
--send("a0:20:a6:04:01:c8","node.restart()")
uploader()
aclient:message_loop()

