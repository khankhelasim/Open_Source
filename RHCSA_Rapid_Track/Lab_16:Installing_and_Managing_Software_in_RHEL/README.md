# Lab 16: Installing and Managing Software in RHEL

## 📌 Overview

This lab focuses on **software management in RHEL-based systems** using `dnf` and `yum`. You will learn how to install, update, remove packages, configure additional repositories, and handle package dependencies — all essential skills for **RHCSA exam preparation and real-world system administration**.


---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Install software packages using `dnf` / `yum`
* Update and remove installed packages safely
* Enable and manage software repositories
* Understand and resolve package dependencies

---

## 🧰 Prerequisites

* RHEL 8/9 system (or Rocky / CentOS Stream)
* Root or `sudo` privileges
* Active internet connection
* Basic Linux command-line knowledge

---

# 📝 Lab Tasks

## **Task 1: Installing Packages with yum or dnf**

### 🔹 **1.1: Verify Package Managers**

RHEL 8+ uses **dnf** by default (yum is a symlink).

```bash
which dnf yum
```

Expected Output:

```
/usr/bin/dnf
/usr/bin/yum
```

Check version:

```bash
dnf --version
```

---

### 🔹 **1.2: Install a Package**

Install the `htop` system monitoring tool:

```bash
sudo dnf install htop -y
```

**Expected Outcome**:

* Package installed successfully
* Dependencies resolved automatically

🔧 **Troubleshooting**:

```bash
ping google.com
sudo dnf repolist
```

---

## **Task 2: Updating and Removing Packages**

### 🔹 **2.1: Update All Packages**

```bash
sudo dnf update -y
```

**Expected Outcome**:

* System packages updated
* Security patches applied

---

### 🔹 **2.2: Remove a Package**

Remove `htop`:

```bash
sudo dnf remove htop -y
```

🔑 **Key Concept**:

```bash
sudo dnf autoremove
```

Removes unused dependencies.

---

## **Task 3: Repository Configuration & Dependency Management**

### 🔹 **3.1: List Enabled Repositories**

```bash
sudo dnf repolist
```

Expected repositories:

* BaseOS
* AppStream

---

### 🔹 **3.2: Enable EPEL Repository**

EPEL provides additional open-source packages.

```bash
sudo dnf install epel-release -y
```

Verify:

```bash
sudo dnf repolist | grep epel
```

---

### 🔹 **3.3: Install a Package with Dependencies**

Install **nginx**:

```bash
sudo dnf install nginx -y
```

**Expected Outcome**:

* Dependencies automatically resolved
* nginx installed successfully

🔧 **If issues occur**:

```bash
sudo dnf clean all
sudo dnf install nginx -y
```

---

## 🛠 Troubleshooting Tips

* Check enabled repos:

```bash
sudo dnf repolist
```

* Inspect transaction history:

```bash
sudo dnf history
```

* Query installed packages:

```bash
rpm -qa | grep nginx
```

---

## ✅ Lab Completed

You have successfully:

* Installed, updated, and removed software using `dnf`
* Configured additional repositories (EPEL)
* Understood dependency resolution in RHEL

These skills are **core RHCSA objectives** and critical for production Linux environments.

---

## 📂 Verification Command

```bash
dnf list installed | grep -E 'nginx|htop'
```

---

## 🚀 Next Steps

* Explore `dnf history undo`
* Practice low-level RPM queries (`rpm -qi`, `rpm -ql`)
* Automate package installation with Bash or Ansible

---

**End of Lab 16 🎉**
