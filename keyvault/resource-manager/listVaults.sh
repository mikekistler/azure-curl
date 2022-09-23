#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}

apiVersion=2022-09-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - --get \
   -H "Authorization: Bearer ${token}" \
   --data-urlencode "\$filter=resourceType eq 'Microsoft.KeyVault/vaults'" \
   --data-urlencode "api-version=${apiVersion}" \
   ${baseUrl}/resources \
   > listVaults.out

head -n 1 listVaults.out
tail -n 1 listVaults.out | jq '.'
