#!/bin/bash

source ./init.sh

vaultBaseUrl=https://management.azure.com$(tail -1 createVault.out | jq -r '.id')

apiVersion=2022-07-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - --get \
   -H "Authorization: Bearer ${token}" \
   ${vaultBaseUrl}/secrets?api-version=${apiVersion} \
   > listSecrets.out

head -n 1 listSecrets.out
tail -n 1 listSecrets.out | jq '.'
