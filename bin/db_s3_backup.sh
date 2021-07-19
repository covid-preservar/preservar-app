#!/bin/bash

# terminate script as soon as any command fails
set -e

if [[ -z "$APP" ]]; then
  echo "Missing APP variable which must be set to the name of your app where the db is located"
  exit 1
fi

if [[ -z "$DATABASE" ]]; then
  echo "Missing DATABASE variable which must be set to the name of the DATABASE you would like to backup"
  exit 1
fi

if [[ -z "$DB_S3_BUCKET_PATH" ]]; then
  echo "Missing DB_S3_BUCKET_PATH variable which must be set the directory in s3 where you would like to store your database backups"
  exit 1
fi

echo "Installing AWS cli"
AWS_CLI_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
BUILD_DIR="/app"
INSTALL_DIR="/app/.awscli"
TMP_DIR=$(mktemp -d)

curl --silent --show-error --fail -o "${TMP_DIR}/awscliv2.zip" "${AWS_CLI_URL}"
unzip -qq -d "${TMP_DIR}" "${TMP_DIR}/awscliv2.zip"
mkdir -p "${BUILD_DIR}/.awscli"
"${TMP_DIR}/aws/install" --install-dir "${INSTALL_DIR}/aws-cli" --bin-dir "${INSTALL_DIR}/bin"
rm -rf "${TMP_DIR}"

BACKUP_FILE_NAME="$(date +"%Y-%m-%d-%H-%M")-$APP-$DATABASE.dump"

# heroku pg:backups capture $DATABASE --app $APP
curl -o $BACKUP_FILE_NAME `heroku pg:backups:url --app $APP`
FINAL_FILE_NAME=$BACKUP_FILE_NAME

if [[ -z "$NOGZIP" ]]; then
  gzip $BACKUP_FILE_NAME
  FINAL_FILE_NAME=$BACKUP_FILE_NAME.gz
fi

.awscli/bin/aws s3 cp $FINAL_FILE_NAME s3://$DB_S3_BUCKET_PATH/$APP/$DATABASE/$FINAL_FILE_NAME

echo "backup $FINAL_FILE_NAME complete"

