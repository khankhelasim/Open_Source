## Task 1: Perform Advanced Troubleshooting Using Logs and System Tools

### Subtask 1.1: Analyze System Logs with journalctl

1. Open a terminal session in your lab environment.
2. View the most recent system log entries:

   ```bash
   sudo journalctl -n 50
   ```
3. Filter logs by error priority:

   ```bash
   sudo journalctl -p err
   ```
4. View logs from the last two hours:

   ```bash
   sudo journalctl --since "2 hours ago"
   ```
5. Monitor logs in real time:

   ```bash
   sudo journalctl -f
   ```

   Press **Ctrl+C** to stop monitoring.

---

### Subtask 1.2: Examine Traditional Log Files

1. Navigate to the log directory:

   ```bash
   cd /var/log
   ls -la
   ```
2. Review recent system messages:

   ```bash
   sudo tail -50 /var/log/messages
   ```
3. Check authentication-related logs:

   ```bash
   sudo tail -30 /var/log/secure
   ```
4. Search for common error patterns:

   ```bash
   sudo grep -i "error\|fail\|critical" /var/log/messages | tail -20
   ```

---

### Subtask 1.3: Use System Diagnostic Tools

1. Monitor CPU and memory usage:

   ```bash
   top
   ```

   Press **q** to quit.
2. Check disk usage:

   ```bash
   df -h
   du -sh /var/log/*
   ```
3. Review system load and user activity:

   ```bash
   uptime
   w
   ```
4. Test network connectivity:

   ```bash
   ping -c 4 8.8.8.8
   netstat -tuln | head -20
   ```
5. Display hardware and memory information:

   ```bash
   lscpu
   free -h
   lsblk
   ```

---

## Task 2: Recover from System Failure Using systemd and Rescue Mode

### Subtask 2.1: Simulate a System Issue

1. Create a problematic systemd service:

   ```bash
   sudo tee /etc/systemd/system/problem-service.service > /dev/null << 'EOF'
   [Unit]
   Description=Problem Service for Testing
   After=network.target

   [Service]
   Type=simple
   ExecStart=/bin/bash -c "while true; do echo 'Service running'; sleep 30; done"
   ExecStop=/bin/bash -c "exit 1"
   Restart=always
   RestartSec=5

   [Install]
   WantedBy=multi-user.target
   EOF
   ```
2. Reload systemd and start the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable problem-service.service
   sudo systemctl start problem-service.service
   ```
3. Verify service status:

   ```bash
   sudo systemctl status problem-service.service
   ```

---

### Subtask 2.2: Access Rescue Mode

1. Switch to rescue mode:

   ```bash
   sudo systemctl rescue
   ```
2. Check active targets:

   ```bash
   systemctl get-default
   systemctl list-units --type=target
   ```
3. List active units in rescue mode:

   ```bash
   systemctl list-units --state=active
   ```

---

### Subtask 2.3: Diagnose Issues in Rescue Mode

1. Identify failed services:
   
<img width="1007" height="420" alt="Screenshot 2026-01-17 201612" src="https://github.com/user-attachments/assets/bad01e10-8ccb-4fe2-897c-b7bef94fd897" />

   ```bash
   systemctl --failed
   ```
3. Inspect the problematic service:

   ```bash
   systemctl status problem-service.service
   journalctl -u problem-service.service -n 20
   ```
4. Review rescue target dependencies:

   ```bash
   systemctl list-dependencies rescue.target
   ```

---

## Task 3: Restore System Services and Configurations

### Subtask 3.1: Fix Service Configuration Issues

1. Stop the faulty service:

   ```bash
   sudo systemctl stop problem-service.service
   ```
2. Update the service configuration:

   ```bash
   sudo tee /etc/systemd/system/problem-service.service > /dev/null << 'EOF'
   [Unit]
   Description=Fixed Problem Service
   After=network.target

   [Service]
   Type=simple
   ExecStart=/bin/bash -c "while true; do echo 'Service running properly'; sleep 30; done"
   ExecStop=/bin/kill -TERM $MAINPID
   Restart=on-failure
   RestartSec=5

   [Install]
   WantedBy=multi-user.target
   EOF
   ```
3. Reload systemd and start the service:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl start problem-service.service
   sudo systemctl status problem-service.service
   ```

---

### Subtask 3.2: Restore Normal Operation

1. Return to multi-user mode:

   ```bash
   sudo systemctl default
   ```
2. Verify essential services:

   ```bash
   systemctl list-units --type=service --state=active | grep -E "(ssh|network|systemd)"
   ```
3. Check for recent warnings:

   ```bash
   sudo journalctl -p warning --since "10 minutes ago"
   ```

---

### Subtask 3.3: Implement System Recovery Best Practices

1. Create a configuration backup script:

   ```bash
   sudo tee /usr/local/bin/backup-configs.sh > /dev/null << 'EOF'
   #!/bin/bash
   BACKUP_DIR="/var/backups/system-configs"
   DATE=$(date +%Y%m%d_%H%M%S)

   mkdir -p "$BACKUP_DIR"
   tar -czf "$BACKUP_DIR/system-configs-$DATE.tar.gz" \
       /etc/systemd/system/ \
       /etc/fstab \
       /etc/hosts \
       /etc/resolv.conf \
       /etc/ssh/sshd_config 2>/dev/null

   cd "$BACKUP_DIR"
   ls -t system-configs-*.tar.gz | tail -n +6 | xargs -r rm
   EOF
   ```
2. Make the script executable and test it:

   ```bash
   sudo chmod +x /usr/local/bin/backup-configs.sh
   sudo /usr/local/bin/backup-configs.sh
   ```
3. Create and enable a systemd timer for daily backups.

---

### Subtask 3.4: Verify System Recovery

1. Confirm critical services:

   ```bash
   sudo systemctl status sshd
   sudo systemctl status NetworkManager
   sudo systemctl status problem-service.service
   ```
2. Verify system health:

   ```bash
   sudo journalctl -p err --since "30 minutes ago"
   ping -c 3 google.com
   df -h
   ```
3. Document the recovery process in `/var/log`.
```bash
sudo tee /var/log/recovery-log-$(date +%Y%m%d).txt > /dev/null << EOF
System Recovery Log - $(date)
================================

Issues Identified:
- Problematic service configuration causing restart loops
- Service dependencies not properly configured

Actions Taken:
1. Accessed rescue mode for safe troubleshooting
2. Identified failed service using systemctl --failed
3. Fixed service configuration file
4. Reloaded systemd daemon
5. Restored system to normal operation
6. Implemented backup procedures

System Status: RECOVERED
All critical services operational
Backup procedures implemented

Recovery completed by: $(whoami)
EOF
```
---
