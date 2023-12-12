#!/bin/bash
NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dipatch")
for i in "${NAMES[@]}"
do
echo "NAME: $i"

done


#aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type t2.micro --security-group-ids sg-0feb1eadee760c918 