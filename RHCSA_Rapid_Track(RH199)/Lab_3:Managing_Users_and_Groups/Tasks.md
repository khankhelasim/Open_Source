# Lab 3: Managing Users and Groups

## Task 1: Create User Accounts with `useradd`

### Subtask 1.1: Understanding User Account Basics

```bash
cat /etc/passwd | tail -5
whoami
sudo su -
```

---

### Subtask 1.2: Create Basic User Accounts

```bash
useradd john
grep john /etc/passwd
ls -la /home/
```

---

### Subtask 1.3: Create Users with Custom Options

```bash
useradd -d /home/custom_jane jane
useradd -s /bin/bash mike
useradd -c "Sarah Johnson" sarah
useradd -u 1500 tom
useradd -c "Alice Smith" -d /home/alice_home -s /bin/bash -u 1501 alice
```

---

### Subtask 1.4: Verify User Creation

```bash
grep -E "john|jane|mike|sarah|tom|alice" /etc/passwd
ls -la /home/
id john
id alice
```

---

## Task 2: Set Passwords and Modify User Details

### Subtask 2.1: Set User Passwords

```bash
passwd john
passwd jane
passwd mike
passwd sarah
```

---

### Subtask 2.2: Modify User Account Details

```bash
usermod -c "John Doe - Developer" john
usermod -d /home/john_new john
usermod -s /bin/zsh sarah
usermod -u 1502 mike
usermod -L tom
usermod -U tom
```

---

### Subtask 2.3: Verify User Modifications

```bash
grep -E "john|sarah|mike|tom" /etc/passwd
passwd -S john
passwd -S tom
su - john
exit
```

---

## Task 3: Create and Manage Groups

### Subtask 3.1: Create New Groups

```bash
groupadd developers
groupadd testers
groupadd managers
groupadd -g 2000 admins
groupadd -r sysops
```

---

### Subtask 3.2: Verify Group Creation

```bash
grep -E "developers|testers|managers|admins|sysops" /etc/group
getent group developers
getent group admins
```

---

### Subtask 3.3: Add Users to Groups

```bash
usermod -g developers john
usermod -G testers,managers jane
usermod -a -G developers,admins mike
gpasswd -a sarah developers
gpasswd -M alice,tom testers
```

---

### Subtask 3.4: Verify Group Memberships

```bash
groups john
groups jane
groups mike
getent group developers
getent group testers
getent group managers
id john
id jane
```

---

### Subtask 3.5: Modify Group Properties

```bash
groupmod -n development developers
groupmod -g 2001 admins
getent group development
getent group admins
```

---

## Task 4: Delete Users and Groups Securely

### Subtask 4.1: Remove Users from Groups

```bash
gpasswd -d tom testers
usermod -G "" alice
groups tom
groups alice
```

---

### Subtask 4.2: Delete User Accounts Safely

```bash
userdel tom
userdel -r alice
userdel -f mike
grep -E "tom|alice|mike" /etc/passwd
ls -la /home/
```

---

### Subtask 4.3: Delete Groups Safely

```bash
getent group testers
groupdel testers
groupdel development
gpasswd -d john development
gpasswd -d sarah development
groupdel development
getent group testers
getent group development
```

---

### Subtask 4.4: Clean Up Remaining Test Accounts

```bash
userdel -r john
userdel -r jane
userdel -r sarah
groupdel managers
groupdel admins
groupdel sysops
grep -E "john|jane|sarah|tom|alice|mike" /etc/passwd
grep -E "developers|testers|managers|admins|sysops" /etc/group
```

---

## Advanced User Management Concepts

### Understanding Key Files

```bash
head -5 /etc/passwd
head -5 /etc/group
sudo head -5 /etc/shadow
```

---

### User Account Security Best Practices

```bash
chage -M 90 username
chage -m 7 username
chage -W 7 username
chage -l username
chage -E 2024-12-31 username
usermod -L -e 1 username
```

---

## Troubleshooting Common Issues

### User Already Exists

```bash
getent passwd username
```

### Permission Denied

```bash
sudo su -
sudo useradd username
```

### Group Deletion Fails

```bash
usermod -g newgroup username
groupdel oldgroup
```

### Home Directory Issues

```bash
mkdir /home/username
chown username:username /home/username
chmod 755 /home/username
cp -r /etc/skel/. /home/username/
chown -R username:username /home/username
```

---

## Verification Commands Summary

```bash
cut -d: -f1 /etc/passwd | sort
cut -d: -f1 /etc/group | sort
id username
groups username
finger username
getent group groupname
passwd -S username
chage -l username
```

---

## Conclusion

In this lab, you learned how to manage users and groups in Linux systems. These skills are fundamental for system administration and essential for the RHCSA exam. Proper user and group management ensures system security, efficient access control, and reliable multi-user system operations.
