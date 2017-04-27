while [[ "$STATUS" != "Success" ]]
do
  STATUS=$(curl -X GET -H 'Content-Type: application/json' -H "x-api: d9dde441e880ced79fd3a076d10de224" https://divecloud.nouvola.com/api/v1/test_instances/$TEST_ID --silent | jq -r ".status")
  echo "Status of the test run is"$STATUS
  sleep 2	
done

