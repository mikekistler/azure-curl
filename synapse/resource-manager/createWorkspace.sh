#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Synapse

apiVersion=2021-06-01

workspaceName=mdk-test

# Looks like the fake accountURL is perfectly fine.
body='{
  "location": "centralus",
  "identity": {
    "type": "SystemAssigned"
  },
  "properties": {
    "defaultDataLakeStorage": {
      "accountUrl": "https://accountname.dfs.core.windows.net",
      "filesystem": "default"
    },
  }
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   -d "${body}" \
   ${baseUrl}/workspaces/${workspaceName}?api-version=${apiVersion} \
   > createWorkspace.out

head -n 1 createWorkspace.out
tail -n 1 createWorkspace.out | jq '.'
