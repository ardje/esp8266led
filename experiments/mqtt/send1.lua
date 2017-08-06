#!/usr/bin/lua5.3
local M={}
local mqttc=require"luamqttc.client"

local aclient=mqttc.new("director")
assert(aclient:connect("192.168.0.9",1883))
assert(aclient:publish("/wemos01/lua",arg[1],{qos=1}))
aclient:disconnect()

