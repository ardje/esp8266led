wifi.setmode(wifi.STATION)
local config=require"config"
wifi.sta.config(config.wifiap,config.wifipass)
