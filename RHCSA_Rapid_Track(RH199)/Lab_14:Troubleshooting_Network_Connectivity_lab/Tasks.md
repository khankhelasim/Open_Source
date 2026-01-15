# Task 1: Testing Network Connectivity with Diagnostic Tools

## Subtask 1.1: Testing Connectivity with ping

### Step 1: Test Localhost Connectivity

```bash
ping -c 4 127.0.0.1
```

Purpose: Verifies the TCP/IP stack on the local system.

### Step 2: Test Gateway Connectivity

```bash
ip route show default
ping -c 4 <gateway-ip>
```

Purpose: Confirms connectivity to the local network gateway.

### Step 3: Test External Connectivity

```bash
ping -c 4 8.8.8.8
ping -c 4 google.com
```

Purpose: Differentiates between IP connectivity and DNS resolution issues.

---

## Subtask 1.2: Tracing Network Paths with traceroute

### Step 1: Install traceroute

```bash
sudo dnf install -y traceroute
```

### Step 2: Trace Route to a Domain

```bash
traceroute google.com
```

### Step 3: Trace Route Without DNS Resolution

```bash
traceroute -n 8.8.8.8
```

Purpose: Identifies where packets are being delayed or dropped.

---

## Subtask 1.3: DNS Troubleshooting with nslookup

### Step 1: Standard DNS Query

```bash
nslookup google.com
```

### Step 2: Reverse DNS Lookup

```bash
nslookup 8.8.8.8
```

### Step 3: Query Specific DNS Records

```bash
nslookup -type=MX google.com
nslookup -type=NS google.com
```

### Step 4: Query Using a Specific DNS Server

```bash
nslookup google.com 8.8.8.8
```

---

# Task 2: Managing Network Configuration with nmcli

## Subtask 2.1: Viewing Network Status

```bash
nmcli general status
nmcli device status
nmcli device show
```

---

## Subtask 2.2: Managing Connections

```bash
nmcli connection show
nmcli connection show --active
nmcli connection show "System eth0"
```

---

## Subtask 2.3: Modifying Network Settings

### Configure DNS Servers

```bash
sudo nmcli connection modify "System eth0" ipv4.dns "8.8.8.8,8.8.4.4"
sudo nmcli connection up "System eth0"
```

### Configure Static IP Address

```bash
sudo nmcli connection modify "System eth0" ipv4.addresses "192.168.1.100/24"
sudo nmcli connection modify "System eth0" ipv4.gateway "192.168.1.1"
sudo nmcli connection modify "System eth0" ipv4.method manual
sudo nmcli connection up "System eth0"
```

### Revert to DHCP

```bash
sudo nmcli connection modify "System eth0" ipv4.method auto
sudo nmcli connection up "System eth0"
```

---

## Subtask 2.4: Creating a New Network Connection

```bash
sudo nmcli connection add type ethernet con-name "lab-connection" ifname eth0
sudo nmcli connection modify "lab-connection" ipv4.addresses "192.168.1.150/24"
sudo nmcli connection modify "lab-connection" ipv4.gateway "192.168.1.1"
sudo nmcli connection modify "lab-connection" ipv4.dns "8.8.8.8"
sudo nmcli connection modify "lab-connection" ipv4.method manual
sudo nmcli connection up "lab-connection"
```

---

# Task 3: Firewall Configuration with firewalld

## Subtask 3.1: Firewalld Basics

```bash
sudo systemctl status firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
```

```bash
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all
```

---

## Subtask 3.2: Managing Firewall Services

```bash
sudo firewall-cmd --zone=public --add-service=http --permanent
sudo firewall-cmd --zone=public --add-service=https --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-services
```

---

## Subtask 3.3: Managing Firewall Ports

```bash
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=public --add-port=53/udp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-ports
```

---

## Subtask 3.4: Advanced Firewall Rules

```bash
sudo firewall-cmd --permanent --new-service=myapp
sudo firewall-cmd --permanent --service=myapp --add-port=9090/tcp
sudo firewall-cmd --zone=public --add-service=myapp --permanent
sudo firewall-cmd --reload
```

```bash
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.100" service name="ssh" accept' --permanent
sudo firewall-cmd --reload
```
