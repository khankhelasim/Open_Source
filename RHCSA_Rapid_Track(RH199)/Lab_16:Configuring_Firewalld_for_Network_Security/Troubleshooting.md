## Troubleshooting

### Firewalld Not Starting

```bash
sudo systemctl status iptables
sudo systemctl stop iptables
sudo systemctl disable iptables
sudo systemctl restart firewalld
```

### Rules Not Applying

```bash
sudo firewall-cmd --reload
sudo firewall-cmd --list-all --permanent
```

### Cannot Access Services

```bash
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --list-services
sudo firewall-cmd --get-active-zones
```

### Zone Issues

```bash
sudo firewall-cmd --get-zones
sudo firewall-cmd --zone=ZONENAME --list-all
sudo firewall-cmd --reload
```

---

## Verification & Testing

```bash
sudo systemctl status firewalld
sudo firewall-cmd --state
sudo firewall-cmd --list-all
sudo firewall-cmd --zone=ZONENAME --list-all
sudo firewall-cmd --list-rich-rules
sudo firewall-cmd --get-active-zones
nmap -p PORT localhost
telnet localhost PORT
```

---
