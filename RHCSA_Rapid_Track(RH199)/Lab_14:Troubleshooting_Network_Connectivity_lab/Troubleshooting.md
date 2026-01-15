# 🧪 Practical Troubleshooting Scenarios

## Scenario 1: Cannot Access Websites

* Test localhost
* Test gateway
* Test DNS resolution
* Test external IP connectivity

## Scenario 2: Service Not Accessible

* Verify service is running
* Check firewall rules
* Open required ports

## Scenario 3: DNS Resolution Failure

* Inspect /etc/resolv.conf
* Test alternate DNS servers
* Update DNS via nmcli

---

# Troubleshooting and Common Issues

## Network Interface Down

```bash
nmcli device status
sudo nmcli device connect eth0
```

## Firewall Blocking Traffic

```bash
sudo journalctl -u firewalld -f
sudo systemctl stop firewalld
```

## DNS Cache Problems

```bash
sudo systemd-resolve --flush-caches
sudo systemctl restart NetworkManager
```

---

# ✨Verification and Testing

```bash
ping -c 4 google.com
traceroute google.com
nslookup google.com
sudo firewall-cmd --list-all
nmcli connection show --active
ip addr show
ip route show
```

---
