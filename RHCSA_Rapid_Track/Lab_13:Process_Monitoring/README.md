# Lab 13: Process Monitoring

## Objectives

By the end of this lab, you will be able to:

* Monitor system processes using `top`, `ps`, and `htop`
* Identify CPU- and memory-intensive processes causing performance bottlenecks
* Optimize system performance by killing or renicing processes

---

## Prerequisites

* A Linux-based system (Ubuntu, CentOS, RHEL, Fedora)
* Basic familiarity with the Linux command line
* Administrative (sudo) privileges
* `htop` installed on the system

---

## Lab Setup

### Install Required Tools

Ensure `htop` is installed:

```bash
# Debian / Ubuntu
sudo apt update && sudo apt install -y htop

# CentOS / RHEL
sudo yum install -y epel-release
sudo yum install -y htop

# Fedora
sudo dnf install -y htop
```

**Expected Outcome:**

* `htop` is successfully installed and ready for use

---

## Task 1: View Running Processes

### Task 1.1: Monitor Processes Using `top`

Run:

```bash
top
```

**Key Observations:**

* `%CPU` → CPU usage per process
* `%MEM` → Memory usage per process
* `PID` → Process ID

Exit by pressing **`q`**.

**Expected Outcome:**

* A real-time, dynamic view of system processes sorted by CPU usage

---

### Task 1.2: View Processes Using `ps`

Run:

```bash
ps aux
```

**Explanation of Flags:**

* `a` → Processes from all users
* `u` → User-oriented output
* `x` → Processes without a terminal

**Expected Outcome:**

* A complete snapshot of all running processes

---

### Task 1.3: Monitor Processes Using `htop`

Launch:

```bash
htop
```

**Key Features:**

* Color-coded CPU and memory usage
* Tree view (`F5`) for parent-child relationships
* Sorting (`F6`) by CPU or memory

Exit using **`F10`** or **`q`**.

**Expected Outcome:**

* An interactive and user-friendly process monitoring interface

---

## Task 2: Identify Resource Bottlenecks

### Task 2.1: Find High CPU Usage Processes

```bash
ps aux --sort=-%cpu | head -n 5
```

**Expected Outcome:**

* Top 5 CPU-consuming processes

---

### Task 2.2: Find High Memory Usage Processes

```bash
ps aux --sort=-%mem | head -n 5
```

**Expected Outcome:**

* Top 5 memory-consuming processes

---

### Task 2.3: Check System Load Average

```bash
uptime
```

**Explanation:**

* Load averages (1, 5, 15 minutes)
* Values higher than CPU core count indicate system stress

**Expected Outcome:**

* System load averages displayed

---

## Task 3: Optimize System Performance

### Task 3.1: Kill a Process

Terminate a non-critical process:

```bash
kill <PID>
```

Force termination (use cautiously):

```bash
kill -9 <PID>
```

**Expected Outcome:**

* The selected process is terminated

---

### Task 3.2: Renice a Process

Lower the priority of a CPU-intensive process:

```bash
sudo renice -n 10 -p <PID>
```

**Niceness Range:**

* `-20` → Highest priority
* `19` → Lowest priority

**Expected Outcome:**

* Process priority successfully adjusted

---

## Conclusion

In this lab, you successfully:

* Monitored system processes using `top`, `ps`, and `htop`
* Identified CPU and memory bottlenecks
* Optimized system performance through process termination and priority tuning

These skills are essential for **Linux system administration**, **performance troubleshooting**, and **RHCSA exam preparation**.

---

## Next Steps

* Automate monitoring using scripts and cron jobs
* Explore advanced tools like `glances` or `nmon`
* Analyze logs using `journalctl` for persistent performance issues

---

## Final Verification

```bash
echo "Lab 13 - Process Monitoring completed successfully!"
```

**Expected Output:**

* Confirmation message displayed

---

## Troubleshooting Appendix

* **Permission denied:** Use `sudo` for kill/renice operations
* **Process not found:** Verify PID using `ps aux | grep <process>`
* **High load persists:** Inspect system logs using `dmesg` or `journalctl`

---

🎉 **Lab 13 Completed Successfully**
