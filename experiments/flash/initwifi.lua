wifi.setmode(wifi.STATION)
local config=require"config"
if wifi.sta.eventMonStart then
	wifi.sta.eventMonStart()
end
if config.wifi then
	wifi.sta.config(config.wifi)
else
	wifi.sta.config(config.wifiap,config.wifipass)
end
