# Lab 9: Creating Hard and Soft Links

## Objectives
By the end of this lab, you will be able to:

- Understand the difference between hard and soft (symbolic) links
- Create and manage hard links using `ln`
- Create and manage symbolic links using `ln -s`
- Verify inode numbers and link relationships
- Understand limitations of hard links across filesystems

---

## Prerequisites
- Linux system (Fedora, Ubuntu, CentOS etc.)
- Basic command-line skills
- Terminal access (non-root user recommended)

---

## Task 1: Create and Delete Hard Links

### **1.1 Create a Sample File**
```bash
mkdir link_lab && cd link_lab
echo "This is the original file." > original.txt
cat original.txt
```
### 1.2 Create a Hard Link
```bash
ln original.txt hardlink.txt
ls -li
```

Expected: Both files should show the same inode number.

### 1.3 Test Hard Link Behavior
```bash
echo "Appended via hard link." >> hardlink.txt
cat original.txt
cat hardlink.txt
```
### 1.4 Delete the Hard Link
```bash
rm hardlink.txt
cat original.txt
```
## Task 2: Create and Delete Symbolic (Soft) Links
### 2.1 Create a Symbolic Link
```bash
ln -s original.txt symlink.txt
ls -l
```
### 2.2 Test Symbolic Link Behavior
```bash
cat symlink.txt
rm original.txt
cat symlink.txt   # Expect: broken symlink error
```
### 2.3 Recreate & Delete the Symbolic Link
```bash
echo "New content." > original.txt
cat symlink.txt
rm symlink.txt
```
## Task 3: Links Across Filesystems
### 3.1 Hard Link Across Filesystems (Fails)
```bash
df -h /tmp
ln original.txt /tmp/hardlink_fail.txt    # Expect: Invalid cross-device link
```
### 3.2 Soft Link Across Filesystems (Works)
```bash
ln -s $(pwd)/original.txt /tmp/symlink_success.txt
cat /tmp/symlink_success.txt
```
## Key Takeaways

Hard links

Share the same inode

Cannot cross filesystems

Data survives even if the original file is deleted

Symbolic links

Point to a file path (not inode)

Can cross filesystems

Break if the target file is removed

## Troubleshooting

Broken symlink? → Check if target file exists

Need inode information? → Use:
```bash
ls -li filename
```

Hard link failed? → Likely cross-filesystem issue
