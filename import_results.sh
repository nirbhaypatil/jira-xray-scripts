#!/bin/bash


echo "# ################################################
# Xray for JIRA is importing results.
#
##################################################"
sed -i "s/X-Y/$1/g" test-execution.json
current_date=$(date "+%Y\/%m\/%d-%H.%M.%S ")
echo "Current date and time  : $current_date"

sed -i "s/test run summary/$2 $current_date/g" test-execution.json
sed -i "s/test run description/$3/g" test-execution.json
sed -i "s/TEST_ENVIRONMENT/$4/g" test-execution.json

# declare base url
BASE_URL=https://xray.cloud.getxray.app

# get token for connecting to xray
token=$(curl -H "Content-Type: application/json" -X POST --data @"cloud_auth.json" "$BASE_URL/api/v1/authenticate"| tr -d '"')

#import cucumber.json into xray jira
curl -H "Content-Type: multipart/form-data" -X POST -F info=@"test-execution.json" -F results=@"target/cucumber-suite1.json"  -H "Authorization: Bearer $token" "$BASE_URL/api/v1/import/execution/cucumber/multipart"
curl -H "Content-Type: multipart/form-data" -X POST -F info=@"test-execution.json" -F results=@"target/cucumber-suite2.json"  -H "Authorization: Bearer $token" "$BASE_URL/api/v1/import/execution/cucumber/multipart"
curl -H "Content-Type: multipart/form-data" -X POST -F info=@"test-execution.json" -F results=@"target/cucumber.json"  -H "Authorization: Bearer $token" "$BASE_URL/api/v1/import/execution/cucumber/multipart"