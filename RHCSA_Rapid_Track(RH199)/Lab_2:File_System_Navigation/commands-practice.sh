#!/bin/bash
# Lab 2 Command Practice Reference


pwd
ls -la


cd /
ls


cd ~
pwd


mkdir -p lab2_practice/level1/level2/level3
cd lab2_practice


touch file1.txt file2.txt file3.txt
echo "This is my first Linux file" > welcome.txt


find . -type f


ls -l
chmod 644 welcome.txt
chmod 744 welcome.txt
chmod g+x welcome.txt
chmod o-r welcome.txt
