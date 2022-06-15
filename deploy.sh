#!/bin/sh

if [ -z $1 ] || [ -z $2 ]; then
  echo "Provide a project ID and redirection domain/path, like 'npm run deploy perts-me neptune.perts.net/participate/portal'."
  exit 0
fi

read -p "Deploy redirector to project '$1' and have it redirect to 'https://$2'? [y/N]: " CONFIRM_DEPLOY

if [ "$CONFIRM_DEPLOY" = 'y' ]; then
  ./build_app_yaml.sh $2
  gcloud app deploy app.yaml --project=$1 --version=production --no-promote
else
  exit 0
fi
