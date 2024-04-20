#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dipatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-0f3c7d07486cad139
SECURITY_GROUP_ID=sg-0c1104897a46b8099
DOMAIN_NAME=joiningindevops.online
#here, mysql or mongodb instance_type should be t3.medium, for others it is t2.micro

    for i in "${NAMES[@]}"
do

    if [[ $i == "mongodb" || $i == "mysql" ]]
then
    INSTANCE_TYPE="t3.medium"
else    
    INSTANCE_TYPE="t2.micro"
fi

    echo "creating $i instance"
    IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --instance-type $INSTANCE_TYPE --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" | jq -r '.Instances[0].PrivateIpAddress')
    echo "created $i instance: $IP_ADDRESS"
    aws route53 change-resource-record-sets --hosted-zone-id Z07158072WDZ3I52J42IG --change-batch '
    {
        "Changes": [{
            "Action": "CREATE",
                        "ResourceRecordSet": {
                                    "Name": "'$i.$DOMAIN_NAME'",
                                    "Type": "A",
                                    "TTL": 300,
                                 "ResourceRecords": [{ "Value": "'$IP_ADDRESS'"}]
                                 }}]
                        }
                        '
done