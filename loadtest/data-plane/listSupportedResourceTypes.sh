#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
    -H "Authorization: Bearer ${token}" \
    "${endpoint}/serverMetricsConfig/supportedResourceTypes?api-version=${apiVersion}" \
    > listSupportedResourceTypes.out

head -n 1 listSupportedResourceTypes.out
tail -n 1 listSupportedResourceTypes.out | jq '.'
