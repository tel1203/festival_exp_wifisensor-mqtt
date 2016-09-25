require 'mqtt'

host = "test.mosquitto.org"
port = 1883
topic = "ytel"

MQTT::Client.connect(host: host
                     port: port,
                    ) do |client|
  client.publish(topic, "From Ruby!")
end

