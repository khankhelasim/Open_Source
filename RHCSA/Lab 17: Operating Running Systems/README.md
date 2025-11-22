# Lab 17: Operating Running Systems

This lab focuses on managing system power operations, monitoring running processes, and terminating unresponsive applications. These skills are essential for Linux system administration and day-to-day troubleshooting.

## Objectives

Reboot, shut down, and schedule power operations

Monitor system processes using top, ps, and htop

Identify and kill misbehaving or unnecessary processes

## Prerequisites

Linux system (Ubuntu / CentOS / Fedora)

Terminal access with sudo privileges

Basic Linux command-line familiarity

## Task 1: Managing System Power States
### 1.1 Reboot the System
```bash
sudo reboot
```

Safely restarts the system.

### 1.2 Shut Down the System
```bash
sudo shutdown -h now
```

or
```bash
sudo poweroff
```
Immediately powers off the system.

### 1.3 Schedule a Shutdown
```bash
sudo shutdown -h +10 "System will shut down in 10 minutes"
```

Schedules shutdown and notifies logged-in users.

## Task 2: Monitoring System Processes
### 2.1 Real-Time Monitoring with top
```bash
top
```

Shows live CPU, memory, and process activity. Press q to exit.

### 2.2 Listing Processes with ps
```bash
ps aux
```

Displays all running processes in extended format.

### 2.3 Enhanced Monitoring with htop

Install if needed:
```bash
sudo apt install htop        # Ubuntu/Debian
sudo dnf install htop        # Fedora/CentOS
```

Run:
```bash
htop
```

Interactive, color-coded process viewer.

## Task 3: Terminating Processes
### 3.1 Find Process by Name
```bash
pgrep -l firefox
```
Returns the process ID (PID) of the application.

### 3.2 Kill a Process by PID
```bash
kill -9 <PID>
```

Forcefully terminates the process.

### 3.3 Kill Processes by Name
```bash
pkill -9 firefox
```

Terminates all processes matching the name.

Conclusion

In this lab, you learned how to:

Manage system power states

Monitor running processes

Terminate unresponsive programs

These operations form the foundation of system management and performance troubleshooting.

## Next Steps

Explore:

Managing services using systemctl

Adjusting process priority with nice and renice

Log analysis using journalctl

## Troubleshooting

Verify PID before killing:
```bash
ps aux | grep <process_name>
```

If power commands fail, check:
```bash
sudo -l
```

Use killall <name> if pkill does not work.

⭐ More labs will be added soon! Keep visiting and supporting the GitHub repo.
