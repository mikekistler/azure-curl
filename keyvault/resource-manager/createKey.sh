#!/bin/bash

source ./init.sh

# Check if createVault.out exists, If not, then issue a message and exit
if [ ! -f createVault.out ]; then
    echo "createVault.out does not exist. Please run createVault.sh first."
    exit 1
fi

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
