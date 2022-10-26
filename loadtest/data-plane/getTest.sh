#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

if [ ! -f listTests.out ]; then
    echo "Run listTests.sh first."
    exit 1
fi

testId=$(tail -1 listTests.out | jq -r '.value[0].testId')

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
    -H "Authorization: Bearer ${token}" \
    "${endpoint}/loadtests/${testId}?api-version=${apiVersion}" \
    > getTest.out

head -n 1 getTest.out
tail -n 1 getTest.out | jq '.'
