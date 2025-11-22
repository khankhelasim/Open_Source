# Lab 20: Adjusting Process Scheduling

## Objectives
- Modify process priorities using nice and renice
- Monitor and optimize performance using top and htop
- Understand process states and adjust scheduling dynamically

---

## Task 1: Changing Process Priority Using nice and renice

### Subtask 1.1: Launch a Test Process
Run a CPU-intensive task:
```bash
sha1sum /dev/zero &
```
### Subtask 1.2: Check Default Priority
```bash
ps -l -p $(pgrep sha1sum)
```

Default NI should be 0.

### Subtask 1.3: Adjust Priority Using nice

Start a new process with lower priority:
```bash
nice -n 10 sha1sum /dev/zero &
```

Verify:
```bash
ps -l -p $(pgrep sha1sum | tail -1)
```
### Subtask 1.4: Adjust Priority of Running Process Using renice
```bash
sudo renice -n 5 -p $(pgrep sha1sum | head -1)
```

Confirm:
```bash
ps -l -p $(pgrep sha1sum | head -1)
```
## Task 2: Monitoring Processes with top and htop
### Subtask 2.1: Use top
```bash
top
```

Observe:

PR (Priority)

NI (Nice)

CPU usage

Press q to quit.

### Subtask 2.2: Install and Use htop

Install:
```bash
sudo apt install htop
sudo dnf install htop
```

Run:
```bash
htop
```

Features:

Color-coded CPU/memory

Tree view

Change priority with F7/F8

Exit: F10

## Task 3: Understanding Process States & Dynamic Adjustments
### Subtask 3.1: Identify Process States
```bash
ps aux
```
### Subtask 3.2: Kill a Low-Priority Process
```bash
kill $(pgrep sha1sum)
```
### Subtask 3.3: Optional — Adjust Scheduling Policy
```bash
sudo chrt -f -p 99 $(pgrep sha1sum)
```
## Conclusion

You have learned to:

Modify process priority with nice and renice

Monitor performance with top and htop

Understand process states and dynamic scheduling
