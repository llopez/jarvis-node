local module = {}

local client = nil

local function parse(data)
  return sjson.decode(data)
end

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
    msg.connectors = config.connectors
    local json = sjson.encode(msg)
    client:publish(config.mqtt.pingChannel, json, 0, 0)
  end
end

function module.start()
  client = mqtt.Client(config.chipid, 120)

  client:on("message", function(conn, topic, data)
    local msg = parse(data)
    connector(msg.connector).command(msg.command)
  end)

  client:connect(config.mqtt.host, config.mqtt.port, 0, 0, function(con) 
    subscribeDevice()
    
    tmr.stop(6)
    tmr.alarm(6, 5000, 1, sendPing)
  end, handleError) 
end

function module.stop()
  client:close()
end

return module
