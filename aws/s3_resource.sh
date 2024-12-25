#!/bin/bash

#################################################
#
# Author - Emmanuel Gyang
# Last Modified - 24/12/2024
# Usage - This script would remove unused s3 buckets
# Version - v1
#
##################################################


set -x

# Check for unused aws s3 resources and remove them
buckets=$(aws s3 ls | awk -F" " '{print $3}')

for bucket in $buckets; do
	if [ -z "$(aws s3 ls $bucket)" ]; then
		echo "Deleting $bucket"
		aws s3 rb s3://$bucket
	else
		echo "$bucket is not empty"
	fi
done
