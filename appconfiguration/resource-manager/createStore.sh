
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
# Use the default resource group in centralus - customize this for your environment
resourceGroupName=$(az group list --query "[?location == 'centralus'] | [?contains(name,'Default')] | [0].name" -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.AppConfiguration

configStoreName=$(tail -n 1 listStores.out | jq -r '.value[0].name')

# How to know what values for sku name ?  "Free" or "Standard"

body='{
    "location": "centralus",
    "sku": {
        "name": "Standard"
    },
    "properties": {}
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   -d "${body}" \
   ${baseUrl}/configurationStores/${configStoreName}?api-version=${apiVersion} \
   > createStore.out

head -n 1 createStore.out
tail -n 1 createStore.out | jq '.'
