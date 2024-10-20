#!/bin/env sh

# Fetches logs from an S3 bucket and stores them in a local logs directory.

if [ $# -eq 0 ]; then
  echo "Usage: $0 <S3_BUCKET>"
  exit 1
fi

# Directory where logs will be downloaded
LOG_DIR=./.logs

# S3 bucket name
S3_BUCKET=$1

# Sync logs from S3 to local directory
echo "Pulling logs from S3..."
aws s3 sync s3://$S3_BUCKET/ $LOG_DIR/

# Optional: Remove logs older than a certain period to save space
find $LOG_DIR -type f -mtime +7 -exec rm {} \;
