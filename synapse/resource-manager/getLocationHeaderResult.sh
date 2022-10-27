#!/bin/bash

source ./init.sh

if [ -z "$1" ]; then
    echo "Usage: getLocationHeaderResult.sh <output file of LRO operation>"
    exit 1
fi

# Check if output file exists, If not, then issue a message and exit
if [ ! -f $1 ]; then
    echo "Out file $1 does not exist. Please create $1 first."
    exit 1
fi

location=$(awk '/location:/{print $2}' $1 | tr -d '\r')

curl -s -D - -X GET \
  -H "Authorization: Bearer ${token}" \
  "${location}" \
   > getLocationHeaderResult.out

head -n 1 getLocationHeaderResult.out
tail -n 1 getLocationHeaderResult.out | jq '.'
