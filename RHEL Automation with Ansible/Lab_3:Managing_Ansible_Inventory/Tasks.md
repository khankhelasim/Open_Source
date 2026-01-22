## 🗂️ Task 1: Create Static Inventory Files

### Subtask 1.1: Basic Static Inventory (INI)

Create working directory:

```bash
mkdir -p ~/ansible-labs/lab3-inventory
cd ~/ansible-labs/lab3-inventory
```

Create inventory file:

```bash
nano inventory.ini
```

```ini
# Basic Static Inventory File

[webservers]
web1 ansible_host=192.168.1.10 ansible_user=student
web2 ansible_host=192.168.1.11 ansible_user=student

[databases]
db1 ansible_host=192.168.1.20 ansible_user=student

[production:children]
webservers
databases

[webservers:vars]
http_port=80
max_clients=200

[databases:vars]
mysql_port=3306
max_connections=100
```

---

### Subtask 1.2: Advanced Static Inventory

Create advanced inventory:

```bash
nano advanced-inventory.ini
```

```ini
[webservers]
web1 ansible_host=192.168.1.10 ansible_user=student server_role=frontend
web2 ansible_host=192.168.1.11 ansible_user=student server_role=frontend

[databases]
db1 ansible_host=192.168.1.20 ansible_user=student server_role=backend

[loadbalancers]
lb1 ansible_host=192.168.1.30 ansible_user=student server_role=loadbalancer

[production:children]
webservers
databases
loadbalancers

[staging]
staging-web ansible_host=192.168.1.40 ansible_user=student
staging-db ansible_host=192.168.1.41 ansible_user=student

[east-coast]
web1
db1

[west-coast]
web2
lb1

[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[webservers:vars]
http_port=80
https_port=443
document_root=/var/www/html
max_clients=200

[databases:vars]
mysql_port=3306
mysql_datadir=/var/lib/mysql
max_connections=100
innodb_buffer_pool_size=256M

[loadbalancers:vars]
balance_method=roundrobin
health_check_interval=30
```

---

### Subtask 1.3: YAML Inventory

Create YAML inventory:

```bash
nano inventory.yml
```

```yaml
all:
  children:
    webservers:
      hosts:
        web1:
          ansible_host: 192.168.1.10
          ansible_user: student
          server_role: frontend
          http_port: 80
        web2:
          ansible_host: 192.168.1.11
          ansible_user: student
          server_role: frontend
          http_port: 80
      vars:
        max_clients: 200
        document_root: /var/www/html

    databases:
      hosts:
        db1:
          ansible_host: 192.168.1.20
          ansible_user: student
          server_role: backend
          mysql_port: 3306
      vars:
        max_connections: 100
        mysql_datadir: /var/lib/mysql

    production:
      children:
        webservers:
        databases:
      vars:
        environment: production
        backup_schedule: "0 2 * * *"
```

---

## 🔄 Task 2: Dynamic Inventory

### Subtask 2.1: Basic Dynamic Inventory Script

```bash
nano dynamic-inventory.py
chmod +x dynamic-inventory.py
```

(Uses Python + JSON to return inventory dynamically)

---

### Subtask 2.2: Advanced Cloud Inventory Script

```bash
nano cloud-inventory.py
chmod +x cloud-inventory.py
```

Simulates cloud discovery using environment variables:

```bash
export CLOUD_PROVIDER=aws
export CLOUD_REGION=us-west-2
export ENVIRONMENT=staging
```

---

## ✅ Task 3: Testing Inventory

### Basic Tests

```bash
ansible all -i inventory.ini -m ping
ansible all -i inventory.yml -m ping
ansible all -i ./dynamic-inventory.py -m ping
```

### Inventory Visualization

```bash
ansible-inventory -i inventory.ini --graph
ansible-inventory -i inventory.yml --list
```

---

## 🧠 Container-Based Practice Tips (IMPORTANT)

If using **Podman or Docker** on a single machine:

* Use `ansible_host=localhost`
* Assign unique SSH ports per container
* Use `ansible_user=root`
* Run Ansible with `-k` for password auth

Example:

```yaml
ansible_host: localhost
ansible_port: 2221
ansible_user: root
```

This fully replaces real machines for practice.

---

## 🛠️ Common Troubleshooting

### SSH Issues

* Use `-k` for password authentication
* Disable key checking if needed

### YAML Errors

* Indentation matters
* Use spaces (not tabs)

### Dynamic Inventory Errors

* Script must be executable
* Must output valid JSON
* Shebang (`#!/usr/bin/env python3`) is mandatory

---
