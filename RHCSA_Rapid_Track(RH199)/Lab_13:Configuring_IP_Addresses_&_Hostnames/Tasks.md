## Task 1: Configure Static IP Addresses with nmcli

### Subtask 1.1: Understanding Current Network Configuration

**Step 1:** Check existing network connections

```bash
nmcli connection show
```

**Step 2:** View active connections

```bash
nmcli connection show --active
```

**Step 3:** Display current IP configuration

```bash
ip addr show
```

**Step 4:** Verify NetworkManager service status

```bash
systemctl status NetworkManager
```

---

### Subtask 1.2: Creating a New Static IP Connection

**Step 1:** Identify the network interface name

```bash
nmcli device status
```

> Note: Common interface names include `eth0`, `ens33`, or `enp0s3`. Replace `eth0` below with your actual interface name.

**Step 2:** Create a new static IP connection

```bash
sudo nmcli connection add \
  type ethernet \
  con-name "static-connection" \
  ifname eth0 \
  ip4 192.168.1.100/24 \
  gw4 192.168.1.1
```

**Step 3:** Configure DNS servers

```bash
sudo nmcli connection modify "static-connection" \
  ipv4.dns "8.8.8.8,8.8.4.4"
```

**Step 4:** Set IPv4 method to manual

```bash
sudo nmcli connection modify "static-connection" ipv4.method manual
```

---

### Subtask 1.3: Activating and Testing the Static Connection

**Step 1:** Activate the connection

```bash
sudo nmcli connection up "static-connection"
```

**Step 2:** Confirm the connection is active

```bash
nmcli connection show --active
```

**Step 3:** Verify IP address assignment

```bash
ip addr show eth0
```

**Step 4:** Test external connectivity

```bash
ping -c 4 8.8.8.8
```

---

## Task 2: Set Up Network Interfaces

### Subtask 2.1: Managing Multiple Network Connections

**Step 1:** List all network devices

```bash
nmcli device show
```

**Step 2:** Create a backup connection profile

```bash
sudo nmcli connection add \
  type ethernet \
  con-name "backup-connection" \
  ifname eth0 \
  ip4 192.168.1.101/24 \
  gw4 192.168.1.1
```

**Step 3:** Configure DNS for backup connection

```bash
sudo nmcli connection modify "backup-connection" \
  ipv4.dns "1.1.1.1,1.0.0.1" \
  ipv4.method manual
```

---

### Subtask 2.2: Switching Between Network Connections

**Step 1:** View available connections

```bash
nmcli connection show
```

**Step 2:** Switch connections

```bash
sudo nmcli connection down "static-connection"
sudo nmcli connection up "backup-connection"
```

**Step 3:** Verify IP address change

```bash
ip addr show eth0
```

**Step 4:** Test connectivity

```bash
ping -c 4 google.com
```

---

### Subtask 2.3: Configuring Auto-Connect Behavior

**Step 1:** Enable auto-connect for primary connection

```bash
sudo nmcli connection modify "static-connection" connection.autoconnect yes
```

**Step 2:** Set connection priority

```bash
sudo nmcli connection modify "static-connection" connection.autoconnect-priority 10
```

**Step 3:** Disable auto-connect for backup connection

```bash
sudo nmcli connection modify "backup-connection" connection.autoconnect no
```

---

## Task 3: Modify Hostnames Using hostnamectl

### Subtask 3.1: Viewing Current Hostname Configuration

```bash
hostnamectl status
hostname
cat /etc/hostname
```

---

### Subtask 3.2: Setting Hostnames

**Set static hostname**

```bash
sudo hostnamectl set-hostname lab-server-01
```

**Set pretty hostname**

```bash
sudo hostnamectl set-hostname "Lab Server 01" --pretty
```

**Set transient hostname**

```bash
sudo hostnamectl set-hostname temp-lab-server --transient
```

**Verify configuration**

```bash
hostnamectl status
```

---

### Subtask 3.3: Configuring Local Hostname Resolution

**Edit hosts file**

```bash
sudo nano /etc/hosts
```

Add:

```text
192.168.1.100   lab-server-01.localdomain   lab-server-01
```

**Test resolution**

```bash
ping -c 2 lab-server-01
nslookup lab-server-01
```

## Conclusion

In this lab, you successfully:

* Configured static IP addresses using **nmcli**
* Managed multiple network connection profiles
* Controlled hostname settings using **hostnamectl**
* Implemented local hostname resolution
* Verified persistence across reboots
