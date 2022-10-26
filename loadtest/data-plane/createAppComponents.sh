#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

if [ ! -f listTests.out ]; then
    echo "No testId found.  Run listTests.sh first."
    exit 1
fi

resourceId=$(tail -1 listTests.out | jq -r '.value[0].resourceId')
testId=$(tail -1 listTests.out | jq -r '.value[0].testId')

name="new-app-components"

body='{
  "resourceId": "'${resourceId}'",
  "testId": "'${testId}'",
  "value": {}
}
'
# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PATCH \
    -H "Authorization: Bearer ${token}" \
    -H "Content-Type: application/merge-patch+json" \
    -d "${body}" \
    "${endpoint}/appcomponents/${name}?api-version=${apiVersion}" \
    > createAppComponents.out

head -n 1 createAppComponents.out
tail -n 1 createAppComponents.out | jq '.'
