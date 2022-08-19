
./getToken.sh
token=$(jq -r '.accessToken' token.json)

next=$(tail -n 1 listDeleted.out | jq -r '.nextLink')

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   ${next} \
   > listDeletedNext.out

head -n 1 listDeletedNext.out
tail -n 1 listDeletedNext.out | jq '.'
