#!/bin/bash
# Interactive User Script


read -p "Enter your name: " username
read -p "Enter your favorite color: " color
read -p "Enter your age: " age


cat > ${username}-info.txt << EOF
Name: $username
Color: $color
Age: $age
Created: $(date)
EOF


echo "File ${username}-info.txt created successfully"
