
./getToken.sh
token=$(jq -r '.accessToken' token.json)

# sed removes the CR at the end of the value
azure_asyncoperation="$(grep -i 'azure-asyncoperation' createStore.out | awk '{print $2}' | sed 's/\r$//')"

curl -s -D - -X GET \
  -H "Authorization: Bearer ${token}" \
  "${azure_asyncoperation}" \
   > getCreateStatus.out

head -n 1 getCreateStatus.out
tail -n 1 getCreateStatus.out | jq '.'
