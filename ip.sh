#!/bin/bash
# IP - Tracker 
# Coded by ZeroByte.id 
# Get api ? https://tools.keycdn.com/

getip() {
	wget -q "https://tools.keycdn.com/geo.json?host=$ip" -O track.tmp
	isp=$(cat track.tmp | grep -Po '(?<="isp":")[^",]*')
	ip=$(cat track.tmp | grep -Po '(?<="ip":")[^",]*')
	country=$(cat track.tmp | grep -Po '(?<="country_name":")[^",]*')
	city=$(cat track.tmp | grep -Po '(?<="city":")[^",]*')
	lat=$(cat track.tmp | grep -Po '(?<="latitude":")[^",]*')
	long=$(cat track.tmp | grep -Po '(?<="longitude":")[^",]*')
}
result() {
	echo " ISP         : " $isp;
	echo " IP          : " $ip;
	echo " Country     : " $country;
	echo " City        : " $city;
	echo " Latitude    : " $lat;
	echo " Longitude   : " $long;
	maps=" https://www.google.co.id/maps/search/$lat,+$long"
	echo " GOOGLE MAPS : " $maps
}

cat << "banner"
#######################################################
#  ___ ____     _____ ____            _  __    ____   #
# |_ _|  _ \   |_   _|  _ \ __ _  ___| |/ /___|  _ \  #
#  | || |_) |____| | | |_) / _` |/ __| ' // _ \ |_) | #
#  | ||  __/_____| | |  _ < (_| | (__| . \  __/  _ <  # 
# |___|_|        |_| |_| \_\__,_|\___|_|\_\___|_| \_\ #
#                                         ZeroByte.id #
#######################################################
banner
echo -n "  MASUKAN IP ADDRESS : "; read ip;
cek=$(curl -s "https://tools.keycdn.com/geo.json?host=$ip");
if [[ $cek =~ '"status":"error"' ]]; then
	echo " MOHON MASUKAN IP ADDRESS";
	exit
elif [[ $cek =~ '400 Bad' ]]; then
	echo " MOHON MASUKAN IP ADDRESS";
	exit
else
	getip
	result
fi
rm track.tmp
