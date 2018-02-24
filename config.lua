local module = {}

f = file.open("config.json")
s = string.gsub(f.read(), "\n", "")
module = sjson.decode(s)
f.close()

module.chipid = node.chipid()
module.mqtt.inputChannel = module.mqtt.baseChannel .. module.chipid
module.mqtt.pingChannel = module.mqtt.baseChannel .. "ping"

return module
