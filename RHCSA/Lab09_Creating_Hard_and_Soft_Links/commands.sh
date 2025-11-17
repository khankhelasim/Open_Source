
---

# ✅ **commands.sh**

```bash
#!/bin/bash
# Lab 9: Creating Hard and Soft Links - Commands Script

mkdir link_lab && cd link_lab

echo "This is the original file." > original.txt
cat original.txt

ln original.txt hardlink.txt
ls -li

echo "Appended via hard link." >> hardlink.txt
cat original.txt
cat hardlink.txt

rm hardlink.txt
cat original.txt

ln -s original.txt symlink.txt
ls -l

cat symlink.txt
rm original.txt
cat symlink.txt

echo "New content." > original.txt
cat symlink.txt

rm symlink.txt

df -h /tmp
ln original.txt /tmp/hardlink_fail.txt

ln -s $(pwd)/original.txt /tmp/symlink_success.txt
cat /tmp/symlink_success.txt
