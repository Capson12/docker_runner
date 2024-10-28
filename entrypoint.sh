#!/usr/bin/expect

spawn ./config.sh --url {enter repo url} --token  {add repo token}

#expect "Enter a number:\r"
send -- "\r"
send -- "\r"
send -- "\r"
send -- "\r"


expect eof


