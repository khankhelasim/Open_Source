
## Task 1: Change File Permissions with `chmod`

### Understanding File Permissions

Linux file permissions control who can read, write, or execute files and directories.

Permissions are displayed as:

```
rwxrwxrwx
```

* First three: Owner permissions
* Next three: Group permissions
* Last three: Other users permissions

Permission values:

* `r` = read (4)
* `w` = write (2)
* `x` = execute (1)

---

### Subtask 1.1: Create Test Files and Examine Default Permissions

```bash
mkdir ~/permissions_lab
cd ~/permissions_lab

echo "This is a regular text file" > textfile.txt
echo "#!/bin/bash" > script.sh
echo "echo 'Hello World'" >> script.sh
mkdir testdir

ls -l
```

**Expected Output:**

```
-rw-rw-r-- 1 student student   29 Nov 15 10:30 textfile.txt
-rw-rw-r-- 1 student student   32 Nov 15 10:30 script.sh
drwxrwxr-x 2 student student 4096 Nov 15 10:30 testdir
```

---

### Subtask 1.2: Using Numeric (Octal) Notation

```bash
chmod 755 script.sh
ls -l script.sh
```

Expected:

```
-rwxr-xr-x 1 student student 32 Nov 15 10:30 script.sh
```

```bash
chmod 600 textfile.txt
ls -l textfile.txt
```

Expected:

```
-rw------- 1 student student 29 Nov 15 10:30 textfile.txt
```

Test execution:

```bash
./script.sh
```

---

### Subtask 1.3: Using Symbolic Notation

```bash
chmod g+x,o+x script.sh
ls -l script.sh

chmod g-w textfile.txt
ls -l textfile.txt

chmod u+rw,g+r,o-rwx textfile.txt
ls -l textfile.txt
```

---

### Subtask 1.4: Directory Permissions

```bash
echo "Directory content" > testdir/file1.txt
echo "More content" > testdir/file2.txt

chmod -x testdir
ls -l

ls testdir
cd testdir
```

*Permission denied errors are expected.*

Restore access:

```bash
chmod +x testdir
ls testdir
```

---

## Task 2: Modify File Ownership with `chown`

### Subtask 2.1: Create Additional User Account

```bash
sudo su -
useradd testuser
passwd testuser

groupadd testgroup
usermod -a -G testgroup testuser
exit
```

---

### Subtask 2.2: Change File Ownership

```bash
ls -l ~/permissions_lab/

sudo chown testuser ~/permissions_lab/textfile.txt
ls -l ~/permissions_lab/textfile.txt
```

Expected:

```
-rw-r----- 1 testuser student 29 Nov 15 10:30 textfile.txt
```

```bash
sudo chown testuser:testgroup ~/permissions_lab/script.sh
ls -l ~/permissions_lab/script.sh
```

---

### Subtask 2.3: Recursive Ownership Changes

```bash
sudo chown -R testuser:testgroup ~/permissions_lab/testdir
ls -l ~/permissions_lab/
ls -l ~/permissions_lab/testdir/

sudo chgrp student ~/permissions_lab/textfile.txt
ls -l ~/permissions_lab/textfile.txt
```

---

## Task 3: Set Access Control Lists (ACLs)

### Subtask 3.1: Install and Verify ACL Support

```bash
which setfacl getfacl

sudo yum install acl -y
# or Ubuntu/Debian
sudo apt-get install acl -y

mount | grep acl
```

---

### Subtask 3.2: Set Basic ACLs

```bash
cd ~/permissions_lab
echo "ACL test content" > acltest.txt
ls -l acltest.txt

getfacl acltest.txt

setfacl -m u:testuser:rw acltest.txt
getfacl acltest.txt
ls -l acltest.txt
```

---

### Subtask 3.3: Advanced ACL Operations

```bash
setfacl -m g:testgroup:r acltest.txt
getfacl acltest.txt

setfacl -m d:u:testuser:rwx testdir
setfacl -m d:g:testgroup:rx testdir
getfacl testdir

echo "Testing default ACL" > testdir/newfile.txt
getfacl testdir/newfile.txt
```

---

### Subtask 3.4: Remove and Modify ACLs

```bash
setfacl -x u:testuser acltest.txt
getfacl acltest.txt

setfacl -b acltest.txt
getfacl acltest.txt
ls -l acltest.txt

setfacl -m u:testuser:rw,g:testgroup:r,o::--- acltest.txt
getfacl acltest.txt
```

---

## Verification and Testing

### Permission Test Script

```bash
cat > permission_test.sh << 'EOF'
#!/bin/bash
echo "=== Permission Testing Script ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"

echo "=== File Permissions ==="
ls -l *.txt *.sh 2>/dev/null

echo "=== Directory Permissions ==="
ls -ld testdir

echo "=== ACL Information ==="
ls -l | grep "+"

echo "=== Detailed ACL for acltest.txt ==="
getfacl acltest.txt 2>/dev/null

echo "=== Testing file access ==="
[ -r textfile.txt ] && echo "✓ Can read textfile.txt" || echo "✗ Cannot read textfile.txt"
[ -x script.sh ] && echo "✓ Can execute script.sh" || echo "✗ Cannot execute script.sh"
EOF

chmod +x permission_test.sh
./permission_test.sh
```

---
