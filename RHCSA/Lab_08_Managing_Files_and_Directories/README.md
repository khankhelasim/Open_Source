# Lab 8: Managing Files and Directories

## 🎯 Objectives
By the end of this lab, you will be able to:
- Create directories using `mkdir`
- Move, copy, and delete files using `mv`, `cp`, and `rm`
- Delete empty and non-empty directories
- Use wildcards for bulk operations

---

## 🧰 Prerequisites
- Linux system (RHEL / Fedora / Ubuntu / CentOS)
- Terminal access
- Podman installed (optional)

---

# 🧪 Lab Tasks

## **Task 1: Creating Directories Using mkdir**

### ▶ Subtask 1.1: Create a single directory
```bash
mkdir lab_files
ls
```
📌 Expected: lab_files appears in listing.

### ▶ Subtask 1.2: Create nested directories
```bash
mkdir -p parent/child/grandchild
tree parent
```

📌 Structure:
```bash
parent/
└── child
    └── grandchild
```
## Task 2: Moving, Copying, and Deleting Files
### ▶ Subtask 2.1: Move files using mv
```bash
touch sample.txt
mv sample.txt lab_files/
ls lab_files/
```
### ▶ Subtask 2.2: Copy files using cp
```bash
cp lab_files/sample.txt lab_files/sample_copy.txt
ls lab_files/
```
### ▶ Subtask 2.3: Delete files using rm
```bash
rm lab_files/sample_copy.txt
ls lab_files/
```

📌 Expected: Only sample.txt remains.

## Task 3: Advanced Directory Management
### ▶ Subtask 3.1: Delete directories

Delete empty directory:
```bash
rmdir parent/child/grandchild
```

Delete full directory tree:
```bash
rm -r parent
```
### ▶ Subtask 3.2: Wildcard operations

Create multiple files:
```bash
touch lab_files/file{1..5}.txt
```

Delete all .txt files:
```bash
rm lab_files/*.txt
```
🛠 Troubleshooting

Issue	Solution

Permission denied	Use sudo

Directory not empty	Use rm -r

File not found	Check path + case sensitivity

✅ Summary

You've learned to:

Create directories (single & nested)

Move, copy, delete files and folders

Use recursive deletion

Perform wildcard-based bulk deletion

🚀 Next Steps

Try more scenarios:

Combine mv with wildcards

Use cp -r for copying directory trees

Use mv -i to prevent accidental overwrites
