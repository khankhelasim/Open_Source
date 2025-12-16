# Lab 10: Managing Special Permission Bits

## 📌 Overview

This lab focuses on **special Linux permission bits** — Sticky Bit, setuid, and setgid — which are critical for securing shared directories and controlling how executables run in multi-user Linux environments.


---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Understand and apply the **sticky bit** on shared directories
* Configure **setuid** and **setgid** permissions on executables
* Verify and test the behavior of special permission bits

---

## 🧰 Prerequisites

* Linux system (Fedora, CentOS, RHEL, Ubuntu)
* Root or `sudo` access
* Basic understanding of Linux permissions (`chmod`, `ls -l`)
* Terminal / CLI access

---

# 📝 Lab Tasks

## 🔹 Task 1: Set the Sticky Bit on a Shared Directory

The **sticky bit** ensures that only the file owner (or root) can delete or rename files inside a shared directory.

---

### ▶ Subtask 1.1: Create a Shared Directory

```bash
mkdir /tmp/shared_dir
chmod 777 /tmp/shared_dir
ls -ld /tmp/shared_dir
```

Expected Output:

```text
drwxrwxrwx 2 user user 4096 Jun 1 10:00 /tmp/shared_dir
```

---

### ▶ Subtask 1.2: Apply the Sticky Bit

```bash
chmod +t /tmp/shared_dir
ls -ld /tmp/shared_dir
```

Expected Output:

```text
drwxrwxrwt 2 user user 4096 Jun 1 10:00 /tmp/shared_dir
```

➡️ The **`t`** at the end confirms the sticky bit is active.

---

### ▶ Subtask 1.3: Test the Sticky Bit

Create files as different users:

```bash
touch /tmp/shared_dir/user1_file
sudo -u nobody touch /tmp/shared_dir/nobody_file
```

Attempt deletion as another user:

```bash
sudo -u nobody rm /tmp/shared_dir/user1_file
```

✅ **Expected Outcome:**

```text
Permission denied
```

Only the file owner or root can delete the file.

---

## 🔹 Task 2: Apply setuid and setgid on Executables

The **setuid** and **setgid** bits allow programs to run with the privileges of the file owner or group.

---

### ▶ Subtask 2.1: Create a Test Executable

```bash
echo '#!/bin/bash
echo "Effective UID: $EUID"' > /usr/local/bin/show_euid
chmod +x /usr/local/bin/show_euid
```

---

### ▶ Subtask 2.2: Apply setuid

```bash
chmod u+s /usr/local/bin/show_euid
ls -l /usr/local/bin/show_euid
```

Expected Output:

```text
-rwsr-xr-x 1 root root 45 Jun 1 10:05 /usr/local/bin/show_euid
```

➡️ **`s`** in the owner execute position indicates setuid.

Test as non-root:

```bash
sudo -u nobody /usr/local/bin/show_euid
```

Expected Output:

```text
Effective UID: 0
```

---

### ▶ Subtask 2.3: Apply setgid

```bash
groupadd testgroup
chown :testgroup /usr/local/bin/show_euid
chmod g+s /usr/local/bin/show_euid
ls -l /usr/local/bin/show_euid
```

Expected Output:

```text
-rwsr-sr-x 1 root testgroup 45 Jun 1 10:05 /usr/local/bin/show_euid
```

➡️ **`s`** in the group execute position indicates setgid.

---

## 🔹 Task 3: Verify Permission Behavior

### ▶ Subtask 3.1: Sticky Bit Verification

* Confirm non-owners cannot delete files in `/tmp/shared_dir`

### ▶ Subtask 3.2: setuid/setgid Verification

* Ensure executables run with elevated owner or group privileges

---

## 🛠 Troubleshooting Tips

* If setuid does not work, check mount options:

```bash
mount | grep nosuid
```

* Use `stat` for detailed permission info:

```bash
stat /usr/local/bin/show_euid
```

---

## ✅ Conclusion

In this lab, you learned how to:

* Secure shared directories using the **sticky bit**
* Control executable privilege escalation with **setuid** and **setgid**
* Verify special permission behavior in real scenarios

These skills are **essential for secure Linux system administration**, RHCSA preparation, and multi-user production environments.

---

## 🚀 Next Steps

* Explore **ACLs (Access Control Lists)** for advanced permission control
* Study real-world setuid binaries like `passwd`
* Practice securing shared directories in enterprise systems

---

🎉 **Lab 10 Complete**
