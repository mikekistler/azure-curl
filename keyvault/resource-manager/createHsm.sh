#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.KeyVault

tenantId=$(az account show --query 'tenantId' -o tsv)
adminId=$(az ad signed-in-user show --query 'id' -o tsv)

apiVersion=2022-07-01

name=mdk-test-hsm

# How to know what values for sku name ?  "Free" or "Standard"
body='{
  "location": "centralus",
  "properties": {
    "tenantId": "'${tenantId}'",
    "enableSoftDelete": true,
    "softDeleteRetentionInDays": 90,
    "enablePurgeProtection": true,
    "initialAdminObjectIds": ["'${adminId}'"]
  },
  "sku": {
    "family": "B",
    "name": "Standard_B1"
  },
  "tags": {
    "Dept": "hsm",
    "Environment": "dogfood"
  }
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   -d "${body}" \
   ${baseUrl}/managedHSMs/${name}?api-version=${apiVersion} \
   > createHsm.out

head -n 1 createHsm.out
tail -n 1 createHsm.out | jq '.'
