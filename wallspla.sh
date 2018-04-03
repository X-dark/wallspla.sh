#!/bin/bash
set -euo pipefail

#Unsplash API access key: https://unsplash.com/oauth/applications
ACCESS_KEY=""

#Comma separated collection ids: https://unsplash.com/collections
COLLECTIONS=""

#Get new random info
photo=$(curl -sf -H "Accept-Version: v1" -H "Authorization: Client-ID ${ACCESS_KEY}" "https://api.unsplash.com/photos/random?featured&orientation=landscape&collections=${COLLECTIONS}&random=${RANDOM}")
photo_url=$(echo ${photo} | jq -r ".urls.full")
photo_location=$(echo ${photo} | jq -r ".location.title")
photo_username=$(echo ${photo} | jq -r ".user.name")

#Download it
curl -Lsf -o ~/Images/wallpaper.jpg ${photo_url}

#Set as wallpaper
nitrogen --save --set-zoom ~/Images/wallpaper.jpg

#Put wallpaper info into text file (eg for Conky)
echo "Taken in ${photo_location} by ${photo_username}" > ~/Images/wallpaper.txt

# vim:set ts=2 sw=2 et:
