# Lab 3: Managing Ansible Inventory

---

## 📌 Objectives

By the end of this lab, students will be able to:

* Create and configure static inventory files for Ansible automation
* Understand the structure and syntax of Ansible inventory files (INI & YAML)
* Implement dynamic inventory using Python scripts
* Test and validate inventory configurations using Ansible commands
* Troubleshoot common inventory-related issues
* Organize hosts into logical groups for efficient management
* Apply inventory variables to customize host configurations

---

## 📋 Prerequisites

Before starting this lab, students should have:

* Basic understanding of Linux command-line operations
* Familiarity with text editors (nano, vim, gedit)
* Completion of Lab 1 and Lab 2 (Ansible basics)
* Basic knowledge of YAML syntax
* Understanding of SSH authentication (password or key-based)

---

## 🧪 Lab Environment

### Option A: Cloud / Real Machines (Default)

* 1 Ansible Control Node (ansible-control)
* 3 Managed Nodes (web1, web2, db1)
* SSH access pre-configured

### Option B: ⚠️ Single Machine using Containers (Recommended for Practice)

If you **do not have multiple machines**, you can still complete this lab using **containers (Podman or Docker)** on a single system.

* Control node → Your local Linux machine
* Managed nodes → Containers running SSH
* Ansible connects via `localhost` with different SSH ports

✅ This approach is **lab-safe, exam-safe, and widely used for practice**.

---
<img width="872" height="685" alt="Screenshot 2026-01-22 212918" src="https://github.com/user-attachments/assets/c6dd68a2-8477-453a-92f7-0b63ea8a7809" />


## 🎯 Conclusion

In this lab, you successfully:

* Built static inventories (INI & YAML)
* Implemented dynamic inventories using Python
* Practiced inventory testing and debugging
* Learned container-based lab simulation

### Why This Matters

Inventory management is the **foundation of Ansible automation**. These skills scale directly to:

* Cloud automation (AWS, Azure, GCP)
* Kubernetes & containers
* Large enterprise infrastructure

🚀 You are now ready to move forward with **playbooks, roles, and automation workflows**.

---

**End of Lab 3**
