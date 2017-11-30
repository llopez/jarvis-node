local module = {}

f = file.open("config.json")
module = sjson.decode(f.read())
f.close()

module.chipid = node.chipid()
module.mqtt.inputChannel = module.mqtt.baseChannel .. module.chipid
module.mqtt.feedbackChannel = module.mqtt.baseChannel .. "feedback"
module.mqtt.pingChannel = module.mqtt.baseChannel .. "ping"
module.mqtt.regChannel = module.mqtt.baseChannel .. "reg"

return module
