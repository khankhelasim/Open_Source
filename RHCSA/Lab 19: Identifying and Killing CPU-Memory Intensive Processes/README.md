# Lab 19: Identifying and Killing CPU/Memory Intensive Processes

This lab focuses on monitoring system performance, identifying resource-heavy processes, and managing them effectively using Linux process control tools. These skills are essential for troubleshooting and maintaining system stability.

## Objectives

Monitor processes using top and ps

Identify CPU- or memory-intensive processes

Terminate misbehaving processes safely

Adjust process priorities using nice and renice

Understand core process management concepts in Linux

## Prerequisites

Linux system (RHEL, CentOS, Fedora, Ubuntu)

Terminal access

Basic command-line knowledge

sudo privileges for process control

## Task 1: Monitoring Processes
### 1.1 Using top for Real-Time Monitoring

Run:
```bash
top
```

Observe:

CPU usage (user, system, idle)

Memory stats (total, free, used)

Processes sorted by CPU usage

Useful keys inside top:

M → Sort by memory

P → Sort by CPU

q → Quit

### 1.2 Using ps for Detailed Analysis

List all running processes:
```bash
ps aux
```

Top 5 CPU-consuming processes:
```bash
ps aux --sort=-%cpu | head -6
```

Top 5 memory-consuming processes:
```bash
ps aux --sort=-%mem | head -6
```

If output is too long:
```bash
ps aux | less
```
## Task 2: Terminating Processes
### 2.1 Graceful Termination (SIGTERM)

Find a PID:
```bash
pidof firefox
# or
pgrep -l firefox
```

Terminate gracefully:
```bash
kill <PID>
```

Verify:
```bash
ps -p <PID>
```
### 2.2 Forceful Kill (SIGKILL)

Use only if SIGTERM fails:
```bash
kill -9 <PID>
```

This forcibly stops the process.

### 2.3 Kill Multiple Processes

Terminate all instances of a process:
```bash
killall chrome
```

Forceful kill:
```bash
killall -9 chrome
```

⚠️ Use with caution—may cause data loss.

## Task 3: Adjusting Process Priorities
### 3.1 Launch a Process with nice

Run a task with low priority:
```bash
nice -n 19 tar -czf backup.tar.gz /large_directory
```

Nice values:

-20 → Highest priority

19 → Lowest priority

### 3.2 Change Priority Using renice

Find the process in top (check the NI column).

Change priority:
```bash
sudo renice -n 10 -p <PID>
```

Only root can increase priority (lower the nice value).

## Conclusion

You now understand how to:

Monitor system load using top and ps

Identify CPU/memory-heavy processes

Gracefully or forcibly terminate processes

Control process scheduling using nice and renice

These skills are vital in performance troubleshooting and in environments like servers, Kubernetes nodes, or OpenShift clusters.

## Additional Exercises

Create a script to log top 3 CPU-hungry processes every minute

Experiment with cgroups for resource limits

Add CPU/memory limits to systemd services

## References

man top, man ps, man kill, man nice

Red Hat System Administration Documentation

General Linux Performance Analysis Techniques
