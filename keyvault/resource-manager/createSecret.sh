
./getToken.sh
token=$(jq -r '.accessToken' token.json)

vaultBaseUrl=https://management.azure.com$(tail -1 createVault.out | jq -r '.id')

apiVersion=2022-07-01

secret_name=mdk-test-secret

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   --data '{"properties":{"value": "my secret value"}}' \
   ${vaultBaseUrl}/secrets//${secret_name}?api-version=${apiVersion} \
   > createSecret.out

head -n 1 createSecret.out
tail -n 1 createSecret.out | jq '.'
