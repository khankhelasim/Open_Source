### Monitoring Script

```bash
sudo tee /usr/local/bin/selinux-monitor.sh << 'EOF'
#!/bin/bash
echo "=== SELinux Status ==="
sestatus

echo -e "\n=== Recent SELinux Denials ==="
ausearch -m avc -ts today 2>/dev/null | tail -10

echo -e "\n=== Enabled SELinux Booleans ==="
getsebool -a | grep "on$" | wc -l

semanage fcontext -l -C
EOF

sudo chmod +x /usr/local/bin/selinux-monitor.sh
sudo /usr/local/bin/selinux-monitor.sh
```

```bash
echo "0 */6 * * * root /usr/local/bin/selinux-monitor.sh >> /var/log/selinux-monitor.log 2>&1" | sudo tee -a /etc/crontab
```

---
