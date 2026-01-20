# Task 1: Understanding Playbook Structure and Creating Your First Playbook

## Subtask 1.1: Explore the Playbook Directory Structure

```bash
cd /home/ansible
mkdir -p playbooks/lab2
cd playbooks/lab2
mkdir -p {group_vars,host_vars,roles,files,templates}
ls -la
```

---

## Subtask 1.2: Create Your First Basic Playbook

```bash
nano install-package.yml
```

```yaml
---
- name: Install and configure a package on remote hosts
  hosts: managed_nodes
  become: yes
  gather_facts: yes

  vars:
    package_name: httpd
    service_name: httpd

  tasks:
    - name: Install the specified package
      yum:
        name: "{{ package_name }}"
        state: present
      notify: start and enable service

    - name: Ensure the service is running
      service:
        name: "{{ service_name }}"
        state: started
        enabled: yes

    - name: Create a simple index.html file
      copy:
        content: |
          <html>
          <head><title>Ansible Lab 2</title></head>
          <body>
          <h1>Welcome to Ansible Playbook Lab!</h1>
          <p>This page was created by an Ansible playbook.</p>
          </body>
          </html>
        dest: /var/www/html/index.html
        owner: apache
        group: apache
        mode: '0644'
      notify: restart web service

  handlers:
    - name: start and enable service
      service:
        name: "{{ service_name }}"
        state: started
        enabled: yes

    - name: restart web service
      service:
        name: "{{ service_name }}"
        state: restarted
```

---

## Subtask 1.3: Understanding Playbook Components

### Play Definition

* name: Descriptive play name
* hosts: Target inventory group
* become: Enables sudo
* gather_facts: Collects system facts

### Variables

* Defined under vars
* Accessed using {{ variable_name }}

### Tasks

* Ordered list of actions
* Uses Ansible modules
* notify triggers handlers

### Handlers

* Run only when notified
* Used for restarts and reloads

---

# Task 2: Define Hosts and Create Inventory

## Subtask 2.1: Create a Custom Inventory File

```bash
nano inventory.ini
```

```ini
[managed_nodes]
node1 ansible_host=192.168.1.10 ansible_user=ansible
node2 ansible_host=192.168.1.11 ansible_user=ansible

[web_servers]
node1

[database_servers]
node2

[all:vars]
ansible_ssh_private_key_file=/home/ansible/.ssh/id_rsa
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

---

## Subtask 2.2: Verify Inventory and Connectivity

```bash
ansible-inventory -i inventory.ini --list
ansible -i inventory.ini managed_nodes -m ping
ansible -i inventory.ini managed_nodes -m setup --tree /tmp/facts
```

---

# Task 3: Enhance the Playbook with Advanced Tasks and Handlers

## Subtask 3.1: Enhanced Playbook

```bash
nano enhanced-playbook.yml
```

```yaml
---
- name: Enhanced package installation and configuration
  hosts: managed_nodes
  become: yes
  gather_facts: yes

  vars:
    packages:
      - httpd
      - firewalld
      - wget
    web_port: 80
    document_root: /var/www/html

  pre_tasks:
    - name: Update package cache
      yum:
        update_cache: yes
      tags: always

  tasks:
    - name: Install required packages
      yum:
        name: "{{ packages }}"
        state: present
      notify:
        - start httpd
        - start firewalld
      tags: packages

    - name: Configure firewall for web traffic
      firewalld:
        service: http
        permanent: yes
        state: enabled
        immediate: yes
      notify: reload firewall
      tags: firewall

    - name: Create custom web content
      template:
        src: index.html.j2
        dest: "{{ document_root }}/index.html"
        owner: apache
        group: apache
        mode: '0644'
      notify: restart httpd
      tags: content

    - name: Ensure web service is running
      service:
        name: httpd
        state: started
        enabled: yes
      tags: services

    - name: Verify web service
      uri:
        url: "http://{{ ansible_default_ipv4.address }}:{{ web_port }}"
        status_code: 200
      delegate_to: localhost
      tags: verification

  handlers:
    - name: start httpd
      service:
        name: httpd
        state: started
        enabled: yes

    - name: restart httpd
      service:
        name: httpd
        state: restarted

    - name: start firewalld
      service:
        name: firewalld
        state: started
        enabled: yes

    - name: reload firewall
      service:
        name: firewalld
        state: reloaded

  post_tasks:
    - name: Completion message
      debug:
        msg: "Playbook execution completed on {{ inventory_hostname }}"
```

---

## Subtask 3.2: Create Template File

```bash
nano templates/index.html.j2
```

```html
<!DOCTYPE html>
<html>
<head>
    <title>{{ inventory_hostname }} - Ansible Lab 2</title>
</head>
<body>
    <h1>Welcome to {{ inventory_hostname }}</h1>
    <p>OS: {{ ansible_distribution }} {{ ansible_distribution_version }}</p>
    <p>IP: {{ ansible_default_ipv4.address }}</p>
</body>
</html>
```

---

# Task 4: Run the Playbooks

```bash
ansible-playbook -i inventory.ini install-package.yml -v
ansible-playbook -i inventory.ini install-package.yml --syntax-check
ansible-playbook -i inventory.ini install-package.yml --check

ansible-playbook -i inventory.ini enhanced-playbook.yml
ansible-playbook -i inventory.ini enhanced-playbook.yml --tags "packages,firewall"
ansible-playbook -i inventory.ini enhanced-playbook.yml --skip-tags "verification"
```

---

# Task 5: Troubleshooting and Best Practices

## Debugging

```bash
ansible-playbook -i inventory.ini enhanced-playbook.yml -vvv
```

```yaml
---
- name: Debug variables
  hosts: managed_nodes
  gather_facts: yes

  tasks:
    - name: Show all variables
      debug:
        var: hostvars[inventory_hostname]

    - name: Show key facts
      debug:
        msg: |
          Hostname: {{ ansible_hostname }}
          IP: {{ ansible_default_ipv4.address }}
```

---

## Error Handling

```yaml
---
- name: Error handling example
  hosts: managed_nodes
  become: yes

  tasks:
    - name: Install invalid package
      yum:
        name: non-existent-package
        state: present
      ignore_errors: yes
      register: result

    - name: Show error
      debug:
        msg: "{{ result.msg }}"
      when: result.failed
```

---
