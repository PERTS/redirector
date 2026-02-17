#!/bin/sh

# Default template file
TEMPLATE_FILE="app.template.yaml"

# Parse arguments
REDIRECT_TO=""
while [ $# -gt 0 ]; do
  case "$1" in
    --template)
      if [ -n "$2" ] && [ "${2#--}" = "$2" ]; then
        TEMPLATE_FILE="$2"
        shift 2
      else
        echo "Error: --template requires a file name argument"
        exit 1
      fi
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
    *)
      if [ -z "$REDIRECT_TO" ]; then
        REDIRECT_TO="$1"
      fi
      shift
      ;;
  esac
done

if [ -z "$REDIRECT_TO" ]; then
  echo "Provide a redirection domain/path, like './build_app_yaml.sh neptune.perts.net/participate/portal'."
  exit 0
fi

echo "env_variables:\n  REDIRECT_TO: '$REDIRECT_TO'\n\n$(cat $TEMPLATE_FILE)" > app.yaml
echo "REDIRECT_TO='$REDIRECT_TO'" > .env

echo "Wrote two files:"
echo "* app.yaml - for deployment to App Engine, with REDIRECT_TO set to '$REDIRECT_TO'"
echo "* .env - for local development, with REDIRECT_TO set to '$REDIRECT_TO'"
echo ""
