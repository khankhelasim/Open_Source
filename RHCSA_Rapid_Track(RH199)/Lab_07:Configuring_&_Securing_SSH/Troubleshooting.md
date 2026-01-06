## Troubleshooting Guide

### Issue 1: Connection Refused

**Cause:** SSH service not running or firewall blocking access

**Fix:**

```bash
sudo systemctl status sshd
sudo systemctl start sshd
sudo firewall-cmd --list-services
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
```

---

### Issue 2: Permission Denied (Publickey)

**Cause:** Incorrect permissions on `.ssh` or `authorized_keys`

**Fix:**

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

Verify ownership:

```bash
ls -ld ~/.ssh ~/.ssh/authorized_keys
```

---

### Issue 3: SSH Key Authentication Not Working

**Cause:** Key not copied correctly or wrong user

**Fix:**

```bash
ssh-copy-id testuser@SERVER_IP
ssh -v testuser@SERVER_IP
```

Check logs:

```bash
sudo journalctl -u sshd -n 20
```

---

### Issue 4: SELinux Blocking SSH Keys

**Cause:** Incorrect SELinux context on `.ssh` directory

**Fix:**

```bash
restorecon -R ~/.ssh/
```

---

### Issue 5: Locked Out After Disabling Password Authentication

**Cause:** Password auth disabled before confirming key access

**Fix:**

* Always keep one SSH session open
* Re-enable password auth temporarily if needed:

```bash
PasswordAuthentication yes
```

Restart service:

```bash
sudo systemctl restart sshd
```

---

## Verification Checklist

* SSH service is active and enabled
* Firewall allows SSH traffic
* Root login is disabled
* Password authentication is disabled
* Key-based authentication works
* Logs show `Accepted publickey`

Verification commands:

```bash
sudo systemctl status sshd
sudo sshd -t
sudo ss -tuln | grep :22
ssh testuser@localhost
```

---

## Conclusion

In this lab, you successfully installed, configured, and secured SSH on a Linux system. You implemented industry-standard security practices such as disabling root login, enforcing key-based authentication, and hardening cryptographic settings.

These skills are essential for:

* Secure remote system administration
* Enterprise Linux environments
* RHCSA certification preparation

You now have a production-ready understanding of SSH configuration and security.
