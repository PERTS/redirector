#!/bin/sh

if [ -z $1 ]; then
  echo "Provide a redirection domain/path, like './build_app_yaml.sh neptune.perts.net/participate/portal'."
  exit 0
fi

echo "env_variables:\n  REDIRECT_TO: '$1'\n\n$(cat app.template.yaml)" > app.yaml
