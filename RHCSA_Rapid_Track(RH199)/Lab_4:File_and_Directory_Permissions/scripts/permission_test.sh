#!/bin/bash
# Permission & ACL Verification Script


echo "=== Permission Test ==="
echo "User: $(whoami)"
echo "Directory: $(pwd)"


echo "\nFiles:"
ls -l *.txt *.sh 2>/dev/null


echo "\nDirectories:"
ls -ld testdir 2>/dev/null


echo "\nACL-enabled files:"
ls -l | grep "+" || echo "No ACLs set"


echo "\nACL details for acltest.txt:"
getfacl acltest.txt 2>/dev/null || echo "No ACL file found"
