
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
# Use the default resource group in centralus - customize this for your environment
resourceGroupName=$(az group list --query "[?location == 'centralus'] | [?contains(name,'Default')] | [0].name" -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.AppConfiguration

apiVersion=2022-05-01

configStoreName=$(tail -n 1 listStores.out | jq -r '.value[0].name')
keyValueName="myKey\$myLabel"

body='{
  "properties": {
    "value": "myValue",
    "tags": {
      "tag1": "tagValue1",
      "tag2": "tagValue2"
    }
  }
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-Type: application/json" \
   -d "${body}" \
   ${baseUrl}/configurationStores//${configStoreName}/keyValues/${keyValueName}?api-version=${apiVersion} \
   > createKeyValue.out

head -n 1 createKeyValue.out
tail -n 1 createKeyValue.out | jq '.'
