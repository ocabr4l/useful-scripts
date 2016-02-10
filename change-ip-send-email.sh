#/bin/sh

IPADDRESS=$(dig +short myip.opendns.com @resolver1.opendns.com)
OLDIP=$(cat /home/pi/.current_ip)
if [ $IPADDRESS != $OLDIP ]
then
echo Your new IP address is $IPADDRESS, your old IP was $OLDIP |
mail -s "IP address change" youremail@domain.com
echo $IPADDRESS > /home/pi/.current_ip
fi


