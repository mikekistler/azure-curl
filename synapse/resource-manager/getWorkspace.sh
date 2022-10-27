#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Synapse

apiVersion=2021-06-01

workspaceName=mdk-test

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/workspaces/${workspaceName}?api-version=${apiVersion} \
   > getWorkspace.out

head -n 1 getWorkspace.out
tail -n 1 getWorkspace.out | jq '.'
