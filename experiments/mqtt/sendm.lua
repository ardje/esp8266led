#!/usr/bin/lua5.3
local M={}
local mqttc=require"luamqttc.client"

local aclient=mqttc.new("instructor")
assert(aclient:connect("192.168.0.9",1883))
for i = 2,#arg do
	print(arg[1],arg[i])
	assert(aclient:publish(arg[i],arg[1],{qos=1}))
end
aclient:disconnect()

