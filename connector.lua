local module = {}

function module.command(value)
  if module.type == 'switch' then
    gpio.write(module.number, tonumber(value))
  elseif module.type == 'ir' then
    irsend.nec(tonumber(module.number), tonumber(value), 28)
  elseif module.type == 'dimmer' then
  end
end

return function(msg)
  module.number = msg.pin
  module.type = msg.type
  return module
end

