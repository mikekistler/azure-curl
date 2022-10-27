#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Synapse

apiVersion=2021-06-01

workspaceName=mdk-test

login=$(az ad signed-in-user show --query "mail" -o tsv)
tenantId=$(az account show --query 'tenantId' -o tsv)
sid=$(az ad signed-in-user show --query "id" -o tsv)

body='{
  "properties": {
    "login": "'${login}'",
    "tenantId": "'${tenantId}'",
    "sid": "'${sid}'"
  }
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   -d "${body}" \
   ${baseUrl}/workspaces/${workspaceName}/administrators/activeDirectory?api-version=${apiVersion} \
   > createWorkspaceAadAdmins.out

head -n 1 createWorkspaceAadAdmins.out
tail -n 1 createWorkspaceAadAdmins.out | jq '.'
