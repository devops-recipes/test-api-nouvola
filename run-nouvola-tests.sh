#! /bin/bash -e

echo "Running tests on Nouvola cloud..."

# Install JQ for parsing JSON response from Nouvola API
sudo apt-get update
sudo apt-get install jq

# Get test_id from Nouvola
TEST_ID=$(curl -X POST -H Content-Type:application/json -H "x-api:$API_PARAMS_NOUVOLA_API_KEY" https://divecloud.nouvola.com/api/v1/plans/$API_PARAMS_NOUVOLA_PLAN_ID/run --silent | jq -r ".test_id")
echo $TEST_ID

# Poll test run
TEST_STATUS=""

while [[ "$TEST_STATUS" != "Emailed" ]]; do
    TEST_STATUS=$(curl -X GET -H "Content-Type:application/json" -H "x-api:$API_PARAMS_NOUVOLA_API_KEY" https://divecloud.nouvola.com/api/v1/test_instances/$TEST_ID --silent | jq -r ".status")
    echo "Status of the test run is "$TEST_STATUS
    echo "Waiting for 10 seconds"
    sleep 10
done
