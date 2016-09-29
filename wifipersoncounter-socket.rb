#
# Ruby program to send WiFi-probe monitoring result on TCP/IP socket
#
# Usage:
# ruby wifipersoncounter-socket.rb <measurement interval (sec)> <log dir> <server> <port>
# ruby wifipersoncounter-socket.rb wifisensor 300 ./log test.test.org 8883
#
# Crontab: crontab -e
# */10 * * * * (cd <DIR> && <DIR-ruby>/ruby wifipersoncounter-socket.rb <MYNAME> <INTERVAL> <DIR-log> <server> <port>)
#
require './wifipersoncounter-lib.rb'
require 'socket'

myname = ARGV[0]
interval = ARGV[1].to_f
dir = ARGV[2]
host = ARGV[3]
port = ARGV[4]

result = calc_wifipersoncounter(dir, interval)
current = result[0]
coming = result[1]
left = result[2]

p result

# name, unixtime, Year, Month, Day, Hour, Minutes, Seconds, Current, Coming, Left
port=TCPSocket.open(host, port)

timenow = Time.now 
message = sprintf("%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
  myname, timenow.to_i, timenow.year, timenow.month, timenow.day, timenow.hour, timenow.min, timenow.sec,
  result[0], result[1], result[2])
puts(message)
port.puts(message)

