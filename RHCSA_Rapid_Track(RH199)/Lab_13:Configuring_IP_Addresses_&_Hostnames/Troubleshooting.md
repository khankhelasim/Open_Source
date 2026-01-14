## Verification and Testing

```bash
sudo systemctl restart NetworkManager
nmcli connection show --active
ip addr show
hostnamectl status
hostname -f
ping -c 4 8.8.8.8
ping -c 4 google.com
ping -c 2 lab-server-01
nslookup google.com
dig google.com
```

---

## Troubleshooting

### Network Issues

**Connection fails to activate**

```bash
nmcli connection show
nmcli device status
```

**No internet access**

```bash
ip route show
cat /etc/resolv.conf
```

### Hostname Issues

**Hostname not persistent**

```bash
sudo chmod 644 /etc/hostname
sudo systemctl restart systemd-hostnamed
```

**Resolution failure**

```bash
cat /etc/hosts
cat /etc/resolv.conf
```

---

## Lab Cleanup (Optional)

```bash
sudo nmcli connection delete "static-connection"
sudo nmcli connection delete "backup-connection"
sudo hostnamectl set-hostname localhost.localdomain
```

---
