#!/bin/bash

source ./init.sh

location=$(awk '/location:/{print $2}' createHsm.out)

curl -vvv -s -D - -X GET \
  -H "Authorization: Bearer ${token}" \
  ${location} \
   > getCreateHsmStatus.out

head -n 1 getCreateHsmStatus.out
tail -n 1 getCreateHsmStatus.out | jq '.'
