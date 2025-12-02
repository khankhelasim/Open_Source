# Lab 5: Linux File System Hierarchy

## 📌 **Overview**

This lab focuses on understanding the **Linux filesystem hierarchy**, navigating critical directories, exploring system paths, and working with symbolic and hard links. The structure of Linux directories is foundational for system administration, troubleshooting, and mastering Linux internals.

This **ready‑made README** is fully prepared for GitHub — no edits required.

---

## 🎯 **Objectives**

By the end of this lab, you will be able to:

* Understand the standard Linux filesystem hierarchy
* Navigate and explore directories using CLI
* Examine important system paths and configuration locations
* Create and identify symbolic and hard links
* Use tools like `ls`, `pwd`, `find`, and `locate`

---

## 🧰 **Prerequisites**

* A Linux system (RHEL, CentOS Stream, Fedora, Ubuntu, etc.)
* Basic command-line knowledge
* Standard user privileges (some commands may need `sudo`)

---

# 📝 **Lab Tasks**

## **Task 1: Exploring Key Directories**

### 🔹 **1.1: Explore the Root Directory `/`**

```bash
ls /
```

You will see directories such as:

* `/bin` — essential binaries
* `/etc` — system configuration
* `/home` — user home folders
* `/usr` — user applications
* `/var` — variable data
* `/tmp` — temporary files

---

### 🔹 **1.2: Explore `/bin` and `/sbin`**

```bash
ls /bin
ls /sbin
```

**Key Concepts**:

* `/bin` → commands for all users (`ls`, `cp`, `cat`, etc.)
* `/sbin` → admin-level system commands (`fdisk`, `reboot`, etc.)

---

### 🔹 **1.3: Explore `/etc` (System Configurations)**

```bash
ls /etc
less /etc/passwd
```

Press **q** to exit `less`.

---

### 🔹 **1.4: Working with `/home`**

```bash
cd ~
pwd
touch testfile.txt
```

Each user gets a personal directory inside `/home`.

---

### 🔹 **1.5: Explore `/usr`**

```bash
ls /usr
ls /usr/bin | wc -l
```

`/usr` contains system-wide applications, binaries, and libraries.

---

### 🔹 **1.6: Explore `/var`**

```bash
ls /var
sudo ls /var/log
```

`/var` holds logs, caches, spool files, and services’ runtime data.

---

### 🔹 **1.7: Explore `/tmp`**

```bash
cd /tmp
touch tempfile
```

Temporary files stored here may auto-delete after reboot.

---

## **Task 2: Navigating the Linux File System**

### 🔹 **2.1: Basic Navigation**

```bash
pwd
ls -l
cd ..
cd
```

---

### 🔹 **2.2: Finding Files**

Find all `.conf` files inside `/etc`:

```bash
find /etc -name "*.conf"
```

Locate files (if enabled):

```bash
locate passwd
```

If needed:

```bash
sudo updatedb
```

---

## **Task 3: Understanding Symbolic & Hard Links**

### 🔹 **3.1: List Symbolic Links in `/bin`**

```bash
ls -l /bin | grep '^l'
```

Files starting with `l` represent symlinks.

---

### 🔹 **3.2: Create a Symbolic Link**

```bash
touch original.txt
ln -s original.txt link_to_original
ls -l link_to_original
```

You will see:

```
link_to_original -> original.txt
```

---

### 🔹 **3.3: Create a Hard Link**

```bash
ln original.txt hardlink_to_original
ls -i original.txt hardlink_to_original
```

Both files share the **same inode** → true hard link.

---

## 🛠 Troubleshooting Tips

* Use `sudo` if you get **permission denied**.
* Verify command paths with:

```bash
which <command>
```

* Read manual pages:

```bash
man <command>
```

* Install tree (optional):

```bash
sudo apt install tree
# or
sudo yum install tree
```

---

## ✅ **Lab Completed**

You now understand:

* The Linux directory hierarchy
* Core system paths and their purposes
* Navigating and searching the filesystem
* Using symbolic & hard links effectively

These skills are essential for *system administration, troubleshooting, and RHCSA exam preparation*.

---


## 🚀 Next Steps

* Explore advanced permissions and ACLs
* Learn file system mounting and management
* Practice navigation in `/proc` and `/sys`

---

**End of Lab 5**
