# Lab 9: Linux Permissions Overview

## 📌 Overview

This lab introduces **Linux file and directory permissions**, a core concept for system security and access control. You will learn how to view, interpret, and modify permissions, as well as change file ownership and group assignments using standard Linux utilities.



---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Understand Linux file and directory permission structure
* View permissions using `ls -l`
* Modify permissions using `chmod`
* Change file ownership and group using `chown` and `chgrp`

---

## 🧰 Prerequisites

* Linux-based system (Ubuntu, CentOS, Fedora, RHEL)
* Basic command-line knowledge
* Non-root user with `sudo` privileges

---

# 📝 Lab Tasks

## 🔹 Task 1: Viewing File and Directory Permissions

### Step 1: List Files with Permissions

```bash
ls -l
```

### Example Output:

```text
-rw-r--r-- 1 user group 1024 Jan 1 10:00 file.txt
drwxr-xr-x 2 user group 4096 Jan 1 10:01 directory
```

### Explanation:

* First character:

  * `-` → regular file
  * `d` → directory
* Next 9 characters → permissions:

  * Owner (u)
  * Group (g)
  * Others (o)

---

### Step 2: Permission Notation Breakdown

| Symbol | Meaning       |
| ------ | ------------- |
| r      | Read          |
| w      | Write         |
| x      | Execute       |
| -      | No permission |

Example:

```text
rwxr-xr--
```

* Owner: Read, Write, Execute
* Group: Read, Execute
* Others: Read

---

## 🔹 Task 2: Modifying Permissions with `chmod`

### Step 1: Numeric (Octal) Mode

Create a test file:

```bash
touch testfile.txt
```

Set permissions to `rw-r-----`:

```bash
chmod 640 testfile.txt
ls -l testfile.txt
```

Expected Output:

```text
-rw-r----- 1 user group 0 Jan 1 10:05 testfile.txt
```

---

### Step 2: Symbolic Mode

Add execute permission for owner:

```bash
chmod u+x testfile.txt
```

Remove read permission for others:

```bash
chmod o-r testfile.txt
ls -l testfile.txt
```

Expected Output:

```text
-rwxr----- 1 user group 0 Jan 1 10:05 testfile.txt
```

---

### ⚠️ Troubleshooting Tip

If you encounter **Permission denied**, ensure:

```bash
sudo <command>
```

Or verify ownership and permissions.

---

## 🔹 Task 3: Changing Ownership and Group

### Step 1: Change File Owner (`chown`)

Create a test user (if required):

```bash
sudo useradd testuser
```

Change file owner:

```bash
sudo chown testuser testfile.txt
ls -l testfile.txt
```

Expected Output:

```text
-rwxr----- 1 testuser group 0 Jan 1 10:05 testfile.txt
```

---

### Step 2: Change Group Ownership (`chgrp`)

Create a test group:

```bash
sudo groupadd testgroup
```

Change file group:

```bash
sudo chgrp testgroup testfile.txt
ls -l testfile.txt
```

Expected Output:

```text
-rwxr----- 1 testuser testgroup 0 Jan 1 10:05 testfile.txt
```

---

### Alternative: Change Owner and Group Together

```bash
sudo chown testuser:testgroup testfile.txt
```

---

## ✅ Conclusion

In this lab, you learned how to:

* View file and directory permissions using `ls -l`
* Modify permissions using `chmod` (numeric & symbolic modes)
* Change ownership and group assignments with `chown` and `chgrp`

These skills are **critical for Linux security, RHCSA preparation, and container platforms like Podman and OpenShift**.

---

## 🚀 Next Steps

* Practice with different permission combinations
* Learn about `umask` for default permissions
* Apply permission concepts inside Podman containers

---

🎉 **Lab 9 Complete**
