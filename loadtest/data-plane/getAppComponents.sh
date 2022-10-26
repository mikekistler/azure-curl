#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

if [ ! -f listTests.out ]; then
    echo "Run listTests.sh first."
    exit 1
fi

#name=$(tail -1 listAppComponents.out | jq -r '.name')
#name="eac85b23-27a9-4279-b810-6dce9546f9bc"
name="new-app-components"

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
    -H "Authorization: Bearer ${token}" \
    "${endpoint}/appcomponents/${name}?api-version=${apiVersion}" \
    > getAppComponents.out

head -n 1 getAppComponents.out
tail -n 1 getAppComponents.out | jq '.'
