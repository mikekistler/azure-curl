
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
# Use the default resource group in centralus - customize this for your environment
resourceGroupName=$(az group list --query "[?location == 'centralus'] | [?contains(name,'Default')] | [0].name" -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.AppConfiguration

apiVersion=2022-05-01

configStoreName=$(tail -n 1 listDeleted.out | jq -r '.value[0].name')
location=$(tail -n 1 listDeleted.out | jq -r '.value[0].properties.location')

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/locations/${location}/deletedConfigurationStores/${configStoreName}?api-version=${apiVersion} \
   > getDeleted.out

head -n 1 getDeleted.out
tail -n 1 getDeleted.out | jq '.'
