
---

# 💻 **commands.sh**
```bash
#!/bin/bash
# Lab 8 - Managing Files and Directories

# Task 1 - Directories
mkdir lab_files
mkdir -p parent/child/grandchild
tree parent

# Task 2 - File operations
touch sample.txt
mv sample.txt lab_files/
cp lab_files/sample.txt lab_files/sample_copy.txt
rm lab_files/sample_copy.txt

# Task 3 - Directory cleanup
rmdir parent/child/grandchild
rm -r parent

# Wildcard operations
touch lab_files/file{1..5}.txt
rm lab_files/*.txt
