
./getToken.sh
token=$(jq -r '.accessToken' token.json)

# Use the az cli to get the confidential ledger endpoint
baseUrl=$(az confidentialledger list --query '[0].properties.ledgerUri' -o tsv)

apiVersion=2022-05-13

userId="cffe0e0a-2921-4eae-9712-ba2195b48822"
body='{
    "assignedRole": "Reader"
}'

# -s hides the progress bar
# -k skip verification of the server certificate
# -D sends the headers to stdout
curl -s -k -D - -X PATCH \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/merge-patch+json" \
   -d "${body}" \
   ${baseUrl}/app/users/${userId}?api-version=${apiVersion} \
   > createUser.out

head -n 1 createUser.out
tail -n 1 createUser.out | jq '.'
