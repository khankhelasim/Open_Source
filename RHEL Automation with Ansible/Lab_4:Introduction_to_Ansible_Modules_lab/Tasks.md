## Task 1: Understanding Ansible Modules

### Subtask 1.1: Explore Available Modules

First, let's understand what modules are available in your Ansible installation.

Connect to your control node and verify Ansible installation:

```bash
ansible --version
```

List all available modules to see the extensive library:

```bash
ansible-doc -l | head -20
```

Get detailed information about specific modules we'll use:

```bash
ansible-doc yum
ansible-doc apt
ansible-doc service
```

---

### Subtask 1.2: Verify Your Inventory

Check your inventory file to ensure managed nodes are properly configured:

```bash
cat /etc/ansible/hosts
```

Test connectivity to all managed nodes:

```bash
ansible all -m ping
```

Expected output should show **SUCCESS** for all nodes.

---

## Task 2: Working with Package Management Modules

### Subtask 2.1: Using the YUM Module

The `yum` module manages packages on Red Hat-based systems (CentOS, RHEL, Fedora).

Create a new playbook for package management:

```bash
mkdir -p ~/ansible-labs/lab4
cd ~/ansible-labs/lab4
nano package-management.yml
```



Run the playbook:

```bash
ansible-playbook package-management.yml
```

---

### Subtask 2.2: Using the APT Module

The `apt` module manages packages on Debian-based systems (Ubuntu, Debian).

Create a playbook for Ubuntu package management:

```bash
nano apt-management.yml
```



Execute the playbook:

```bash
ansible-playbook apt-management.yml
```

---

### Subtask 2.3: Cross-Platform Package Management

Create a playbook that works across different operating systems.

```bash
nano universal-packages.yml
```


Run the playbook:

```bash
ansible-playbook universal-packages.yml
```

---

## Task 3: Managing Services with the Service Module

### Subtask 3.1: Basic Service Management

```bash
nano service-management.yml
```


Run:

```bash
ansible-playbook service-management.yml
```

---

### Subtask 3.2: Advanced Service Operations

```bash
nano advanced-services.yml
```


Run:

```bash
ansible-playbook advanced-services.yml
```

---

## Task 4: Creating a Complete Infrastructure Playbook

### Subtask 4.1: Combine All Modules

```bash
nano infrastructure-setup.yml
```


Run:

```bash
ansible-playbook infrastructure-setup.yml
```

---

### Subtask 4.2: Verify the Setup

```bash
ansible all -m service -a "name=httpd state=started" --become
ansible all -m service -a "name=apache2 state=started" --become
ansible all -m package -a "name=git state=present" --become
ansible all -m uri -a "url=http://{{ inventory_hostname }} method=GET"
```

---

## Task 5: Error Handling and Best Practices

### Subtask 5.1: Implement Error Handling

```bash
nano error-handling.yml
```


Run:

```bash
ansible-playbook error-handling.yml
```

---

## Troubleshooting Common Issues

### Package Management Issues

**Problem:** Package installation fails with permission errors
**Solution:** Ensure you're using `become: yes` in your playbook

**Problem:** YUM/APT cache is outdated
**Solution:** Add `update_cache: yes` to your package tasks

### Service Management Issues

**Problem:** Service fails to start
**Solution:** Check service dependencies and ensure required packages are installed first

**Problem:** Service name differs between distributions
**Solution:** Use conditional statements with `ansible_os_family`

### General Module Issues

**Problem:** Module not found error
**Solution:** Verify Ansible version and module availability using `ansible-doc`

**Problem:** Syntax errors in playbooks
**Solution:** Use `ansible-playbook --syntax-check playbook.yml`

---

## Verification Commands

```bash
ansible all -m package -a "name=git state=present" --check
ansible all -m service -a "name=httpd" --become
ansible all -m service -a "name=apache2" --become
ansible all -m uri -a "url=http://{{ inventory_hostname }}"
ansible-playbook --syntax-check infrastructure-setup.yml
```

---
