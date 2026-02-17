#!/bin/sh

PROJECT_ID="neptuneplatform"
VERSION="$1"
REDIRECT_TO="$2"

if [ -z "$VERSION" ] || [ -z "$REDIRECT_TO" ]; then
  echo "Usage: ./deploy.sh VERSION REDIRECT_TO"
  echo "Example: ./deploy.sh acceptance copilot.perts.net/portal"
  echo "Example: ./deploy.sh production neptune.perts.net/participate/portal"
  exit 0
fi

read -p "Deploy redirector to project '$PROJECT_ID' and have it redirect to 'https://$REDIRECT_TO' (version: $VERSION)? [y/N]: " CONFIRM_DEPLOY

if [ "$CONFIRM_DEPLOY" = 'y' ]; then
  ./build_app_yaml.sh $REDIRECT_TO --template app.neptune_template.yaml
  gcloud app deploy app.yaml --project=$PROJECT_ID --version=$VERSION --no-promote
else
  exit 0
fi
