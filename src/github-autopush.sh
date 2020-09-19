#!/bin/bash

source ~/.github

ORG_NAME="cryptokasten"

PROJECT_NAME=`pwd | rev | cut -d"/" -f 1 | rev`

TAGS=`cat README.org | grep "#+TAGS" | cut -d":" -f2 | sed 's/ //g' | sed 's/,/","/g'`

DESCRIPTION=`cat README.org | grep "#+DESCRIPTION" | sed "s/^#+DESCRIPTION: //g" | grep -v "#+"`

if [[ $DESCRIPTION == "" ]]
then
    DESCRIPTION=`cat README.org | grep "#+TITLE" | sed "s/^#+TITLE: //g" | grep -v "#+"`
fi

curl -H "Authorization: token $GITHUB_TOKEN" --data "{\"name\":\"$PROJECT_NAME\", \"description\": \"$DESCRIPTION\"}" https://api.github.com/orgs/$ORG_NAME/repos

curl -X PUT -H "Accept: application/vnd.github.mercy-preview+json" -H "Authorization: token $GITHUB_TOKEN" --data "{\"names\":[\"$TAGS\"]}" https://api.github.com/repos/$ORG_NAME/$PROJECT_NAME/topics

git remote add origin git@github.com:$ORG_NAME/$PROJECT_NAME.git

git push --set-upstream origin master
