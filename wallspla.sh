#!/bin/bash
set -euo pipefail

#Unsplash API access key: https://unsplash.com/oauth/applications
ACCESS_KEY=""

#Comma separated collection ids: https://unsplash.com/collections
COLLECTIONS=""

#Name of the jpg file to use
WALLPAPER_LOCATION=~/Images/wallpaper.jpg

#Name of the info (txt) file
INFO_LOCATION=~/Images/wallpaper.txt

#Get new random info
photo=$(curl -sf -H "Accept-Version: v1" -H "Authorization: Client-ID ${ACCESS_KEY}" "https://api.unsplash.com/photos/random?featured&orientation=landscape&collections=${COLLECTIONS}&random=${RANDOM}")
photo_url=$(echo ${photo} | jq -r ".urls.full")
photo_location=$(echo ${photo} | jq -r ".location.title")
photo_username=$(echo ${photo} | jq -r ".user.name")

#Download it
curl -Lsf -o ${WALLPAPER_LOCATION} ${photo_url}

#Set as wallpaper
nitrogen --save --set-zoom ${WALLPAPER_LOCATION}

#Put wallpaper info into text file (eg for Conky)
echo "Taken in ${photo_location} by ${photo_username}" > ${INFO_LOCATION}

# vim:set ts=2 sw=2 et:
