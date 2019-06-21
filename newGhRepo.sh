#!/bin/bash
# v1.0.3
# 20190619 - works with github API v3
# This is meant to one stop shopping to set up a new project based on dirname, boilerplate .gitignore, add files and create a Repo and description.
# Could be made far more friendly with some default decription, README and License logic, but I have other stuff to do.
# Requires: git config correctly configured and PAT applied for the correct account/project.
# Usage: 
# newGhRepo.sh called from within the new repo dir - can live anywhere. 
# Gather constant vars
CURRENTDIR=$(basename "$PWD")
DESCRIPTION="$CURRENTDIR"
GITHUBUSER=$(git config github.user)
USER=$(git config github.user)
GITHUBTOKEN=$(git config github.token)

# uncomment to test
#echo "Dir: $CURRENTDIR Desc $DESCRIPTION user $USER githubuser $GITHUBUSER token $GITHUBTOKEN"
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
git remote add origin git@github.com:${USER:-${GITHUBUSER}}/${REPONAME:-${CURRENTDIR}}.git
git push -u origin master
