#!/bin/bash
# File Management Script


backup_dir="backup-$(date +%Y%m%d)"
mkdir -p "$backup_dir"


for file in *.txt; do
[ -f "$file" ] && cp "$file" "$backup_dir"
done


echo "Backup completed: $backup_dir"
ls -la "$backup_dir"
