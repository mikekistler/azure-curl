#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/providers/Microsoft.KeyVault

apiVersion=2022-07-01

body='{
  "name": "mdk-test",
  "type": "Microsoft.KeyVault/vaults"
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X POST \
   -H "Authorization: Bearer ${token}" \
   -H "Content-Type: application/json" \
   -d "${body}" \
   ${baseUrl}/checkNameAvailability?api-version=${apiVersion} \
   > checkNameAvailability.out

head -n 1 checkNameAvailability.out
tail -n 1 checkNameAvailability.out | jq '.'
