#!/usr/bin/lua5.3
local M={}
local mqttc=require"luamqttc.client"

local aclient=mqttc.new("instructor")
assert(aclient:connect("192.168.0.9",1883))
assert(aclient:publish(arg[1],arg[2],{qos=1}))
aclient:disconnect()

