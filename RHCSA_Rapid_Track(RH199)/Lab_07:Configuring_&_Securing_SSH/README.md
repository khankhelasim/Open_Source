# Lab 7: Configuring and Securing SSH

## README.md

### Overview

This lab focuses on installing, configuring, testing, and securing the OpenSSH service on Linux systems. SSH (Secure Shell) is the backbone of remote Linux administration in enterprise environments. In this lab, you will move from basic SSH setup to hardened, key-based authentication aligned with RHCSA objectives and real-world best practices.

<img width="814" height="382" alt="image" src="https://github.com/user-attachments/assets/aaa28bfd-8aeb-466e-a65c-27e799a8ffcd" />

### Objectives

By completing this lab, you will be able to:

* Install and manage the OpenSSH server (sshd)
* Understand and modify SSH configuration files
* Test SSH connections locally and remotely
* Configure and verify key-based authentication
* Apply SSH security hardening best practices
* Troubleshoot common SSH connection problems

### Prerequisites

* Basic Linux command-line knowledge
* Understanding of users, groups, and permissions
* Familiarity with nano or vim
* Basic networking concepts (IP address, ports)

### Lab Environment

* CentOS / RHEL 8 or 9
* Two Linux machines (client + server)
* Root and regular user access
* Firewall and SELinux enabled

---

## Task Summary

### Task 1: Install and Configure OpenSSH

* Verify OpenSSH installation
* Start and enable `sshd`
* Secure `/etc/ssh/sshd_config`
* Validate configuration using `sshd -t`
* Configure firewall rules

### Task 2: Test SSH Connectivity

* Local SSH login using `localhost`
* Remote SSH login using IP address
* Use verbose mode (`-v`) for debugging
* Monitor SSH logs and active connections

### Task 3: Configure Key-Based Authentication

* Generate SSH key pairs
* Deploy public keys using `ssh-copy-id`
* Secure `.ssh` directory permissions
* Disable password authentication
* Restrict users and harden cryptographic settings

---

## RHCSA Exam Relevance

This lab directly maps to RHCSA exam objectives:

* Configure and secure SSH access
* Manage system services
* Control user access and authentication
* Troubleshoot service and connectivity issues

SSH configuration and security is a **high-frequency RHCSA topic** and a core system administration skill.

---


