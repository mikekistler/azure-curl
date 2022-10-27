#!/bin/bash

# This script sets bash variables for values commonly used in Azure REST API calls.
# - token, subscriptionId, and resourceGroupName

find . -name 'token.json' -depth 1 -mtime -1h | grep . &> /dev/null || az account get-access-token > token.json
token=$(jq -r '.accessToken' token.json)

#subscriptionId=$(az account show --query 'id' -o tsv)
#resourceGroupName=$(az group list --query "[?location == 'centralus'] | [?contains(name,'Default')] | [0].name" -o tsv)

# Using the Azure SDK Developer Playground subscription
subscriptionId=$(az account list --query "[?name == 'Azure SDK Developer Playground'].id" -o tsv)
# az group create --name mkistler --location centralus --subscription $subscriptionId
resourceGroupName=mkistler
