local module = {}

local function parse(data)
  return sjson.decode(data)
end

local function getState()
  if gpio.read(4) == gpio.HIGH then
    return "on"
  elseif gpio.read(4) == gpio.LOW then
    return "off"
  end 
end

local function process(message)
  if message.state == "on" then
    gpio.write(4, gpio.HIGH)
  elseif message.state == "off" then
    gpio.write(4, gpio.LOW)
  end
  
  local msg = {}
  if message.state == getState() then
    print("ok")
    msg.msg = message
    msg.status = 'success'
    queue.publish(msg)
  else
    print("error")
    msg.msg = message
    msg.status = 'error'
    queue.publish(msg)
  end
end

function module.process(data)
  local message = parse(data)
  process(message)
end

return module
