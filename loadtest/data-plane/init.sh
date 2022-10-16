#!/bin/bash

# This script sets bash variables for values commonly used in Azure REST API calls.
# - endpoint, token

subid=$(az account list --query "[?name == 'Azure SDK Developer Playground'].id" -o tsv)
endpoint=https://$(az resource show --subscription $subid --resource-group mkistler --resource-type "Microsoft.LoadTestService/loadtests" --name "mdk-test"  --query "properties.dataPlaneURI" -o tsv)

# Add a role assignnment for the current user to the loadtest service with the "owner" role
scope=https://cnt-prod.loadtesting.azure.com/.default
find . -name 'token.json' -depth 1 -mtime -1h | grep . &> /dev/null || az account get-access-token --scope $scope > token.json
token=$(jq -r '.accessToken' token.json)

