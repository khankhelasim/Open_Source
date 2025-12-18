# Lab 14: Adjusting Process Priorities (nice & renice)

## 📌 Overview

This lab focuses on **Linux process priority management**, a core RHCSA skill. You will learn how Linux schedules processes, how to start processes with specific priorities using `nice`, how to modify running processes with `renice`, and how to **observe real performance impact** using monitoring tools.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

* Understand Linux process priority and nice values
* Start processes with custom priorities using `nice`
* Modify running process priorities using `renice`
* Observe CPU scheduling behavior using monitoring tools
* Optimize system responsiveness through priority tuning

---

## 🧰 Prerequisites

* Linux system (Fedora / RHEL / CentOS recommended)
* Basic command-line knowledge
* Root or sudo privileges
* System monitoring tools (`htop`, `glances`)

---

## ⚙️ Setup Requirements

Install monitoring tools:

```bash
sudo dnf install htop glances -y
```

Verify installation:

```bash
which htop glances
```

---

# 📝 Lab Tasks

## Task 1: Starting Processes with Different Priorities (nice)

### 🔹 1.1 Understanding Nice Values

* Priority range: **-20 (highest)** to **19 (lowest)**
* Default nice value: **0**
* Regular users can only **increase nice value** (lower priority)
* Root can assign **any priority**

---

### 🔹 1.2 Launch a Low-Priority Process

```bash
nice -n 19 sha1sum /dev/zero &
```

Expected output (PID will vary):

```
[1] 12345
```

---

### 🔹 1.3 Launch a High-Priority Process (Root Only)

```bash
sudo nice -n -20 sha1sum /dev/zero &
```

---

### 🔹 1.4 Verify Process Priorities

```bash
ps -l -p $(pgrep sha1sum)
```

Sample output:

```
F S   UID   PID  PPID  C PRI  NI CMD
0 R     0 12346  4567 99  60 -20 sha1sum /dev/zero
0 R     0 12345  4567 99  80  19 sha1sum /dev/zero
```

📌 **Key Fields**:

* `PRI` → Kernel priority
* `NI` → Nice value

---

## Task 2: Modifying Running Process Priorities (renice)

### 🔹 2.1 Identify Target Process

```bash
pgrep sha1sum
```

---

### 🔹 2.2 Increase Priority of a Running Process

```bash
sudo renice -n -10 -p 12345
```

Expected output:

```
12345: old priority 0, new priority -10
```

---

### 🔹 2.3 Verify Priority Change

```bash
ps -o pid,ni,cmd -p 12345
```

---

### 🔹 2.4 Decrease Priority of All User Processes

```bash
renice -n 10 -u $(whoami)
```

---

## Task 3: Monitoring Priority Impact on CPU Usage

### 🔹 3.1 Launch Monitoring Tool

```bash
htop
```

🔍 **Observe**:

* Nice (NI) column
* CPU% allocation
* Scheduling differences

---

### 🔹 3.2 Create CPU Load with Multiple Priorities

```bash
for i in {1..4}; do nice -n $((i*5)) sha1sum /dev/zero & done
```

---

### 🔹 3.3 Analyze in htop

* Press **F6** → Sort by priority
* Observe:

  * CPU usage differences
  * Nice (NI) values

---

### 🔹 3.4 Cleanup Test Processes

```bash
pkill sha1sum
```

---

## 🛠 Troubleshooting Tips

* ❌ Permission denied for negative nice values → use `sudo`
* 🔍 Verify priority with:

```bash
ps -o pid,pri,ni,cmd -p <PID>
```

* 📖 Read manuals:

```bash
man nice
man renice
```

---

## ✅ Lab Completed

You have successfully learned:

* How to assign priorities at process start
* How to modify priorities of running processes
* How Linux scheduling reacts to priority changes
* Best practices for performance optimization

These skills are essential for **system performance tuning**, **RHCSA certification**, and **real-world Linux administration**.

---

## 🚀 Next Steps

* Write scripts that launch processes with predefined priorities
* Explore **cgroups** for advanced resource control
* Configure systemd services with custom CPU priorities

---

**End of Lab 14**
