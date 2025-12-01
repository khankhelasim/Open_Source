# RHCSA Rapid Track – Lab 1: Local Login to Linux Systems

## 📘 Overview
This lab covers the most fundamental skill in Linux system administration — **logging in locally** and exploring **virtual terminals**. These steps are crucial for understanding system access, troubleshooting, and managing multiple sessions in a Linux environment.

---

## 🎯 Objectives
By the end of this lab, you will be able to:

- Access a Linux system physically via terminal or console.
- Log in using a username and password.
- Explore and switch between virtual terminals (tty1–tty6).

---

## 🧰 Prerequisites

- A physical or virtual machine running any Linux distribution (Fedora, RHEL, CentOS, Ubuntu, etc.)
- A **non-root user account** with a password
- Basic familiarity with the Linux command-line interface

---

# 📝 Tasks

## **Task 1: Access the Linux System Physically**

### 🔹 Subtask 1.1: Power On the System
- Turn on your physical machine  
**OR**
- Start your VM (VirtualBox, VMware, KVM, etc.)

### 🔹 Subtask 1.2: Reach the Login Prompt
- After boot, wait for the **login prompt**.
- If a **graphical login** appears, switch to a text terminal:

Ctrl + Alt + F2


You should see something similar to:



Fedora 38 (Workstation Edition)

Kernel 6.2.15-200.fc38.x86_64 on an x86_64 (tty2)

localhost login: _

#### 💡 Troubleshooting
If you need a text terminal:
- Switch between terminals using **Ctrl + Alt + F2–F6**

---

## **Task 2: Log In Using Username and Password**

### 🔹 Subtask 2.1: Enter Username
At the prompt:

localhost login: user1


### 🔹 Subtask 2.2: Enter Password
When asked for a password, type it (it will remain invisible):



Password:


On success:



[user1@localhost ~]$

#### 💡 Troubleshooting
If login fails:
- Recheck username/password
- If locked out, a sysadmin may reset the password

---

## **Task 3: Explore Virtual Terminals**

### 🔹 Subtask 3.1: Switch Between Virtual Terminals
Linux provides multiple TTYs:

Ctrl + Alt + F3 → Switch to tty3
Ctrl + Alt + F2 → Return to tty2

Log in again if prompted.

### 🔹 Subtask 3.2: Identify Current Terminal
Run:

tty


Expected Output:



/dev/tty2


### 🔹 Subtask 3.3: List Logged-in Users



who


Expected Output Example:



user1 tty2 2023-10-10 14:30
user1 tty3 2023-10-10 14:35


#### 💡 Troubleshooting
If switching doesn’t work:
- Ensure your distro supports virtual terminals (almost all do)

---

# ✅ Conclusion

In this lab, you have:

✔ Logged into a Linux system locally  
✔ Switched between virtual terminals  
✔ Verified active sessions using `who` and `tty`  

These skills are foundational for Linux administration and troubleshooting.

---

# 🚀 Next Steps

- Practice remote login using **SSH**
- Explore basic commands:
  - `ls`
  - `pwd`
  - `cd`
- Continue to the next RHCSA Rapid Track lab

---

## 🎉 Lab Complete!
