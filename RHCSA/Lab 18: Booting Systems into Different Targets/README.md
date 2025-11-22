# Lab 18: Booting Systems into Different Targets

This lab teaches how to control system boot behavior using systemd targets. You will learn how to switch between graphical, CLI, and rescue modes—critical for Linux system recovery, maintenance, and server administration.

## Objectives

Understand systemd targets and runlevels

Boot and switch into multi-user, graphical, and rescue modes

Configure default system targets

Troubleshoot boot and target-switching issues

## Prerequisites

Linux system using systemd (RHEL, CentOS, Fedora, Ubuntu, etc.)

Terminal access with sudo/root privileges

Basic command-line knowledge

## Task 1: Boot into Different systemd Targets
### 1.1 Check Current Default Target
```bash
systemctl get-default
```

Expected:
```bash
graphical.target (desktops) or multi-user.target (servers)
```
### 1.2 Switch to Multi-User Mode (No GUI)
```bash
sudo systemctl isolate multi-user.target
```

Switches system to CLI mode.

Verify:
```bash
systemctl get-default
```
### 1.3 Switch Back to Graphical Mode
```bash
sudo systemctl isolate graphical.target
```

Starts the GUI and loads desktop environment.

### 1.4 Boot into Rescue Mode

Reboot and interrupt GRUB

Press e

Append to kernel line:
```bash
systemd.unit=rescue.target
```

Press Ctrl + X to boot

System boots into a minimal rescue shell.

## Task 2: Understand and Configure systemd Targets
### 2.1 List All Available Targets
```bash
systemctl list-units --type=target --all
```

Shows system states like:
```bash
multi-user.target

graphical.target

rescue.target

emergency.target
```
### 2.2 Set Default Target

Set CLI as default:
```bash
sudo systemctl set-default multi-user.target
```

Verify:
```bash
systemctl get-default
```

Revert to GUI:
```bash
sudo systemctl set-default graphical.target
```
## Task 3: Switch Between Targets (Practice)
### 3.1 Temporary Switch (Without Changing Default)

Switch to CLI:
```bash
sudo systemctl isolate multi-user.target
```

Switch back to GUI:
```bash
sudo systemctl isolate graphical.target
```
### 3.2 Reboot Directly into Rescue Mode
```bash
sudo systemctl reboot --boot-loader-entry=rescue.target
```

Boots directly into rescue target.

## Troubleshooting Tips

Check failure logs:
```bash
journalctl -xe
```

Inspect dependencies:
```bash
systemctl list-dependencies <target>
```

If system hangs at boot, recheck GRUB parameters or revert to default target.

## Conclusion

In this lab, you learned how to:

Switch between graphical, multi-user, and rescue targets

Set a default boot target

Control system behavior using systemctl

Resolve common boot issues

Systemd target management is essential for system recovery, maintenance, and operating Linux servers efficiently.

⭐ More labs are coming soon! Keep visiting and supporting the repository.
