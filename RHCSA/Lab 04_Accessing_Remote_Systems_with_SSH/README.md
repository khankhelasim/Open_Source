# 🧪 Lab 4: Accessing Remote Systems with SSH

## 🎯 Objectives
By the end of this lab, you will be able to:
- Understand the fundamentals of SSH (Secure Shell) for remote system access.
- Configure and establish an SSH connection to a remote server.
- Implement key-based authentication for secure logins.
- Transfer files securely between systems using `scp` (Secure Copy Protocol).

---

## 🧩 Prerequisites
- Local Linux system (Ubuntu, CentOS, Fedora)
- Remote Linux server accessible via SSH
- Basic Linux command-line knowledge

### Required Packages
- **Local machine:** `openssh-client`
- **Remote machine:** `openssh-server`

---

## 🧱 Task 1: Set Up and Connect to a Remote System Using SSH

### 🔹 Subtask 1.1: Verify SSH Installation

Check if SSH client is installed:
```bash
ssh -V
```
Outcome: Displays SSH version (e.g., OpenSSH_8.9p1).

If not installed:

Ubuntu/Debian
```bash
sudo apt update && sudo apt install openssh-client -y
```
CentOS/RHEL/Fedora
```bash
sudo dnf install openssh-clients -y
```

Check SSH server status on remote system:
```bash
sudo systemctl status sshd
```

If inactive, start and enable it:
```bash
sudo systemctl start sshd && sudo systemctl enable sshd
```
### 🔹 Subtask 1.2: Connect to the Remote Server

Connect to your remote machine:
```bash
ssh username@remote_server_ip
```

Replace:

username → your remote user

remote_server_ip → your remote system’s IP

Expected Outcome:

You will be prompted for the user’s password.

After authentication, you should see the remote system prompt.

## 🧮 Task 2: Implement SSH Key-Based Authentication
### 🔹 Subtask 2.1: Generate SSH Key Pair

Generate SSH key pair on your local machine:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Explanation:

-t ed25519: Uses modern Ed25519 encryption algorithm.

-C: Adds a comment (optional).

Press Enter to save to default location (~/.ssh/id_ed25519).

Outcome:

Two files are created:

Private key → ~/.ssh/id_ed25519

Public key → ~/.ssh/id_ed25519.pub

### 🔹 Subtask 2.2: Copy the Public Key to Remote Server

Use the following command:
```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub username@remote_server_ip
```

Outcome:

The public key is added to the remote file ~/.ssh/authorized_keys.

Now, log in using SSH again:
```bash
ssh username@remote_server_ip
```

Expected Result:

You should log in without entering a password.

## 📦 Task 3: Securely Transfer Files Using scp
### 🔹 Subtask 3.1: Copy a File from Local to Remote
```bash
scp localfile.txt username@remote_server_ip:/remote/directory/
```

Outcome:

localfile.txt is securely copied to the specified directory on the remote server.

### 🔹 Subtask 3.2: Copy a File from Remote to Local
```bash
scp username@remote_server_ip:/remote/directory/remotefile.txt ~/local/directory/
```

Outcome:

remotefile.txt is downloaded from the remote server to your local machine.

🧩 Troubleshooting Tips

Problem	Possible Fix

Permission denied (publickey)	Re-run ssh-copy-id or manually append your public key to ~/.ssh/authorized_keys.

Connection refused	Ensure SSH service is running: sudo systemctl start sshd.

Permission issues	Set correct permissions: chmod 700 ~/.ssh and chmod 600 ~/.ssh/authorized_keys.

🏁 Conclusion

You have successfully:

✅ Established SSH connections to a remote server.

✅ Configured secure, passwordless authentication.

✅ Transferred files securely using scp.

These skills are fundamental for remote administration in DevOps, cloud, and containerized environments such as Red Hat OpenShift or AWS EC2.
