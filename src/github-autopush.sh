#!/bin/bash

source ~/.github

ORG_NAME="cryptokasten"

PROJECT_NAME=`pwd | rev | cut -d"/" -f 1 | rev`

curl -H "Authorization: token $GITHUB_TOKEN" --data "{\"name\":\"$PROJECT_NAME\"}" https://api.github.com/orgs/$ORG_NAME/repos

git remote add origin git@github.com:$ORG_NAME/$PROJECT_NAME.git

git push --set-upstream origin master
