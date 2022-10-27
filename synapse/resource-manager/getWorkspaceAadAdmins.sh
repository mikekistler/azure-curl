#!/bin/bash

source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.Synapse

apiVersion=2021-06-01

workspaceName=mdk-test

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/workspaces/${workspaceName}/administrators/activeDirectory?api-version=${apiVersion} \
   > getWorkspaceAadAdmins.out

head -n 1 getWorkspaceAadAdmins.out
tail -n 1 getWorkspaceAadAdmins.out | jq '.'
