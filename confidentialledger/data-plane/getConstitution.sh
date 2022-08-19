
./getToken.sh
token=$(jq -r '.accessToken' token.json)

# Use the az cli to get the confidential ledger endpoint
baseUrl=$(az confidentialledger list --query '[0].properties.ledgerUri' -o tsv)

apiVersion=2022-05-13

# -s hides the progress bar
# -k skip verification of the server certificate
# -D sends the headers to stdout
curl -s -k -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/app/governance/constitution?api-version=${apiVersion} \
   > getConstitution.out

head -n 1 getConstitution.out
tail -n 1 getConstitution.out | jq '.'
