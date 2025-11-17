# Lab 10: Managing File Permissions (ugo/rwx)

## Objectives
In this lab, you will learn how to:

- Understand and interpret Linux file permissions
- Modify permissions using `chmod` (symbolic and numeric)
- Change file ownership with `chown`
- Change group ownership with `chgrp`
- Follow best practices for secure permission management

---

## Prerequisites
- Linux-based system (Ubuntu, CentOS, Fedora, etc.)
- Basic terminal knowledge
- Non-root user with sudo privileges

---

## Task 1: View File Permissions with `ls -l`

### Step 1: List Files with Detailed Permissions
```bash
ls -l
```
Example Output:
```bash
-rw-r--r-- 1 user group 1024 Jun 10 10:00 example.txt
drwxr-xr-x 2 user group 4096 Jun 10 10:01 directory
```
### Step 2: Understand Permission Structure

#### File types

- → regular file

d → directory

#### Permission groups

u → user/owner

g → group

o → others

#### Permission types

r → read

w → write

x → execute

## Task 2: Change File Permissions Using chmod
### Step 1: Symbolic Mode

Add execute permission to owner:
```bash
chmod u+x example.txt
ls -l example.txt
```

Expected:
```bash
-rwxr--r-- 1 user group 1024 Jun 10 10:00 example.txt
```
### Step 2: Numeric Mode

Set permissions rw-r----- (640):
```bash
chmod 640 example.txt
ls -l example.txt
```

Expected:
```bash
-rw-r----- 1 user group 1024 Jun 10 10:00 example.txt
```

#### Numeric breakdown:

Read = 4

Write = 2

Execute = 1

Owner 6 (4+2), Group 4, Others 0

## Task 3: Modify Ownership with chown and chgrp
### Step 1: Change Owner
```bash
sudo chown newuser example.txt
ls -l example.txt
```

Expected:
```bash
-rw-r----- 1 newuser group 1024 Jun 10 10:00 example.txt
```
### Step 2: Change Group Ownership
```bash
sudo chgrp newgroup example.txt
ls -l example.txt
```

Expected:
```bash
-rw-r----- 1 newuser newgroup 1024 Jun 10 10:00 example.txt
```
Conclusion

In this lab, you practiced:

Viewing permissions using ls -l

Modifying permissions (symbolic + numeric)

Changing file ownership and group ownership

Understanding secure access control

## Best Practices

Use chmod 600 for sensitive files

Avoid insecure permissions like 777

Use groups to simplify collaborative access

Use chmod -R cautiously on directories

## Next Steps

Explore Access Control Lists (ACLs)

Practice recursive permissions on directories

### 🎉 Lab Completed Successfully!
