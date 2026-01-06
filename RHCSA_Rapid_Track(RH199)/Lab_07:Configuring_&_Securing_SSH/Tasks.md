# Lab 7: Configuring and Securing SSH

## Task 1: Install and Configure OpenSSH Server

### Subtask 1.1: Check Current SSH Status

```bash
rpm -qa | grep openssh-server
systemctl status sshd
```

If not installed:

```bash
sudo dnf install openssh-server -y
```

---

### Subtask 1.2: Start and Enable SSH Service

```bash
sudo systemctl start sshd
sudo systemctl enable sshd
sudo systemctl status sshd
```

---

### Subtask 1.3: Configure SSH Server Settings

Backup configuration:

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
```

Edit configuration:

```bash
sudo nano /etc/ssh/sshd_config
```

Recommended settings:

```text
Port 22
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication yes
PermitEmptyPasswords no
MaxAuthTries 3
ClientAliveInterval 300
ClientAliveCountMax 2
```

Test and restart:

```bash
sudo sshd -t
sudo systemctl restart sshd
```

---

### Subtask 1.4: Configure Firewall for SSH

```bash
sudo firewall-cmd --state
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --reload
sudo firewall-cmd --list-services
```

---

## Task 2: Test SSH Connection Locally and Remotely

### Subtask 2.1: Test Local SSH Connection

```bash
sudo useradd testuser
sudo passwd testuser
ssh testuser@localhost
whoami
hostname
exit
```

---

### Subtask 2.2: Test Remote SSH Connection

```bash
ip addr show
ssh testuser@YOUR_IP_ADDRESS
ssh -v testuser@YOUR_IP_ADDRESS
```

---

### Subtask 2.3: Monitor SSH Connections

```bash
sudo ss -tuln | grep :22
sudo journalctl -u sshd -f
sudo tail -f /var/log/secure
```

---

## Task 3: Set Up Key-Based Authentication

### Subtask 3.1: Generate SSH Key Pair

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
ls -la ~/.ssh/
cat ~/.ssh/id_rsa.pub
```

---

### Subtask 3.2: Copy Public Key to Server

```bash
ssh-copy-id testuser@YOUR_IP_ADDRESS
```

Manual method:

```bash
cat ~/.ssh/id_rsa.pub | ssh testuser@YOUR_IP_ADDRESS "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
ssh testuser@YOUR_IP_ADDRESS "chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
```

---

### Subtask 3.3: Test Key-Based Authentication

```bash
ssh testuser@YOUR_IP_ADDRESS
sudo journalctl -u sshd | grep "Accepted publickey"
```

---

### Subtask 3.4: Disable Password Authentication

```bash
sudo nano /etc/ssh/sshd_config
```

Change:

```text
PasswordAuthentication no
```

Restart:

```bash
sudo sshd -t
sudo systemctl restart sshd
```

---

### Subtask 3.5: Advanced SSH Security Configuration

```text
Protocol 2
AllowUsers testuser
X11Forwarding no
AllowAgentForwarding no
AllowTcpForwarding no
Ciphers aes256-ctr,aes192-ctr,aes128-ctr
MACs hmac-sha2-256,hmac-sha2-512
LoginGraceTime 30
```

Restart SSH:

```bash
sudo systemctl restart sshd
```

## Verification Commands

```bash
sudo systemctl status sshd
sudo sshd -t
sudo ss -tuln | grep :22
sudo journalctl -u sshd -n 10
ssh -T testuser@localhost
```

---

## Conclusion

In this lab, you successfully:

* Installed and configured OpenSSH server securely
* Tested SSH access locally and remotely
* Implemented key-based authentication
* Applied SSH security best practices
* Hardened SSH using strong ciphers and access controls

**Why This Matters:** Secure SSH configuration is critical for protecting Linux systems from unauthorized access and is a core skill for system administrators and RHCSA candidates.

**Next Steps:** Explore SSH tunneling, port forwarding, and tools like `fail2ban` for intrusion prevention.
