local module = {}

local function pin(name)
  if name == 'sw1' then return 4
  elseif name == 'sw2' then return 2
  elseif name == 'ir1' then return 1
  else
    print("connector: not yet implemented")
  end
  return nil
end

local function value(command)
  if command == 'on' then return gpio.HIGH
  elseif command == 'off' then return gpio.LOW
  else
    print("command: not yet implemented")
  end
end

function module.command(command)
  local value = value(command)
  gpio.write(module.pin, value)
end

return function(name)
  module.name = name
  module.pin = pin(name)
  return module
end

