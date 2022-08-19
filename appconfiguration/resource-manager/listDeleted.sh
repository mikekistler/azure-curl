
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/providers/Microsoft.AppConfiguration

apiVersion=2022-05-01

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/deletedConfigurationStores?api-version=${apiVersion} \
   > listDeleted.out

head -n 1 listDeleted.out
tail -n 1 listDeleted.out | jq '.'
