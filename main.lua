config = require "config"
wifi_setup = require "wifi_setup"
connector = require "connector"
queue = require "queue"
telnet_server = require("telnet_srv")

gpio.mode(4, gpio.OUTPUT)
gpio.write(4, gpio.LOW)
wifi_setup.start()
