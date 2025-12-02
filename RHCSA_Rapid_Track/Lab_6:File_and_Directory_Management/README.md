# Lab 6: File and Directory Management

## 📌 Overview

This lab focuses on mastering essential **Linux file and directory management** commands. You will learn to create, delete, move, and copy files and directories while practicing both **relative** and **absolute** paths.

This README is fully **GitHub‑ready** — no edits required.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Create and delete files & directories
* Move and copy files
* Work with relative and absolute paths
* Build and explore nested directory structures
* Use essential Linux commands for filesystem operations

---

## 🧰 Prerequisites

* Any Linux distribution (Ubuntu, CentOS, RHEL, Fedora)
* Basic command-line knowledge
* Terminal access

---

# 📝 Lab Tasks

## **Task 1: Create and Delete Files & Directories**

### 🔹 **1.1: Creating Files and Directories**

Create dedicated lab folder:

```bash
pwd
mkdir file_management_lab
cd file_management_lab
```

Create directory:

```bash
mkdir documents
```

Create empty files:

```bash
touch file1.txt file2.txt file3.txt
```

Verify:

```bash
ls -l
```

---

### 🔹 **1.2: Deleting Files and Directories**

Delete a file:

```bash
rm file3.txt
```

Attempt to delete non‑empty directory:

```bash
rmdir documents
```

(This will **fail** because the directory is not empty.)

Forcefully delete directory:

```bash
rm -r documents
```

Key Concept:

* `-r` → recursive deletion

---

## **Task 2: Move and Copy Files**

### 🔹 **2.1: Moving Files**

Rebuild structure:

```bash
mkdir documents backups
touch file1.txt file2.txt
```

Move file:

```bash
mv file1.txt documents/
```

Verify:

```bash
ls documents/
```

---

### 🔹 **2.2: Copying Files**

Copy file to backups:

```bash
cp file2.txt backups/
```

Create local duplicate:

```bash
cp file2.txt file2_backup.txt
```

Verify:

```bash
ls backups/ && ls
```

---

## **Task 3: Working with Relative & Absolute Paths**

### 🔹 **3.1: Relative Path Navigation**

Navigate using relative paths:

```bash
cd documents
cd ..
ls backups/
```

---

### 🔹 **3.2: Absolute Path Operations**

Get full path:

```bash
pwd
```

Example:

```
/home/user/file_management_lab
```

Create file using absolute path:

```bash
touch /home/user/file_management_lab/absolute_example.txt
```

Copy file using absolute paths:

```bash
cp /home/user/file_management_lab/absolute_example.txt /home/user/file_management_lab/backups/
```

---

## ⭐ Advanced Exercise

Create nested directories:

```bash
mkdir -p projects/{src,doc,bin}
```

Move all `.txt` files:

```bash
mv *.txt projects/doc/
```

View tree structure:

```bash
tree
```

(Install with `sudo apt install tree` or `sudo dnf install tree` if required.)

---

## ✅ Conclusion

In this lab, you learned:

* Creating & deleting files and directories
* Moving and copying files
* Working with relative and absolute paths
* Organizing complex directory structures

Final verification:

```bash
find . -type d -print
```

---

## 🧹 Cleanup

```bash
cd ..
rm -rf file_management_lab
```

---

**End of Lab 6**
