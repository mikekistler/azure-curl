#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/providers/Microsoft.KeyVault

apiVersion=2022-07-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/managedHSMs?api-version=${apiVersion} \
   > listHsms.out

head -n 1 listHsms.out
tail -n 1 listHsms.out | jq '.'
