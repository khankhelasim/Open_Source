#!/bin/bash
# System Information Report


echo "=================================="
echo " SYSTEM INFORMATION REPORT"
echo "=================================="


echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo "User: $(whoami)"


echo "Disk Usage:"
df -h | head -5


echo "Memory Usage:"
free -h
