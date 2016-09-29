#
# Ruby program to send WiFi-probe monitoring result on MQTT
#
# Usage:
# ruby wifipersoncounter-mqtt.rb <measurement interval (sec)> <log dir> <MQTT broker> <MQTT port> <MQTT topic>
# ruby wifipersoncounter-mqtt.rb 300 ./log test.mosquitto.org 1883 mqtt_topic
#
# Crontab: crontab -e
# */10 * * * * (cd <DIR> && <DIR-ruby>/ruby wifipersoncounter-mqtt.rb <INTERVAL> <DIR-log> <MQTT broker> <MQTT port> <MQTT topic>)
#
require './wifipersoncounter-lib.rb'
require 'mqtt'

#host = "test.mosquitto.org"
#port = 1883

interval = ARGV[0].to_f
dir = ARGV[1]
host = ARGV[2]
port = ARGV[3]
topic_base = ARGV[4]

result = calc_wifipersoncounter(dir, interval)
current = result[0]
coming = result[1]
left = result[2]

client = MQTT::Client.connect(host: host, port: port)
client.publish(topic_base+"current", current)
client.publish(topic_base+"coming", coming)
client.publish(topic_base+"left", left)
exit

