local module = {}

local function search(items, name)
  for _,v in pairs(items) do
    if v.name == name then
      return v
    end
  end
end

local function value(command)
  if command == 'on' then return gpio.HIGH
  elseif command == 'off' then return gpio.LOW
  end
  print("command: not yet implemented")
  return nil
end

function module.command(command)
  local value = value(command)

  if module.connector.type == 'switch' then
    gpio.write(module.connector.pin, value)
  elseif module.connector.type == 'ir' then
    irsend.nec(tonumber(module.connector.pin), tonumber(command), 28)
  elseif module.connector.type == 'dimm' then
  end
end

return function(name)
  module.name = name
  module.connector = search(config.connectors, name)
  return module
end

