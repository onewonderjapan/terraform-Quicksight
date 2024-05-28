#!/bin/bash

ACCOUNT_ID=$1
FOLDER_ID=$2
GROUP_ARN=$3
REGION=$4

aws quicksight update-folder-permissions \
    --aws-account-id $ACCOUNT_ID \
    --folder-id $FOLDER_ID \
    --grant-permissions Principal=$GROUP_ARN,Actions=quicksight:DescribeFolder \
    --region $REGION