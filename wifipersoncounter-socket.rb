#
# Ruby program to send WiFi-probe monitoring result on TCP/IP socket
#
# Usage:
# ruby wifipersoncounter-socket.rb <measurement interval (sec)> <log dir> <server> <port>
# ruby wifipersoncounter-socket.rb 300 ./log test.test.org 8883
#
# Crontab: crontab -e
# */10 * * * * (cd <DIR> && <DIR-ruby>/ruby wifipersoncounter-socket.rb <INTERVAL> <DIR-log> <server> <port>)
#
require './wifipersoncounter-lib.rb'

interval = ARGV[0].to_f
dir = ARGV[1]
host = ARGV[2]
port = ARGV[3]

result = calc_wifipersoncounter(dir, interval)
current = result[0]
coming = result[1]
left = result[2]

p result

# name, unixtime, Year, Month, Day, Hour, Minutes, Seconds, Current, Coming, Left

