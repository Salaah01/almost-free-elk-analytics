#!/bin/env sh

# Pushes NGINX logs to an S3 bucket. This script assumes that logs are stored
# in the default NGINX log directory (/var/log/nginx) and that the AWS CLI is
# installed and configured with the necessary permissions.

if [ $# -eq 0 ]; then
  echo "Usage: $0 <S3_BUCKET>"
  exit 1
fi

# Set the directory where NGINX logs are stored
LOG_DIR="/var/log/nginx"

# S3 bucket name where logs will be uploaded
S3_BUCKET=$1

# Date string for timestamping (optional, used for organizing logs in S3)
DATE=$(date +\%Y-\%m-\%d)

# Log file pattern (e.g., access logs or error logs)
LOG_FILES="access.log error.log"

# Sync logs to S3 with a directory structure that includes the date
for log_file in $LOG_FILES; do
  if [ -f "$LOG_DIR/$log_file" ]; then
    echo "Uploading $log_file to S3..."
    aws s3 cp "$LOG_DIR/$log_file" "s3://$S3_BUCKET/$DATE-$log_file"
  fi
done
