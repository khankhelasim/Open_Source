## Task 1: Automating Tasks with Cron

### Task 1.1: Exploring the Cron System

```bash
sudo systemctl status crond
sudo systemctl start crond
sudo systemctl enable crond
crontab -l
ls -la /etc/cron*
cat /etc/crontab
```

---

### Task 1.2: Understanding Cron Syntax

```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0–7)
│ │ │ └──── Month (1–12)
│ │ └────── Day of month (1–31)
│ └──────── Hour (0–23)
└────────── Minute (0–59)
```

Examples:

* `*/15 * * * *` – Every 15 minutes
* `0 2 * * *` – Daily at 2 AM
* `0 9 * * 1-5` – Weekdays at 9 AM

---

### Task 1.3: Creating a System Info Cron Job

```bash
mkdir -p ~/scripts
nano ~/scripts/system_info.sh
```

```bash
#!/bin/bash
echo "=== System Information Report ===" >> ~/system_reports.log
date >> ~/system_reports.log
uptime >> ~/system_reports.log
df -h >> ~/system_reports.log
free -h >> ~/system_reports.log
echo "===============================" >> ~/system_reports.log
```

```bash
chmod +x ~/scripts/system_info.sh
~/scripts/system_info.sh
crontab -e
```

```cron
*/5 * * * * /home/$(whoami)/scripts/system_info.sh
```

---

### Task 1.4: Daily Backup Cron Job

```bash
nano ~/scripts/daily_backup.sh
```

```bash
#!/bin/bash
BACKUP_DIR="/tmp/backups"
DATE=$(date +%F_%H%M)
mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/home_backup_$DATE.tar.gz ~/scripts ~/system_reports.log
find $BACKUP_DIR -mtime +7 -delete
echo "Backup completed at $(date)" >> ~/backup.log
```

```bash
chmod +x ~/scripts/daily_backup.sh
crontab -e
```

```cron
30 2 * * * /home/$(whoami)/scripts/daily_backup.sh
```

---

### Task 1.5: Cron Logging and Monitoring

```bash
nano ~/scripts/log_monitor.sh
```

```bash
#!/bin/bash
echo "Log monitor executed at $(date)" >> ~/cron_monitor.log
```

```bash
chmod +x ~/scripts/log_monitor.sh
crontab -e
```

```cron
*/10 * * * * /home/$(whoami)/scripts/log_monitor.sh
```

---

## Task 2: Automating Tasks with systemd Timers

### Task 2.1: Inspect Existing Timers

```bash
systemctl list-timers
ls /etc/systemd/system/*.timer
```

---

### Task 2.2: Creating a systemd Service

```bash
sudo nano /etc/systemd/system/system-status.service
```

```ini
[Unit]
Description=System Status Service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/system-status.sh
```

```bash
sudo nano /usr/local/bin/system-status.sh
```

```bash
#!/bin/bash
echo "System status at $(date)" >> /var/log/system-status.log
uptime >> /var/log/system-status.log
```

```bash
sudo chmod +x /usr/local/bin/system-status.sh
```

---

### Task 2.3: Creating a systemd Timer

```bash
sudo nano /etc/systemd/system/system-status.timer
```

```ini
[Unit]
Description=Run system status every 15 minutes

[Timer]
OnCalendar=*:0/15
Persistent=true

[Install]
WantedBy=timers.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now system-status.timer
systemctl list-timers
```

---

### Task 2.4: Weekly Cleanup Timer

```bash
sudo nano /usr/local/bin/temp-cleanup.sh
```

```bash
#!/bin/bash
find /tmp -type f -mtime +7 -delete
echo "Cleanup completed at $(date)" >> /var/log/temp-cleanup.log
```

```bash
sudo chmod +x /usr/local/bin/temp-cleanup.sh
```

```bash
sudo nano /etc/systemd/system/temp-cleanup.service
```

```ini
[Service]
Type=oneshot
ExecStart=/usr/local/bin/temp-cleanup.sh
```

```bash
sudo nano /etc/systemd/system/temp-cleanup.timer
```

```ini
[Timer]
OnCalendar=weekly
Persistent=true
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now temp-cleanup.timer
```

---

### Task 2.5: User-Level systemd Timer

```bash
mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/personal-backup.service
```

```ini
[Service]
Type=oneshot
ExecStart=%h/scripts/personal-backup.sh
```

```bash
nano ~/.config/systemd/user/personal-backup.timer
```

```ini
[Timer]
OnCalendar=daily
Persistent=true
```

```bash
systemctl --user daemon-reload
systemctl --user enable --now personal-backup.timer
systemctl --user list-timers
```

---

## Task 3: Testing and Verification

### Cron Verification

```bash
journalctl -u crond
cat ~/system_reports.log
cat ~/backup.log
```

### systemd Verification

```bash
systemctl status system-status.timer
journalctl -u system-status.service
cat /var/log/system-status.log
```

---

## Troubleshooting

### Cron Issues

* Ensure crond is running
* Use absolute paths in scripts
* Make scripts executable
* Redirect output to logs

```bash
sudo systemctl status crond
sudo tail /var/log/cron
```

### systemd Timer Issues

```bash
sudo systemd-analyze verify your.timer
sudo journalctl -u your.service
```
