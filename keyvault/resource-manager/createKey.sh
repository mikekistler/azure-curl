#!/bin/bash

source ./init.sh

vaultBaseUrl=https://management.azure.com$(tail -1 createVault.out | jq -r '.id')

apiVersion=2022-07-01

key_name=mdk-test-key

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   --data '{"properties":{"kty": "RSA"}}' \
   ${vaultBaseUrl}/keys/${key_name}?api-version=${apiVersion} \
   > createKey.out

head -n 1 createKey.out
tail -n 1 createKey.out | jq '.'
