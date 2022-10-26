#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

testId=$1
if [ -z "$testId" -a -f listTests.out ]; then
    testId=$(tail -1 listTests.out | jq -r '.value[0].testId')
fi

if [ -z "$testId" ]; then
    echo "No testId found.  Run listTestFiles.sh first."
    exit 1
fi

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${endpoint}/loadtests/${testId}/files?api-version=${apiVersion} \
   > listTestFiles.out

head -n 1 listTestFiles.out
tail -n 1 listTestFiles.out | jq '.'
