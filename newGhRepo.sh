#!/bin/bash
# v1.0.3
# Gather constant vars
CURRENTDIR=$(basename "$PWD")
DESCRIPTION="$CURRENTDIR"
GITHUBUSER=$(git config github.user)
USER=$(git config github.user)
GITHUBTOKEN=$(git config github.token)


#echo "Dir: $CURRENTDIR Desc $DESCRIPTION user $USER githubuser $GITHUBUSER token $GITHUBTOKEN"
# Curl some json to the github API oh damn we so fancy
curl -u ${USER:-${GITHUBUSER}}:${GITHUBTOKEN} https://api.github.com/user/repos -d "{\"name\": \"${REPONAME:-${CURRENTDIR}}\", \"description\": \"${DESCRIPTION}\", \"private\": false, \"has_issues\": true, \"has_downloads\": true, \"has_wiki\": false}"
# 
echo ".ipynb_checkpoints/" >> .gitignore
echo ".gitignore " >> .gitignore
echo "*.swp" >> .gitignore
echo "newGhRepo.sh" >> .gitignore
echo "$CURRENTDIR" >> README.md
git init .
git add *
/usr/bin/git commit -m   "${CURRENTDIR} update $(date '+%Y%m%d%H%M%S')"
#
## Set the freshly created repo to the origin and push
## You'll need to have added your public key to your github account
git remote add origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
git push -u origin master
