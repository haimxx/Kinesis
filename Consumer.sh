#!/bin/bash

CHECK_INTERVAL=1
EXPORT_FILE_NAME=Chat_Output.txt
DIR=home/ec2-user/

cd $DIR
touch $EXPORT_FILE_NAME

#retrieve messages
SHARD_ITERATOR=$(aws kinesis get-shard-iterator --shard-id \
                shardId-000000000000 --shard-iterator-type \
                TRIM_HORIZON --stream-name kinesis-chat --query \
                'ShardIterator')

while [ true ]; do
    OUTPUT=$(aws kinesis get-records --shard-iterator $SHARD_ITERATOR)
    SHARD_ITERATOR=$(echo "$OUTPUT" | grep NextShardIterator \
    | cut -d '"' -f 4)
    echo "$OUTPUT" | grep Data | cut -d '"' -f 4 | base64 -d >> $EXPORT_FILE_NAME
    sleep $CHECK_INTERVAL
done
