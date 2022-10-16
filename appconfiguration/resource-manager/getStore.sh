
source ./init.sh

baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.AppConfiguration

apiVersion=2022-05-01

configStoreName=mdk-configstor  # $(tail -n 1 listStores.out | jq -r '.value[0].name')

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X GET \
   -H "Authorization: Bearer ${token}" \
   ${baseUrl}/configurationStores/${configStoreName}?api-version=${apiVersion} \
   > getStore.out

head -n 1 getStore.out
tail -n 1 getStore.out | jq '.'
