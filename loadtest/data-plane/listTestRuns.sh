#!/bin/bash

source ./init.sh

apiVersion=2022-06-01-preview

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${endpoint}/testruns/sortAndFilter?api-version=${apiVersion} \
   > listTestRuns.out

head -n 1 listTestRuns.out
tail -n 1 listTestRuns.out | jq '.'
