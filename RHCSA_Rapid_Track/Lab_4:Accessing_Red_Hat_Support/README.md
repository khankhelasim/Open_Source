# RHCSA Rapid Track – Lab 4: Accessing Red Hat Support

## 📘 Overview
This lab introduces the essential process of collecting diagnostic data, opening a support case with Red Hat, navigating the Red Hat Customer Portal, and escalating support cases when needed. These skills are critical for real-world enterprise support scenarios, especially in RHEL, containerized environments, and OpenShift development.

---

## 🎯 Objectives

By the end of this lab, you will be able to:

- Collect system diagnostic data using open-source tools
- Submit a support case through the Red Hat Customer Portal
- Search and use the Red Hat Knowledge Base
- Escalate a support case professionally

---

## 🧰 Prerequisites

- RHEL 8 / RHEL 9 or CentOS Stream (substitute used for labs)
- Valid Red Hat account (free developer account acceptable)
- Internet connectivity
- Basic command-line knowledge

---

# 🧪 Task 1: Collect System Diagnostic Data

---

## 🔹 Subtask 1.1: Gather Basic System Information

Install `inxi` (system info tool):

```bash
sudo dnf install -y inxi
inxi -Fxz
```
Kernel & OS details:
```bash
uname -a
cat /etc/os-release
```

Hardware info:
```bash
lscpu
free -h
lsblk
```

Expected Outcome:

Detailed system configuration and hardware information displayed.

Troubleshooting:

If inxi is missing:
```bash
sudo dnf install -y epel-release
sudo dnf install -y inxi
```
## 🔹 Subtask 1.2: Collect System Logs

Create a diagnostics directory:
```bash
mkdir ~/system_diagnostics
cd ~/system_diagnostics
```

Collect Journald logs:
```bash
journalctl --since "1 day ago" > system_journal.log
```

Collect kernel ring buffer:
```bash
dmesg > dmesg_output.log
```

List installed packages:
```bash
rpm -qa > installed_packages.list
```

Create compressed diagnostic bundle:
```bash
tar -czvf system_diagnostics_$(date +%Y%m%d).tar.gz *
```

Expected Outcome:

A tarball (system_diagnostics_<date>.tar.gz) containing logs and diagnostics.
# 🧪 Task 2: Submit a Support Case to Red Hat
## 🔹 Subtask 2.1: Access the Customer Portal

Go to:
```bash
https://access.redhat.com
```


If you don’t have an account, register here:
```bash
https://developers.redhat.com/register
```
## 🔹 Subtask 2.2: Create a Support Case

Navigate to:

Support → Open a Case

Fill out:

Product: Red Hat Enterprise Linux

Severity: 3 – Moderate

Subject: Short title describing issue

Description: Detailed explanation

Attach diagnostics: system_diagnostics_<date>.tar.gz

Submit the case.

Expected Outcome:

A new case number is generated, and you receive an email confirmation.

Note:

For lab practice, you may walk through the steps without submitting.

# 🧪 Task 3: Explore Knowledge Base & Escalation
## 🔹 Subtask 3.1: Search the Knowledge Base

Navigate to:

Knowledgebase


Search examples:

"Podman container startup failure"

"RHEL network connectivity issue"

Test a common issue:
```bash
podman run --rm hello-world
```

Expected Outcome:

You find articles addressing common RHEL and Podman issues.

## 🔹 Subtask 3.2: Escalate a Support Case

Go to Support → My Cases

Open your created case

Click Add Comment to update details

Click Request Escalation

Provide valid justification

Submit request

Expected Outcome:

Case status updates indicating escalation.

## 🧹 Final Task: Clean Up the Environment

Remove diagnostic files:
```bash
rm -rf ~/system_diagnostics
```
# 🎯 Conclusion

In this lab, you learned:

How to gather system diagnostics for support

How to submit a Red Hat support case

How to explore and use the Red Hat Knowledge Base

How to escalate support cases when needed

These skills are crucial for enterprise-grade troubleshooting in RHEL and container-based environments such as Podman and OpenShift.

🎉 Lab Complete!
