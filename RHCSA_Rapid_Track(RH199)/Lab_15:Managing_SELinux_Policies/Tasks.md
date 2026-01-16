## Task 1: Check SELinux Status

### Task 1.1: Verify Privileges and SELinux State

```bash
sudo whoami
sestatus
```

**Key Points:**

* SELinux status should be **enabled**
* Mode should be **enforcing**
* Policy type should be **targeted**

```bash
getenforce
cat /etc/selinux/config
```

### SELinux Modes

* **Enforcing**: Policy enforced and denials blocked
* **Permissive**: Policy not enforced but logged
* **Disabled**: SELinux turned off (not recommended)

### Task 1.2: Examine SELinux Contexts

```bash
ls -Z ~/
ps -eZ | head -10
id -Z
```

---

## Task 2: Modify SELinux Policies with semanage

### Task 2.1: Install Required Tools

```bash
sudo dnf install -y policycoreutils-python-utils setools-console
which semanage
semanage --help
```

### Task 2.2: Manage File Contexts

```bash
mkdir -p /opt/testapp
sudo touch /opt/testapp/config.conf
ls -Z /opt/testapp/

sudo semanage fcontext -a -t httpd_config_t "/opt/testapp/config.conf"
sudo restorecon -v /opt/testapp/config.conf
ls -Z /opt/testapp/config.conf
```

### Task 2.3: Manage Port Contexts

```bash
semanage port -l | grep http
sudo semanage port -a -t http_port_t -p tcp 8080
semanage port -l | grep 8080
```

### Task 2.4: Manage SELinux Booleans

```bash
getsebool -a | head -10
getsebool httpd_can_network_connect
sudo setsebool httpd_can_network_connect on
sudo setsebool -P httpd_can_network_connect on
getsebool httpd_can_network_connect
```

### Task 2.5: SELinux User Mapping

```bash
semanage login -l
semanage user -l
```

---

## Task 3: Troubleshoot SELinux Denials

### Task 3.1: Audit and Troubleshooting Tools

```bash
sudo dnf install -y setroubleshoot-server
sudo systemctl status auditd
sudo ausearch -m avc -ts recent
```

### Task 3.2: Generate SELinux Denials (Apache Scenario)

```bash
sudo mkdir -p /home/testuser/website
echo "<html><body>Test Page</body></html>" | sudo tee /home/testuser/website/index.html
sudo chown -R apache:apache /home/testuser/website

sudo dnf install -y httpd
sudo systemctl enable --now httpd
```

```bash
sudo tee /etc/httpd/conf.d/testsite.conf << EOF
<VirtualHost *:80>
    DocumentRoot /home/testuser/website
    <Directory "/home/testuser/website">
        AllowOverride None
        Require all granted
    </Directory>
</VirtualHost>
EOF

sudo systemctl restart httpd
curl http://localhost/
```

### Task 3.3: Analyze Denials

```bash
sudo ausearch -m avc -ts recent
sudo sealert -a /var/log/audit/audit.log
sudo grep denied /var/log/audit/audit.log | tail -5
```

### Task 3.4: Resolve Denials

```bash
ls -Z /home/testuser/website/

sudo semanage fcontext -a -t httpd_sys_content_t "/home/testuser/website(/.*)?"
sudo restorecon -Rv /home/testuser/website/

curl http://localhost/
```

**Alternative Method:**

```bash
sudo chcon --reference=/var/www/html /home/testuser/website/index.html
```

### Task 3.5: Custom Policy Modules (Advanced)

```bash
sudo grep httpd /var/log/audit/audit.log | audit2allow -M myhttpd
cat myhttpd.te
sudo semodule -i myhttpd.pp
```

---

## Advanced SELinux Management

### Policy Modules

```bash
semodule -l | head -10
semodule -l | grep httpd
sestatus | grep "policy version"
```

