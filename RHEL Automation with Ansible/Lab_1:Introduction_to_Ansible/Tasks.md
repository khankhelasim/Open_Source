## Tasks

### Task 1: Install Ansible on the Control Node

**Objective:** Install Ansible on the Linux machine.

#### Steps:

1. Open the terminal and update package lists:

   ```bash
   sudo apt update
   ```

2. Install Ansible:

   ```bash
   sudo apt install ansible -y
   ```

3. Verify the installation:

   ```bash
   ansible --version
   ```

---

### Task 2: Set Up a Basic Inventory

**Objective:** Create a basic inventory file to list managed hosts.

#### Steps:

1. Open the Ansible inventory file:

   ```bash
   sudo nano /etc/ansible/hosts
   ```

2. Add the following configuration for the local host:

   ```ini
   [local]
   localhost ansible_connection=local
   ```

3. Save the file and exit the editor.

---

### Task 3: Run a Simple Ping Command

**Objective:** Test the Ansible setup by running a ping command on the managed host.

#### Steps:

1. Run the following command:

   ```bash
   ansible local -m ping
   ```

2. A successful setup will return a **pong** response.

---

## Verification

Confirm the following:

* Ansible is installed:

  ```bash
  ansible --version
  ```

* The ping command returns **pong**

* The inventory file contains the correct localhost entry

---
