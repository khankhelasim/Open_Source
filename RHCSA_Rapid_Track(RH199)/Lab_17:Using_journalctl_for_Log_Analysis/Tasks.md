## Task 1: View Logs with journalctl

### Subtask 1.1: Understanding the systemd Journal

The systemd journal is a centralized logging system that collects and stores log data from the kernel, system services, applications, and user sessions.

```bash
sudo su -
```

```bash
journalctl --help | head -20
```

```bash
journalctl
```

(Press **q** to quit)

---

### Subtask 1.2: Basic Log Viewing Commands

```bash
journalctl -n
journalctl -n 20
journalctl -f
journalctl -r
journalctl --no-pager -n 5
```

---

### Subtask 1.3: Output Formats

```bash
journalctl -o json -n 3
journalctl -o verbose -n 2
journalctl -o short -n 5
```

---

## Task 2: Filter Logs

### Subtask 2.1: Time-Based Filtering

```bash
journalctl --since today
journalctl --since yesterday --until today
journalctl --since "1 hour ago"
journalctl --since "30 minutes ago"
journalctl --since "2024-01-01 00:00:00" --until "2024-01-01 23:59:59"
```

---

### Subtask 2.2: Priority-Based Filtering

| Priority | Meaning |
| -------- | ------- |
| 0        | emerg   |
| 1        | alert   |
| 2        | crit    |
| 3        | err     |
| 4        | warning |
| 5        | notice  |
| 6        | info    |
| 7        | debug   |

```bash
journalctl -p err
journalctl -p warning
journalctl -p crit
```

Generate test logs:

```bash
logger -p user.err "This is a test error message"
logger -p user.warning "This is a test warning message"
logger -p user.info "This is a test info message"
```

Verify:

```bash
journalctl -p info --since "1 minute ago" | grep test
```

---

### Subtask 2.3: Unit-Based Filtering

```bash
journalctl -F _SYSTEMD_UNIT | head
journalctl -u sshd
journalctl -u NetworkManager
journalctl -u sshd -u NetworkManager --since today
journalctl -k
```

PID-based filtering:

```bash
ps aux | grep systemd | head -1
journalctl _PID=1 -n 5
```

---

### Subtask 2.4: Combining Filters

```bash
journalctl -u sshd -p err --since today
journalctl -p warning --since "2 hours ago"
journalctl -u NetworkManager -p info --since yesterday --until today
```

---

## Task 3: Persistent Journal Storage

### Subtask 3.1: Check Current Configuration

```bash
journalctl --disk-usage
cat /etc/systemd/journald.conf
ls -la /var/log/journal/
```

---

### Subtask 3.2: Enable Persistent Storage

```bash
mkdir -p /var/log/journal
chown root:systemd-journal /var/log/journal
chmod 2755 /var/log/journal
```

```bash
cp /etc/systemd/journald.conf /etc/systemd/journald.conf.backup
```

```ini
[Journal]
Storage=persistent
Compress=yes
SystemMaxUse=500M
SystemKeepFree=1G
SystemMaxFileSize=50M
MaxRetentionSec=1month
ForwardToWall=yes
```

```bash
systemctl restart systemd-journald
systemctl status systemd-journald
```

---

### Subtask 3.3: Verify Persistence

```bash
ls -la /var/log/journal/
journalctl --disk-usage
```

```bash
for i in {1..10}; do logger "Test persistent log entry $i"; done
journalctl --since "1 minute ago" | grep "Test persistent"
```

---

### Subtask 3.4: Managing Journal Storage

```bash
journalctl --verify
journalctl --vacuum-time=2d
journalctl --vacuum-size=100M
journalctl --vacuum-files=50
```

---

## Task 4: Advanced Filtering and Analysis

### Subtask 4.1: Advanced Queries

```bash
journalctl -g error
journalctl _UID=0 -n 10
journalctl --list-boots
journalctl -b 0
journalctl -b -1
journalctl --since today -o json > /tmp/today_logs.json
```

---

### Subtask 4.2: Monitoring Script

```bash
#!/bin/bash
LOGFILE="/var/log/critical_alerts.log"
CRITICAL_COUNT=$(journalctl -p crit --since "5 minutes ago" --no-pager | wc -l)

if [ "$CRITICAL_COUNT" -gt 0 ]; then
  echo "$(date): $CRITICAL_COUNT critical errors detected" >> "$LOGFILE"
  journalctl -p crit --since "5 minutes ago" --no-pager >> "$LOGFILE"
fi
```

Test:

```bash
logger -p user.crit "Test critical error for monitoring"
```

---

## Verification

```bash
systemctl status systemd-journald
ls -la /var/log/journal/
journalctl --disk-usage
journalctl -p warning --since "1 hour ago" -n 5
```
