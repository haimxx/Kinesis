#!/bin/bash

NAME=$(curl http://169.254.169.254/latest/meta-data/instance-id)

#send message
while [ true ]; do
	sleep $((5 + RANDOM % 10))
	MESSAGE=$(cat << EOT
	{
		"name": "$NAME",
		"message": "test",
		"channel name": "lobby",
		"time": $(date)
	}
EOT
)

	MESSAGE=$(echo "$MESSAGE" | base64)
	aws kinesis put-record --stream-name kinesis-chat --partition-key 123 \
	--data "$MESSAGE"
done
