#!/bin/bash

# This is meant to be ran locally
# Need to check for env var : GITHUB_TOKEN 

: ${REPO_NAME?"Please set environment variable REPO_NAME to the name you want to use for your repo"}
: ${GITHUB_TOKEN?"Please set environment variable GITHUB_TOKEN to the PAT with package:read and repo persmission"}


REPOSITORY_ID=$(curl -k -H "Authorization:token ${GITHUB_TOKEN}" -H "Accept:application/vnd.github.baptiste-preview+json" -X POST -d '{"name":"'"$REPO_NAME"'", "owner":"octodemo"}' https://api.github.com/repos/octodemo/bookstore/generate | jq '.id')

# Create labels for the 'deploy' app to work
curl -k -H "Authorization:token ${GITHUB_TOKEN}" -H "Accept:application/vnd.github.baptiste-preview+json" -X POST -d '{"name":"Deploy to QA", "description":"Trigger a deploy event targeting the test environment", "color":"b4ffa5"}' https://api.github.com/repos/octodemo/$REPO_NAME/labels
curl -k -H "Authorization:token ${GITHUB_TOKEN}" -H "Accept:application/vnd.github.baptiste-preview+json" -X POST -d '{"name":"Deploy to Staging", "description":"Trigger a deploy event targeting the staging environment", "color":"f49107"}' https://api.github.com/repos/octodemo/$REPO_NAME/labels
curl -k -H "Authorization:token ${GITHUB_TOKEN}" -H "Accept:application/vnd.github.baptiste-preview+json" -X POST -d '{"name":"Deploy to Test", "description":"Trigger a deploy event targeting the staging environment", "color":"1ae049"}' https://api.github.com/repos/octodemo/$REPO_NAME/labels

# Install deploy app
#curl -k -H "Authorization:token ${GITHUB_TOKEN}" -H "Accept:application/vnd.github.baptiste-preview+json" -X POST https://api.github.com/user/installations/16591/repositories/:repository_id


az login
AZURE_SUBSCRIPTION_ID=$(az account list | jq -c '.[]' | grep 'PAYG' | jq '.id' | cut -d'"' -f2)
AZURE_RESOURCE_GROUP=bookstore
AZURE_PAYLOAD=$(az ad sp create-for-rbac --name "bookstore-review-$RANDOM" --role contributor \
                                --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/$AZURE_RESOURCE_GROUP \
                                --sdk-auth)
echo "Please copy this json and paste it as secret of https://github.com/octodemo/$REPO_NAME"
echo "Name it: AZURE_CREDENTIALS"
echo $AZURE_PAYLOAD | jq . #> payload

echo "Please generate a token with packages read and write"
echo "Name it: GPR_TOKEN"
echo "Install this App in the newly created repo https://probot.github.io/apps/deploy/"
