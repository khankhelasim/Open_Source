# Lab 11: Introduction to SELinux

## 📌 Overview

This lab introduces **SELinux (Security-Enhanced Linux)**, a core security feature in RHEL-based systems. You will learn how to verify SELinux installation, understand and switch between its operating modes, and inspect or modify SELinux file contexts.

This **README is fully ready-made and GitHub-ready** — copy and upload in one click, no edits required.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Verify and install SELinux packages
* Check and switch between SELinux modes (Enforcing, Permissive, Disabled)
* View and modify SELinux file contexts
* Restore default SELinux contexts safely

---

## 🧰 Prerequisites

* Linux system (RHEL, CentOS Stream, Fedora)
* Root or `sudo` privileges
* Basic Linux command-line knowledge

---

# 📝 Lab Tasks

## 🔹 Task 1: Install and Configure SELinux

### ▶ Subtask 1.1: Verify SELinux Installation

Most modern RHEL-based systems have SELinux installed by default.

```bash
rpm -qa | grep selinux
```

Expected Output:

```text
libselinux
selinux-policy
selinux-policy-targeted
```

If SELinux is missing, install it:

```bash
sudo dnf install -y selinux-policy selinux-policy-targeted libselinux-utils
```

---

### ▶ Subtask 1.2: Check SELinux Status

```bash
sestatus
```

Expected Output includes:

* SELinux status: enabled
* Current mode: enforcing / permissive / disabled
* Loaded policy: targeted

---

## 🔹 Task 2: Understanding SELinux Modes

SELinux operates in three modes:

* **Enforcing** – policies are enforced (default)
* **Permissive** – violations are logged but not blocked
* **Disabled** – SELinux is turned off

---

### ▶ Check Current Mode

```bash
getenforce
```

---

### ▶ Temporarily Change Mode (Until Reboot)

Switch to permissive mode:

```bash
sudo setenforce 0
```

Switch back to enforcing:

```bash
sudo setenforce 1
```

---

### ▶ Permanently Change SELinux Mode

Edit the SELinux configuration file:

```bash
sudo vi /etc/selinux/config
```

Set one of the following values:

```text
SELINUX=enforcing
SELINUX=permissive
SELINUX=disabled
```

Reboot the system to apply changes:

```bash
sudo reboot
```

Verify after reboot:

```bash
sestatus
```

---

## 🔹 Task 3: Check and Modify SELinux Contexts

### ▶ Subtask 3.1: View File Contexts

```bash
ls -Z /etc/passwd
```

Example Output:

```text
system_u:object_r:passwd_file_t:s0
```

---

### ▶ Subtask 3.2: Change File Context Temporarily

Create a test file for a web server:

```bash
sudo touch /var/www/html/testfile.html
ls -Z /var/www/html/testfile.html
```

Change the context to allow web access:

```bash
sudo chcon -t httpd_sys_content_t /var/www/html/testfile.html
ls -Z /var/www/html/testfile.html
```

Expected Outcome:

```text
system_u:object_r:httpd_sys_content_t:s0
```

---

### ▶ Subtask 3.3: Restore Default Context

```bash
sudo restorecon -v /var/www/html/testfile.html
```

This resets the file to its default SELinux context.

---

## 🛠 Troubleshooting Tips

* Check SELinux denial logs:

```bash
sudo ausearch -m avc -ts recent
```

* Generate a policy module (advanced troubleshooting):

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy
sudo semodule -i mypolicy.pp
```

---

## ✅ Conclusion

In this lab, you learned how to:

* Verify and install SELinux
* Work with SELinux operating modes
* Inspect, modify, and restore SELinux file contexts

SELinux provides **mandatory access control (MAC)** and is a critical security layer for enterprise Linux systems and RHCSA certification.

---

## 🚀 Next Steps

* Explore SELinux booleans using `getsebool` and `setsebool`
* Study SELinux policies in more depth
* Practice troubleshooting SELinux denials in real services

---

🎉 **Lab 11 Complete**
