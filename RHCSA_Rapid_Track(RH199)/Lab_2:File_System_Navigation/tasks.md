
## Task 1: Master Directory Navigation with `cd`, `ls`, and `find`

### Subtask 1.1: Understanding Your Current Location

**Step 1:** Check your current directory

```bash
pwd
```

Expected output:

```text
/home/student
```

**Step 2:** List directory contents

```bash
ls
```

**Step 3:** View detailed file information

```bash
ls -l
```

**Key Concept:** Displays permissions, ownership, size, and modification time.

---

### Subtask 1.2: Basic Directory Navigation

```bash
cd /
ls
cd /home
ls -l
cd ~
pwd
```

---

### Subtask 1.3: Advanced Navigation Techniques

```bash
cd ..
pwd
cd -
ls
cd Documents 2>/dev/null || echo "Documents directory doesn't exist yet"
```

---

### Subtask 1.4: Using the `find` Command

```bash
cd ~
find . -type f
find . -type d
find /etc -name "*.conf" -type f 2>/dev/null | head -10
```

---

## Task 2: Create Directories and Files

### Subtask 2.1: Creating Directory Structure

```bash
cd ~
mkdir lab2_practice
ls -l
mkdir projects documents scripts
mkdir -p lab2_practice/level1/level2/level3
ls -R lab2_practice
```

**Key Concept:** `-p` creates parent directories automatically.

---

### Subtask 2.2: Creating Files

```bash
cd lab2_practice
touch readme.txt
touch file1.txt file2.txt file3.txt
echo "This is my first Linux file" > welcome.txt
```

Create a multi-line file:

```bash
cat > myinfo.txt << EOF
Name: Student
Course: Red Hat System Administration
Lab: File System Navigation
Date: $(date)
EOF
```

Verify:

```bash
ls -l
```

---

### Subtask 2.3: Organizing Files

```bash
mv file1.txt level1/
mv file2.txt file3.txt level1/level2/
cp welcome.txt level1/level2/level3/
find . -type f
```

---

## Task 3: Explore File Permissions with `ls -l` and `chmod`

### Subtask 3.1: Understanding File Permissions

```bash
ls -l
```

Example:

```text
-rw-rw-r-- 1 student student   29 Nov 15 10:30 welcome.txt
drwxrwxr-x 3 student student 4096 Nov 15 10:25 level1
```

Permission breakdown:

* `r` = read (4)
* `w` = write (2)
* `x` = execute (1)

---

### Subtask 3.2: Permission Numbers

```bash
echo "Permission test file" > permissions_test.txt
ls -l permissions_test.txt
stat -c "%a %n" permissions_test.txt
```

---

### Subtask 3.3: Modifying File Permissions

```bash
chmod 644 permissions_test.txt
ls -l permissions_test.txt
chmod 744 permissions_test.txt
ls -l permissions_test.txt
chmod g+x permissions_test.txt
chmod o-r permissions_test.txt
ls -l permissions_test.txt
```

---

### Subtask 3.4: Directory Permissions

```bash
mkdir permission_test_dir
ls -ld permission_test_dir
chmod 755 permission_test_dir
echo "Directory test" > permission_test_dir/test_file.txt
chmod 644 permission_test_dir
ls permission_test_dir
chmod 755 permission_test_dir
ls permission_test_dir
```

---

### Subtask 3.5: Practical Permission Scenario

```bash
cat > myscript.sh << 'EOF'
#!/bin/bash
echo "Hello from my script!"
echo "Current directory: $(pwd)"
echo "Current user: $(whoami)"
EOF
```

```bash
ls -l myscript.sh
./myscript.sh
chmod +x myscript.sh
./myscript.sh
ls -l myscript.sh
```

---

## Troubleshooting Tips

* **Permission denied** → Check execute permission on directories
* **No such file or directory** → Use `pwd` and `ls`
* **Cannot create files** → Ensure write permission
* **Too many find results** → Use `head` or refine search

---

## Verification Commands

```bash
pwd
ls -la
tree . 2>/dev/null || find . -type d
stat -c "%a %n" filename
```

---
