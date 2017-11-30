local module = {}

local client = nil

local function handleError(client, reason)
  print("failed reason: " .. reason)
end

local function subscribeDevice()  
  client:subscribe(config.mqtt.inputChannel, 0, function(conn)
    print("Successfully subscribed to data endpoint")
  end)
end

local function sendPing()
  if wifi.sta.getip() then
    local msg = {}
    msg.chipid = config.chipid
    msg.ip = wifi.sta.getip()
    local json = sjson.encode(msg)
    client:publish(config.mqtt.pingChannel, json, 0, 0)
  end
end

local function registerDevice()
  print("Register...")
  local msg = {}
  msg.chipid = config.chipid
  msg.ip = wifi.sta.getip()
  msg.type = config.deviceType
  local json = sjson.encode(msg)
  client:publish(config.mqtt.regChannel, json, 0, 0)
end

function module.start()
  client = mqtt.Client(config.chipid, 120)

  client:on("message", function(conn, topic, data) 
    device.process(data)
  end)

  client:connect(config.mqtt.host, config.mqtt.port, 0, 0, function(con) 
    subscribeDevice()
    registerDevice()
    
    tmr.stop(6)
    tmr.alarm(6, 5000, 1, sendPing)
  end, handleError) 
end

function module.stop()
  client:close()
end

function module.publish(message)
  message.chipid = config.chipid
  local json = sjson.encode(message)
  client:publish(config.mqtt.feedbackChannel, json, 0, 0)
end

return module
