#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dipatch")
INSTANCE_TYPE=""
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-0feb1eadee760c918

#here, mysql or mongodb instance_type should be t3.medium, for others it is t2.micro

    for i in "${NAMES[@]}"
do
    if [ [ $i == "mongodb" || $i = "mysql"] ];
then
    INSTANCE_TYPE="t3.medium"
else    
    INSTANCE_TYPE="t2.micro"
fi

    echo "creating $i instance"
    aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE="" --security-group-ids sg-0feb1eadee760c918
    --tag-specifications "ResourceType=security-group,Tags=[{Key=Name,Value=$i}]"
done