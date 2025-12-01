# RHCSA Rapid Track – Lab 2: Remote Login to Linux Systems

## 📘 Overview
This lab focuses on securely accessing a remote Linux system using **SSH**, generating secure **SSH key pairs**, configuring the SSH server, and establishing a secure, password-less connection. These skills are essential for system administration, automation, secure access, and DevOps workflows.

---

## 🎯 Objectives
By completing this lab, you will:

- Securely log in to a Linux system remotely using SSH.
- Generate and manage SSH key pairs.
- Configure SSH server settings for secure authentication.

---

## 🧰 Prerequisites

- Local system: Linux/macOS or Windows with WSL2/OpenSSH  
- Remote Linux machine with SSH server installed (Ubuntu, CentOS, RHEL, Fedora, etc.)  
- Terminal access on both systems  
- Basic command-line knowledge  

---

# 📝 Tasks

---

## **Task 1: Generate SSH Key Pair**

### 🔹 Subtask 1.1: Check for Existing SSH Keys
On your **local machine**, run:

```bash
ls ~/.ssh/
```
If you already see id_rsa and id_rsa.pub, a key pair exists.

### 🔹 Subtask 1.2: Generate a New Key Pair
```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Explanation:

-t rsa → Create an RSA key

-b 4096 → 4096-bit key for strong security

-C → Optional comment

Follow the prompts:

Press Enter to save in the default path: ~/.ssh/id_rsa

Enter a passphrase (recommended) or leave empty

Verify keys:

```bash
ls ~/.ssh/
```
Expected files:


id_rsa

id_rsa.pub

#### 💡 Troubleshooting
If ssh-keygen is missing:

```bash
sudo apt install openssh-client      # Debian/Ubuntu
sudo yum install openssh-clients     # CentOS/RHEL
```
## Task 2: Configure SSH Server on the Remote Machine
### 🔹 Subtask 2.1: Install SSH Server (if needed)
Log in to the remote system locally or via console, then install:
```bash
sudo apt install openssh-server      # Debian/Ubuntu
sudo yum install openssh-server      # CentOS/RHEL
```
Start and enable SSH:

```bash
sudo systemctl start sshd
sudo systemctl enable sshd
```
### 🔹 Subtask 2.2: Copy Public Key to Remote Machine
Using ssh-copy-id (recommended):

```bash
ssh-copy-id username@remote_server_ip
```
Enter the remote password once.

Alternative (manual method):

```bash
cat ~/.ssh/id_rsa.pub | ssh username@remote_server_ip "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```
### 🔹 Subtask 2.3: Secure SSH Server Configuration
Open SSH config on the remote machine:

```bash
sudo nano /etc/ssh/sshd_config
```
Recommend the following settings:

```bash
PasswordAuthentication no
PermitRootLogin no
PubkeyAuthentication yes
```
Restart SSH:
```bash
sudo systemctl restart sshd
```
#### 💡 Troubleshooting
Ensure password login is enabled temporarily if key setup fails

Allow SSH port:

```bash
sudo ufw allow 22
```
## Task 3: Log in Remotely Using SSH
### 🔹 Subtask 3.1: Test SSH Login
On the local machine:

```bash
ssh username@remote_server_ip
```
If a passphrase was set, you will be prompted.

Expected result:

You log in without a password.

### 🔹 Subtask 3.2: Verify Connection
Run:

```bash
whoami
hostname
```
You should see your username and the remote host’s name.

#### 💡 Troubleshooting
If key login fails:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```
Ensure the key exists in:

```bash
~/.ssh/authorized_keys
```
## ✅ Conclusion
In this lab, you successfully:

Generated secure SSH key pairs

Configured the SSH server for key-based authentication

Established a passwordless SSH login

These skills are essential for secure remote administration, automation, and DevOps workflows.

## 🚀 Next Steps
Use an SSH agent to manage key passphrases (ssh-agent)

Explore SSH port forwarding and tunneling

Continue with the next RHCSA Rapid Track lab

🎉 Lab Complete!
