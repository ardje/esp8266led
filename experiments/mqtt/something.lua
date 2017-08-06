local M={}
local mqttc=require"luamqttc.client"

local aclient=mqttc.new("director")
assert(aclient:connect("192.168.0.9",1883))
assert(aclient:publish("/wemos01/lua","print[[poep]]",{qos=1}))
aclient:message_loop(10)
aclient:disconnect()

