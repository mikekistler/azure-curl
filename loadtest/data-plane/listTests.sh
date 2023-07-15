#!/bin/bash

source ./init.sh

apiVersion=2022-11-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${endpoint}/tests?api-version=${apiVersion} \
   > listTests.out

head -n 1 listTests.out
tail -n 1 listTests.out | jq '.'
