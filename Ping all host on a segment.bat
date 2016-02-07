@echo off
set /a n=0
:repeat
set /a n+=1
echo 10.21.4.%n%
ping -n 1 -w 500 10.21.4.%n% | FIND /i "Reply">>ipaddresses.txt
if %n% lss 254 goto repeat
type ipaddresses.txt