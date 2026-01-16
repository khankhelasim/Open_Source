## Task 1: Create Firewall Rules Using Firewalld

### Subtask 1.1: Install and Start Firewalld Service

```bash
rpm -qa | grep firewalld
sudo dnf install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo systemctl status firewalld
sudo firewall-cmd --state
```

### Subtask 1.2: Understanding Firewalld Basics

```bash
sudo firewall-cmd --list-all
sudo firewall-cmd --get-zones
sudo firewall-cmd --get-default-zone
sudo firewall-cmd --get-active-zones
```

### Subtask 1.3: Create Basic Firewall Rules

```bash
sudo firewall-cmd --add-service=http
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --add-port=3000-3005/tcp --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
```

### Subtask 1.4: Create Advanced Firewall Rules

```bash
sudo firewall-cmd --add-source=192.168.1.100 --permanent
sudo firewall-cmd --add-source=192.168.1.0/24 --permanent
sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.50" drop' --permanent
sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.100" service name="ssh" accept' --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-all
```

---

## Task 2: Test Firewall Configuration

### Subtask 2.1: Install Testing Tools

```bash
sudo dnf install nmap telnet nc httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Firewall Test Page</h1>" | sudo tee /var/www/html/index.html
```

### Subtask 2.2: Test HTTP/HTTPS Access

```bash
curl http://localhost
curl http://<SERVER_IP>
nmap -p 80 localhost
telnet localhost 8080
```

### Subtask 2.3: Test SSH Access

```bash
sudo firewall-cmd --list-services | grep ssh
ssh localhost
nmap -p 22 localhost
```

### Subtask 2.4: Test Blocked Ports

```bash
telnet localhost 3306
nmap localhost
nc -zv localhost 3306
```

---

## Task 3: Set Up Zones and Services for Secure Communication

### Subtask 3.1: Understanding and Managing Zones

```bash
sudo firewall-cmd --list-all-zones
sudo firewall-cmd --zone=public --list-all
sudo firewall-cmd --zone=internal --list-all
sudo firewall-cmd --zone=dmz --list-all
sudo firewall-cmd --new-zone=webserver --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --get-zones
```

### Subtask 3.2: Configure Custom Zone

```bash
sudo firewall-cmd --zone=webserver --add-service=http --permanent
sudo firewall-cmd --zone=webserver --add-service=https --permanent
sudo firewall-cmd --zone=webserver --add-service=ssh --permanent
sudo firewall-cmd --zone=webserver --add-port=8080/tcp --permanent
sudo firewall-cmd --zone=webserver --set-description="Web Server Zone" --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --zone=webserver --list-all
```

### Subtask 3.3: Assign Network Interfaces to Zones

```bash
ip addr show
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=webserver --change-interface=eth0 --permanent
sudo firewall-cmd --get-active-zones
```

### Subtask 3.4: Configure Internal and DMZ Zones

```bash
sudo firewall-cmd --zone=internal --add-service=ssh --permanent
sudo firewall-cmd --zone=internal --add-service=samba --permanent
sudo firewall-cmd --zone=internal --add-service=nfs --permanent
sudo firewall-cmd --zone=internal --add-source=192.168.1.0/24 --permanent
sudo firewall-cmd --zone=internal --add-source=10.0.0.0/8 --permanent
sudo firewall-cmd --zone=dmz --add-service=http --permanent
sudo firewall-cmd --zone=dmz --add-service=https --permanent
sudo firewall-cmd --zone=dmz --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

### Subtask 3.5: Create Rich Rules

```bash
sudo firewall-cmd --add-rich-rule='rule source address="192.168.1.0/24" service name="ssh" accept' --permanent
sudo firewall-cmd --zone=internal --add-rich-rule='rule source address="0.0.0.0/0" drop' --permanent
sudo firewall-cmd --zone=internal --add-rich-rule='rule source address="192.168.1.0/24" accept' --permanent
sudo firewall-cmd --add-rich-rule='rule service name="ssh" accept limit value="3/m"' --permanent
sudo firewall-cmd --add-rich-rule='rule drop log prefix="FIREWALL-DROP: " level="warning"' --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --list-rich-rules
```

### Subtask 3.6: Test Zone-Based Security

```bash
sudo firewall-cmd --zone=public --list-services
sudo firewall-cmd --zone=internal --list-services
nmap -p 22,80,443 localhost
sudo journalctl -u firewalld -f
sudo firewall-cmd --get-active-zones
```
