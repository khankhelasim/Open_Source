# Lab 8: Installing and Managing Software Packages

## Task 1: Installing Packages Using DNF and YUM

### Subtask 1.1: Identify Package Managers

```bash
which dnf
which yum
dnf --version || yum --version
```

### Subtask 1.2: Update Repository Metadata

```bash
sudo dnf update -y || sudo yum update -y
```

### Subtask 1.3: Install Individual Packages

**Install nano**

```bash
sudo dnf install nano -y
which nano
nano --version
```

**Install htop**

```bash
sudo dnf install htop -y
htop --version
```

**Install wget**

```bash
sudo dnf install wget -y
wget --version
```

### Subtask 1.4: Install Multiple Packages

```bash
sudo dnf install tree unzip zip curl -y

tree --version
unzip -v | head -1
zip -v | head -1
curl --version | head -1
```

### Subtask 1.5: Install Package Groups

```bash
dnf group list
sudo dnf group install "Development Tools" -y
gcc --version
```

---

## Task 2: Querying Installed Packages

### Subtask 2.1: Using RPM

```bash
rpm -qa | head -20
rpm -qa | wc -l

rpm -q nano
rpm -qi nano
rpm -ql nano | head -10
rpm -qf /usr/bin/nano
```

### Subtask 2.2: Using DNF

```bash
dnf search editor
dnf list nano
dnf list installed | head -20

dnf info nano
dnf deplist nano
dnf check-update
```

### Subtask 2.3: Advanced Queries

```bash
dnf provides /usr/bin/python3
dnf provides "*/bin/gcc"

dnf history list | head -10

dnf repolist
dnf repolist all
```

---

## Task 3: Removing and Updating Packages

### Subtask 3.1: Remove Packages

```bash
sudo dnf remove tree -y
which tree

sudo dnf install httpd -y
dnf deplist httpd
sudo dnf remove httpd -y
sudo dnf autoremove -y
```

### Subtask 3.2: Update Packages

```bash
rpm -q kernel
sudo dnf update nano -y
dnf info nano

dnf check-update
sudo dnf update -y

dnf history list | head -5
```

### Subtask 3.3: Reinstall & Downgrade

```bash
sudo dnf reinstall nano -y

dnf list nano --showduplicates
# sudo dnf downgrade nano-<version>
```

### Subtask 3.4: Clean Package Cache

```bash
du -sh /var/cache/dnf/
sudo dnf clean all
du -sh /var/cache/dnf/
```

---

## Practical Exercise: Web Development Environment

### Step 1: Install Packages

```bash
sudo dnf install httpd php php-mysql mariadb-server git -y
```

### Step 2: Verify Installation

```bash
rpm -q httpd php php-mysql mariadb-server git
rpm -ql httpd | grep bin
```

### Step 3: Start & Enable Services

```bash
sudo systemctl start httpd
sudo systemctl enable httpd
systemctl status httpd
```

### Step 4: Update Packages

```bash
dnf check-update httpd php php-mysql mariadb-server git
sudo dnf update httpd php php-mysql mariadb-server git -y
```

### Step 5: Cleanup (Optional)

```bash
sudo systemctl stop httpd
sudo systemctl disable httpd
sudo dnf remove httpd php php-mysql mariadb-server -y
sudo dnf autoremove -y
```

---

## Verification Commands

```bash
rpm -q nano htop wget curl

dnf --version
rpm --version

dnf check-update | head -5

dnf repolist enabled
```
