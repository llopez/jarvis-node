local module = {}

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
  print("STA GOT IP: "..wifi.sta.getip())

  queue.start()
end)

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, function(T)
  print("STA - CONNECTED")
end)

wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, function(T)
  print("STA - DISCONNECTED".."\nSSID: "..T.SSID.."\nBSSID: "..T.BSSID.."\nreason: "..T.reason)

  queue.stop()
  wifi.sta.connect()
end)

local function wifi_start()
  wifi.sta.config(config.sta)
  wifi.sta.connect()
  print("Connecting to " .. config.sta.ssid .. " ...")
end

function module.start()
  print("Configuring Wifi ...")

  wifi.setmode(wifi.STATION)
  wifi_start()
end

return module
