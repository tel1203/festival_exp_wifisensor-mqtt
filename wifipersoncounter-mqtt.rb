#
# Ruby program to send WiFi-probe monitoring result on MQTT
#
# Usage:
# ruby wifipersoncounter-mqtt.rb <measurement interval (sec)> <log dir> <MQTT broker> <MQTT port> <MQTT topic>
# ruby wifipersoncounter-mqtt.rb 300 ./log test.mosquitto.org 1883 mqtt_topic
#

require 'mqtt'

#host = "test.mosquitto.org"
#port = 1883

interval = ARGV[0].to_f
dir = ARGV[1]
host = ARGV[2]
port = ARGV[3]
topic_base = ARGV[4]

time_now = Time.now.to_f

files = Dir::entries(dir)
files_sort = files.sort

file1 = files_sort[-1]
file2 = files_sort[-2]

ids = []
ids_last = []
[file1, file2].each do |file|
  f = open(dir + "/" + file, "r")
  while ((line = f.gets) != nil) do
    tmp = line.split(",")
    if (tmp[0].to_f > time_now-(interval*2) and 
        tmp[0].to_f < time_now-(interval)) then
      begin
        ids_last |= [tmp[1]]
      rescue
      end
    end

    if (tmp[0].to_f > time_now-(interval)) then 
      ids |= [tmp[1]]
    end
  end
end

current = ids.size
coming  = (ids-ids_last).size
left    = (ids_last-ids).size

client = MQTT::Client.connect(host: host, port: port)
client.publish(topic_base+"current", current)
client.publish(topic_base+"coming", coming)
client.publish(topic_base+"left", left)
exit

