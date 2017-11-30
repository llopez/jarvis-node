config = require "config"
wifi_setup = require "wifi_setup"
device = require "device"
queue = require "queue"
gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.LOW)
wifi_setup.start()
