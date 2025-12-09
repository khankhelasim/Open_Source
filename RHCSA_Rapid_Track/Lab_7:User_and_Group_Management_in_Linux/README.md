# Lab 7: User and Group Management in Linux

## Overview

This lab focuses on creating and managing users and groups in Linux, modifying user attributes, assigning/removing group memberships, and deleting accounts cleanly. All commands are ready to run as-is.

---

## Objectives

* Create and manage local Linux users and groups.
* Modify user attributes (home directory, shell).
* Add and remove users from groups.
* Delete users and groups safely.

---

## Prerequisites

* Linux system (Ubuntu/CentOS/Fedora).
* Terminal access.
* Root or **sudo** privileges.

---

## Task 1: Create New Users and Groups

### **Subtask 1.1 — Create New Users**

Create a new user **without** a home directory:

```bash
sudo useradd labuser1
```

Verify:

```bash
id labuser1
```

Create a user **with** a home directory:

```bash
sudo useradd -m labuser2
```

Verify:

```bash
id labuser2
```

### **Subtask 1.2 — Create a New Group**

Create a group named **developers**:

```bash
sudo groupadd developers
```

Verify:

```bash
grep developers /etc/group
```

---

## Task 2: Modify User Information

### **Subtask 2.1 — Change Home Directory**

Assign a new home directory to **labuser1**:

```bash
sudo usermod -d /home/labuser1_new -m labuser1
```

Verify:

```bash
ls /home
```

### **Subtask 2.2 — Change User Shell**

Set default shell to `/bin/bash`:

```bash
sudo usermod -s /bin/bash labuser1
```

Verify:

```bash
grep labuser1 /etc/passwd
```

---

## Task 3: Assign Users to Groups and Delete Them

### **Subtask 3.1 — Add Users to a Group**

```bash
sudo usermod -aG developers labuser1
sudo usermod -aG developers labuser2
```

Verify:

```bash
groups labuser1
```

### **Subtask 3.2 — Remove User from Group**

```bash
sudo gpasswd -d labuser1 developers
```

Verify:

```bash
groups labuser1
```

### **Subtask 3.3 — Delete Users and Groups**

Delete user and its home directory:

```bash
sudo userdel -r labuser1
```

Delete the group:

```bash
sudo groupdel developers
```

Verify:

```bash
grep developers /etc/group
```

---

## Troubleshooting Tips

* If deletion fails because processes are running:

  ```bash
  sudo pkill -u labuser1
  ```
* Use **sudo** for permission issues.

---

## Summary

In this lab, you performed:

* User creation and deletion.
* Group creation and management.
* Home directory and shell modification.
* Group membership assignment and removal.

These skills are essential for Linux system administration and align with RHCSA and Red Hat OpenShift admin fundamentals.

---

## Cleanup (Optional)

No cleanup required for this lab unless you recreated the environment manually.
