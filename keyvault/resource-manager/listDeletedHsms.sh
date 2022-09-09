
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/providers/Microsoft.KeyVault

apiVersion=2022-07-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/deletedManagedHSMs?api-version=${apiVersion} \
   > listDeletedHsms.out

head -n 1 listDeletedHsms.out
tail -n 1 listDeletedHsms.out | jq '.'
