#!/bin/bash

source ./init.sh

if [ -z "$1" ]; then
    echo "Usage: getAzureAsyncHeaderResult.sh <output file of LRO operation>"
    exit 1
fi

# Check if getAccount.out exists, If not, then issue a message and exit
if [ ! -f $1 ]; then
    echo "Out file $1 does not exist. Please create $1 first."
    exit 1
fi

asyncOperation=$(awk '/azure-asyncoperation:/{print $2}' $1 | tr -d '\r')

curl -s -D - -X GET \
  -H "Authorization: Bearer ${token}" \
  "${asyncOperation}" \
   > getAzureAsyncHeaderResult.out

head -n 1 getAzureAsyncHeaderResult.out
tail -n 1 getAzureAsyncHeaderResult.out | jq '.'
