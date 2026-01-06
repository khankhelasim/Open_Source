# Lab 6: Working with vim and nano

This document contains **ALL tasks, commands, and file contents** for Lab 6.
---

## Task 1: Getting Started with Text Editors

### Task 1.1: Create Practice Directory

```bash
mkdir ~/text-editor-lab
cd ~/text-editor-lab
pwd
```

### Task 1.2: Check Available Editors

```bash
which vim
which nano
vim --version | head -1
nano --version | head -1
```

---

## Task 2: Working with nano Editor

### Task 2.1: Create File Using nano

```bash
nano server-config.txt
```

### Task 2.2: File Content (server-config.txt)

```conf
# Server Configuration File
# Created on: Today's Date

server_name=web-server-01
port=8080
max_connections=100
timeout=30
debug_mode=false

# Database Settings
db_host=localhost
db_port=3306
db_name=webapp
```

### Task 2.3: nano Editing Practice

* Cut line: `Ctrl + K`
* Paste line: `Ctrl + U`

### Task 2.4: Save and Exit

* `Ctrl + O` → Enter
* `Ctrl + X`

### Task 2.5: Verify File

```bash
ls -la server-config.txt
cat server-config.txt
```

### Task 2.6: Modify File

```bash
nano server-config.txt
```

Add at end:

```conf
# Security Settings
ssl_enabled=true
ssl_port=443
encryption=AES256
```

Save and exit.

---

## Task 3: Working with vim Editor

### Task 3.1: Create File Using vim

```bash
vim network-settings.conf
```

### Task 3.2: Enter Insert Mode

Press:

```
i
```

### Task 3.3: File Content (network-settings.conf)

```conf
# Network Configuration
# System: RHEL/CentOS

interface=eth0
ip_address=192.168.1.100
subnet_mask=255.255.255.0
gateway=192.168.1.1
dns_primary=8.8.8.8
dns_secondary=8.8.4.4

# Network Services
ssh_enabled=yes
firewall_enabled=yes
```

### Task 3.4: Exit Insert Mode

Press:

```
Esc
```

### Task 3.5: vim Navigation Commands

* `h j k l` → left, down, up, right
* `w` → next word
* `b` → previous word
* `0` → line start
* `$` → line end
* `gg` → first line
* `G` → last line

### Task 3.6: vim Editing Practice

```text
yy  → copy line
p   → paste
u   → undo
Ctrl + r → redo
```

Edit DNS:

* Copy `dns_primary`
* Paste below
* Change to:

```conf
dns_tertiary=1.1.1.1
```

### Task 3.7: Save and Exit

```vim
:wq
```

### Task 3.8: Verify

```bash
ls -la network-settings.conf
cat network-settings.conf
```

---

## Task 4: Comparing vim and nano

### Task 4.1: nano Comparison File

```bash
nano comparison-nano.txt
```

```text
Editor: nano
Ease of use: Beginner-friendly
Learning curve: Gentle
Best for: Quick edits, beginners
Commands visible: Yes
```

Save and exit.

### Task 4.2: vim Comparison File

```bash
vim comparison-vim.txt
```

Press `i` and add:

```text
Editor: vim
Ease of use: Advanced users
Learning curve: Steep
Best for: Complex editing, programming
Commands visible: No
```

Press `Esc` then:

```vim
:wq
```

### Task 4.3: View Files

```bash
cat comparison-nano.txt
echo "---"
cat comparison-vim.txt
```

---

## Task 5: Practical Scenarios

### Task 5.1: nano – Quick Configuration Edit

```bash
nano /tmp/httpd.conf
```

```conf
# Apache HTTP Server Configuration
ServerRoot "/etc/httpd"
Listen 80
ServerName localhost:80
DocumentRoot "/var/www/html"

# Security Settings
ServerTokens Prod
ServerSignature Off

# Performance Settings
MaxRequestWorkers 150
ThreadsPerChild 25
```

Save and exit.

Verify:

```bash
cat /tmp/httpd.conf
```

---

### Task 5.2: vim – Complex Editing

```bash
vim /tmp/complex-config.conf
```

Press `i` and add:

```conf
# Multi-service Configuration

[database]
host=db-server-01
port=5432
username=admin
password=temp123

[webserver]
host=web-server-01
port=80
ssl_port=443
document_root=/var/www

[cache]
host=cache-server-01
port=6379
memory_limit=512M
```

Press `Esc`

Show line numbers:

```vim
:set number
```

Go to password line:

```vim
:7
```

Change password:

```text
cw → secure_password_2024 → Esc
```

Save:

```vim
:w
```

---

### Task 5.3: Search & Replace in vim

```vim
:%s/server/node/g
```

Save and exit:

```vim
:wq
```

Verify:

```bash
cat /tmp/complex-config.conf
```

---


## Lab Verification

```bash
ls -la ~/text-editor-lab/
cat ~/text-editor-lab/server-config.txt
cat ~/text-editor-lab/network-settings.conf
cat /tmp/complex-config.conf
```

---

✅ **Lab 6 Completed Successfully**
