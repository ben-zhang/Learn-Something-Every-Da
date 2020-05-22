#!/usr/bin/env bash

git config user.name "Ben Zhang"
git config user.email "b334zhan@gmail.com"

message="Deploy commit $(git rev-parse HEAD)"
echo "Deploying $(git rev-parse HEAD) to master"

rm .gitignore # We want all compiled assets! ALL OF THEM
mv .gitignore.deploy .gitignore
git add --all
git commit -m "$message"
git push --force "git@github.com:ben-zhang/Learn-Something-Every-Da.git" develop:master
echo "Deployed! Going to sleep..."
