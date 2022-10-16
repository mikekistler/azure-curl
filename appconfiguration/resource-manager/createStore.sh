
source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.AppConfiguration

apiVersion=2022-05-01

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
