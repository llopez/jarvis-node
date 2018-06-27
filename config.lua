local module = {}

f = file.open("config.json")
s = string.gsub(f.read(), "\n", "")
module = sjson.decode(s)
f.close()

module.chipid = node.chipid()

return module
