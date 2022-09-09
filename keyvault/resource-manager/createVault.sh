
./getToken.sh
token=$(jq -r '.accessToken' token.json)

subscriptionId=$(az account show --query 'id' -o tsv)
# Use the default resource group in centralus - customize this for your environment
resourceGroupName=$(az group list --query "[?location == 'centralus'] | [?contains(name,'Default')] | [0].name" -o tsv)
baseUrl=https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${resourceGroupName}/providers/Microsoft.KeyVault

tenantId=$(az account show --query 'tenantId' -o tsv)

apiVersion=2022-07-01

vaultName=mdk-test

# How to know what values for sku name ?  "Free" or "Standard"
body='{
  "location": "centralus",
  "properties": {
    "tenantId": "'${tenantId}'",
    "sku": {
      "family": "A",
      "name": "standard"
    },
    "accessPolicies": []
  }
}'

# -s hides the progress bar
# -D sends the headers to stdout
curl -s -D - -X PUT \
   -H "Authorization: Bearer ${token}" \
   -H "Content-type: application/json" \
   -d "${body}" \
   ${baseUrl}/vaults/${vaultName}?api-version=${apiVersion} \
   > createVault.out

head -n 1 createVault.out
tail -n 1 createVault.out | jq '.'
