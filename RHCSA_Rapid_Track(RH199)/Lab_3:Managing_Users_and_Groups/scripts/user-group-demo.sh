#!/bin/bash
# User & Group Demonstration Script


echo "User and Group Information"
echo "=========================="


for user in "$@"; do
echo "User: $user"
id "$user"
echo "--------------------------"
done
