#! /usr/bin/ruby

printf("Content-Type: text/html\n\n")

printf("Raspberry Pi Shutdown")

sleep(3)
system("shutdown -h now")

