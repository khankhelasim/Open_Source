# Lab 8: Managing Password Policies in Linux

## 🔐 Overview

This lab focuses on configuring **password policies**, enforcing **password complexity**, setting **password aging**, and securing user accounts on a Linux system. These practices are essential for maintaining system security and meeting compliance standards.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Configure password complexity rules using **libpwquality**
* Set password expiration and aging policies
* Enforce global password requirements
* Lock inactive accounts
* Test password policy effectiveness using local users

---

## 🧰 Prerequisites

* Linux system (RHEL/CentOS 8+, Fedora, Ubuntu)
* Root or sudo privileges
* Basic Linux CLI knowledge
* `passwd`, `chage`, and `libpwquality` installed (default)

---

# 📝 Lab Tasks

## Task 1: Configure Password Expiration & Complexity

### 🔹 1.1 Install Required Packages

```
sudo dnf install libpwquality -y
```

**Explanation:** Installs tools required for enforcing password complexity.

---

### 🔹 1.2 Configure Password Complexity

Edit the configuration file:

```
sudo nano /etc/security/pwquality.conf
```

Add or modify these settings:

```
minlen = 12
minclass = 4
dcredit = -1
ucredit = -1
lcredit = -1
ocredit = -1
```

**Meaning:** These enforce strong passwords with at least 12 characters and all character classes (upper, lower, digits, special).

---

### 🔹 1.3 Verify Configuration

```
echo "Weakpass1" | sudo pwscore
echo "StrongPass123!" | sudo pwscore
```

**Expected:** Weak passwords score low; strong passwords score high.

---

## Task 2: Set Password Aging & Enforcement

### 🔹 2.1 Configure Global Password Aging

Edit:

```
sudo nano /etc/login.defs
```

Set:

```
PASS_MAX_DAYS  90
PASS_MIN_DAYS  7
PASS_WARN_AGE  14
PASS_MIN_LEN   12
```

**Explanation:** Passwords expire every 90 days, cannot be changed before 7 days, and warn 14 days before expiration.

---

### 🔹 2.2 Apply Policies to Users

```
sudo chage -M 90 -m 7 -W 14 testuser1
sudo chage -M 90 -m 7 -W 14 testuser2
```

Verify:

```
sudo chage -l testuser1
```

---

### 🔹 2.3 Lock Inactive Accounts

Lock accounts inactive for 30 days:

```
sudo useradd -D -f 30
```

---

## Task 3: Test Password Policies

### 🔹 3.1 Test Password Complexity

```
sudo passwd testuser1
```

Try:

* `password123` → **Should fail**
* `SecurePass123!` → **Should pass**

---

### 🔹 3.2 Test Password Aging

Check expiration:

```
sudo chage -l testuser1
```

Force change on next login:

```
sudo chage -d 0 testuser1
```

---

### 🔹 3.3 Test Account Locking

Simulate inactivity:

```
sudo chage -I 30 -E $(date -d "+30 days" +%Y-%m-%d) testuser2
```

Verify:

```
sudo chage -l testuser2
```

---

# 🛠 Troubleshooting Tips

### 🔍 Password rules not applied?

* Check PAM config:

```
sudo cat /etc/pam.d/system-auth
```

Ensure this line exists:

```
password requisite pam_pwquality.so retry=3
```

### 🔍 Complexity issues?

* Verify `pwquality.conf` syntax
* Ensure libpwquality installed:

```
rpm -qa | grep pwquality
```

### 🔍 Account locking issues?

Check logs:

```
sudo tail -f /var/log/secure
```

---

# ✅ Conclusion

In this lab, you learned how to:

* Configure password complexity using `libpwquality`
* Apply password aging and expiration rules
* Lock inactive accounts
* Test password policies effectively

These practices significantly improve Linux system security and align with RHCSA and enterprise standards.

---

# 🧹 Cleanup (Optional)

```
sudo userdel -r testuser1
sudo userdel -r testuser2
```

---

**End of Lab 8**
