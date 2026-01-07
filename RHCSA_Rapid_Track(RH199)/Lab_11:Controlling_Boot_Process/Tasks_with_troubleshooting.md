
## Task 1: View systemd Services and Targets

### Subtask 1.1: Understanding systemd Basics

systemd manages services and the Linux boot process.

**Step 1: Check systemd version**

```bash
systemctl --version
```

**Step 2: View system status**

```bash
systemctl status
```

This displays:

* System uptime
* Loaded services
* Current system state
* Recent log entries

---

### Subtask 1.2: Exploring systemd Services

**Step 3: List active services**

```bash
systemctl list-units --type=service --state=active
```

**Step 4: List all services**

```bash
systemctl list-units --type=service --all
```

**Step 5: Check SSH service status**

```bash
systemctl status sshd
```

**Step 6: View detailed service properties**

```bash
systemctl show sshd
```

---

### Subtask 1.3: Working with systemd Targets

Targets define system states (replacement of runlevels).

**Step 7: List available targets**

```bash
systemctl list-units --type=target
```

**Step 8: Check default target**

```bash
systemctl get-default
```

**Step 9: View dependencies of current target**

```bash
systemctl list-dependencies
```

**Step 10: View graphical target dependencies**

```bash
systemctl list-dependencies graphical.target
```

---

### Subtask 1.4: Managing Service States

**Step 11: Start and stop a service (chronyd)**

```bash
systemctl status chronyd
sudo systemctl stop chronyd
systemctl status chronyd
sudo systemctl start chronyd
systemctl status chronyd
```

**Step 12: Enable and disable services at boot**

```bash
systemctl is-enabled chronyd
sudo systemctl disable chronyd
sudo systemctl enable chronyd
```

---

## Task 2: Modify Boot Parameters with GRUB2

### Subtask 2.1: Understanding GRUB2 Configuration

**Step 13: View GRUB default configuration**

```bash
sudo cat /etc/default/grub
```

**Step 14: View generated GRUB configuration**

```bash
sudo cat /boot/grub2/grub.cfg | head -50
```

---

### Subtask 2.2: Temporarily Modifying Boot Parameters

**Step 15: Modify boot parameters at startup**

1. Reboot the system

```bash
sudo reboot
```

2. At GRUB menu, press any key
3. Select kernel and press **e**
4. Find the `linux` line
5. Append:

```
systemd.unit=multi-user.target
```

6. Boot with **Ctrl + X**

**Step 16: Verify active target**

```bash
systemctl get-default
systemctl list-units --type=target --state=active
```

---

### Subtask 2.3: Permanently Modifying Boot Parameters

**Step 17: Backup and edit GRUB configuration**

```bash
sudo cp /etc/default/grub /etc/default/grub.backup
sudo nano /etc/default/grub
```

**Step 18: Modify GRUB_CMDLINE_LINUX**

```bash
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos/root rd.lvm.lv=centos/swap rhgb quiet"
```

**Step 19: Regenerate GRUB configuration**

BIOS systems:

```bash
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
```

UEFI systems:

```bash
sudo grub2-mkconfig -o /boot/efi/EFI/centos/grub.cfg
```

**Step 20: Set default target**

```bash
sudo systemctl set-default multi-user.target
systemctl get-default
```

---

## Task 3: Use Rescue Mode to Troubleshoot Boot Failures

### Subtask 3.1: Understanding Rescue Mode

**Step 21: Boot into rescue mode**

At GRUB menu:

* Press **e**
* Append:

```
systemd.unit=rescue.target
```

* Boot with **Ctrl + X**

**Step 22: Explore rescue mode**

```bash
systemctl list-units --type=target --state=active
systemctl list-units --type=service --state=active
df -h
journalctl -b
```

---

### Subtask 3.2: Simulating and Fixing Boot Problems

**Step 23: Create a simulated boot issue**

```bash
mount -o remount,rw /
cp /etc/fstab /etc/fstab.backup
echo "/dev/nonexistent /mnt/fake ext4 defaults 0 2" >> /etc/fstab
```

**Step 24: Attempt normal boot**

```bash
systemctl default
```

**Step 25: Fix the issue**

```bash
mount -o remount,rw /
sed -i '/nonexistent/d' /etc/fstab
cat /etc/fstab
# or restore backup
# cp /etc/fstab.backup /etc/fstab
```

---

### Subtask 3.3: Using Emergency Mode

**Step 26: Boot into emergency mode**

Append at GRUB:

```
systemd.unit=emergency.target
```

**Step 27: Explore emergency mode**

```bash
systemctl list-units --type=target --state=active
mount
mount -o remount,rw /
```

---

### Subtask 3.4: Password Recovery Scenario

**Step 28: Reset passwords from rescue mode**

```bash
mount -o remount,rw /
passwd root
useradd -m testuser
passwd testuser
usermod -aG wheel testuser
```

**Step 29: Return to normal mode**

```bash
systemctl set-default graphical.target
systemctl reboot
```

---

## Troubleshooting Tips

**Issue:** GRUB menu not visible
**Solution:** Set timeout

```bash
GRUB_TIMEOUT=5
```

**Issue:** GRUB edits not saved
**Solution:** Always run `grub2-mkconfig`

**Issue:** System fails to boot
**Solution:** Use rescue mode and restore backups

---

## Verification Commands

```bash
systemctl get-default
journalctl -b
systemctl status <service-name>
sudo cat /etc/default/grub
```

---

## Conclusion

In this lab, you gained hands-on experience with the Linux boot process.

### Key Accomplishments

* Managed systemd services and targets
* Controlled boot behavior using GRUB2
* Used rescue and emergency modes for recovery
* Simulated and fixed boot-time failures

### Why This Matters

These skills are critical for:

* System recovery and troubleshooting
* Server performance optimization
* Security hardening
* RHCSA and real-world Linux administration

You now have strong foundational skills to confidently manage and troubleshoot the Linux boot process.
