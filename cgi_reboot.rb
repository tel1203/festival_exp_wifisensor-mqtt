#! /usr/bin/ruby

printf("Content-Type: text/html\n\n")

printf("Raspberry Pi Reboot")

sleep(3)
system("shutdown -r now")

