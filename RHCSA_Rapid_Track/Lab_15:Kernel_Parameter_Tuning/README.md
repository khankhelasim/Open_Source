# Lab 15: Kernel Parameter Tuning

## 📌 **Overview**

This lab introduces **Linux kernel parameter tuning** using `sysctl`. You will learn how to view, modify, and persist kernel parameters, optimize networking and memory performance, and verify the impact of tuning changes on system behavior. Kernel tuning is a critical skill for **system administrators, performance engineers, and RHCSA candidates**.

---

## 🎯 **Objectives**

By the end of this lab, you will be able to:

* View Linux kernel parameters using `sysctl`
* Temporarily and permanently modify kernel parameters
* Tune networking and memory-related kernel settings
* Validate tuning changes through monitoring and testing

---

## 🧰 **Prerequisites**

* Linux system (RHEL, CentOS, Fedora, Ubuntu)
* Root or `sudo` privileges
* Basic command-line knowledge

---

# 📝 **Lab Tasks**

## **Task 1: View and Modify Kernel Parameters**

### 🔹 **1.1 View Current Kernel Parameters**

List all active kernel parameters:

```bash
sudo sysctl -a
```

View a specific parameter (example: `vm.swappiness`):

```bash
sudo sysctl vm.swappiness
```

📌 *Default value is usually `60`.*

---

### 🔹 **1.2 Temporarily Modify Kernel Parameters**

Reduce swap usage (valid until reboot):

```bash
sudo sysctl -w vm.swappiness=10
```

Verify the change:

```bash
sudo sysctl vm.swappiness
```

📌 *Lower values reduce disk swapping and improve performance for memory-heavy workloads.*

---

### 🔹 **1.3 Permanently Modify Kernel Parameters**

Edit sysctl configuration:

```bash
sudo nano /etc/sysctl.conf
```

Add or modify:

```text
vm.swappiness = 10
```

Apply changes immediately:

```bash
sudo sysctl -p
```

✅ *Changes persist across reboots.*

---

## **Task 2: Tune Networking and Memory Parameters**

### 🔹 **2.1 Optimize Network Performance**

Increase maximum open file descriptors:

```bash
sudo sysctl -w fs.file-max=100000
```

Enable TCP Fast Open:

```bash
sudo sysctl -w net.ipv4.tcp_fastopen=3
```

Verify settings:

```bash
sudo sysctl fs.file-max net.ipv4.tcp_fastopen
```

📌 *Improves performance for high-connection network services.*

---

### 🔹 **2.2 Adjust Memory Management Settings**

Allow memory overcommitment:

```bash
sudo sysctl -w vm.overcommit_memory=1
```

Disable hugepages (useful for databases):

```bash
sudo sysctl -w vm.nr_hugepages=0
```

Verify:

```bash
sudo sysctl vm.overcommit_memory vm.nr_hugepages
```

---

## **Task 3: Test the Impact of Kernel Tuning**

### 🔹 **3.1 Monitor System Performance**

Check memory usage:

```bash
free -h
```

View network socket statistics:

```bash
ss -s
```

---

### 🔹 **3.2 Simulate Workload and Observe Behavior**

Install stress testing tools:

```bash
sudo apt install stress-ng -y   # Debian/Ubuntu
sudo yum install stress-ng -y   # RHEL/CentOS
```

Run memory stress test:

```bash
stress-ng --vm 2 --vm-bytes 2G --timeout 60s
```

Monitor during load:

```bash
top
```

📌 *System should handle memory pressure more efficiently with reduced swapping.*

Optional network testing:

```bash
iperf3 -c <server-ip>
```

---

## 🛠 **Troubleshooting Tips**

* Ensure `/etc/sysctl.conf` syntax is correct
* Reload settings using:

```bash
sudo sysctl -p
```

* Check kernel logs:

```bash
dmesg | tail
```

* Revert changes by removing entries and reloading sysctl

---

## ✅ **Lab Completed**

You have successfully:

* Viewed and modified kernel parameters using `sysctl`
* Tuned networking and memory performance settings
* Verified the impact of kernel tuning through monitoring

These skills are essential for **performance tuning, production system optimization, and RHCSA exam readiness**.

---

## 🚀 **Next Steps**

* Tune additional parameters (`net.core.somaxconn`, `vm.dirty_ratio`)
* Automate kernel tuning using shell scripts or Ansible
* Apply tuning profiles for databases and container workloads

---

**End of Lab 15**
