# Lab 7: Creating and Editing Text Files

## 🎯 Objectives
- Master basic file editing using **nano** and **vi**
- Perform insert, delete, navigation, and save operations  
- Understand newline formats (LF vs CRLF)  
- Use essential file manipulation commands  

---

## 🧰 Prerequisites
- Linux system (RHEL / CentOS / Fedora recommended)
- Terminal access with a normal user account
- Basic command line navigation skills

---

# 🧪 Lab Tasks

## **Task 1: Creating and Editing Files with nano**

### ▶ Subtask 1.1: Launch nano and create a file
```bash
nano first_file.txt
```
### ▶ Subtask 1.2: Perform editing

Type:

Hello OpenShift!

This is my first text file.


Save and exit:

Ctrl + O → Save

Enter → Confirm filename

Ctrl + X → Exit

📌 Outcome: first_file.txt created with sample content.

## Task 2: Advanced Editing with vi
### ▶ Subtask 2.1: Open file and understand modes
```bash
vi second_file.txt
```

Modes:

Command mode (default)

Insert mode → press i

Visual mode → press v

### ▶ Subtask 2.2: Edit the file

Enter insert mode and type:

Podman Container Basics:

1. Images

2. Containers

3. Pods


Return to command mode:

Esc

Delete line 2:

dd


Save & exit:

:wq

## Task 3: File Manipulation Commands

### ▶ Viewing files
```bash
cat first_file.txt
less second_file.txt   # Press q to quit
```
### ▶ Check file encoding
```bash
file first_file.txt
```
### ▶ Convert line endings (LF ↔ CRLF)
```bash
unix2dos first_file.txt
dos2unix first_file.txt
```

📌 Unix uses LF, Windows uses CRLF

## Task 4: Practical Application

### ▶ Create a Podman config snippet
```bash
nano podman_config.conf
```

Add:
```bash
[storage]
driver = "overlay"
runroot = "/var/run/containers/storage"
graphroot = "/var/lib/containers/storage"
```
### ▶ Validate the file
```bash
grep -n '[[:space:]]$' podman_config.conf
wc -l podman_config.conf
```
✅ Conclusion

You have successfully:

Created and edited files using nano and vi

Used essential editing commands

Understood file encoding differences

Created a real configuration file example

🔍 Verification
```bash
ls -l *.txt *.conf
file *
```
