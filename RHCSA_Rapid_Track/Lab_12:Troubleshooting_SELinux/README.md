# Lab 12: Troubleshooting SELinux

## Objectives

By the end of this lab, you will be able to:

* Identify SELinux denials using system audit logs
* Analyze AVC (Access Vector Cache) messages
* Create and apply custom SELinux policy modules
* Use `audit2allow` to resolve SELinux access issues safely

---

## Prerequisites

* Linux system with **SELinux enabled** (RHEL / CentOS / Fedora recommended)
* Root or sudo privileges
* Basic understanding of Linux commands and SELinux concepts
* Required packages installed:

```bash
sudo dnf install -y policycoreutils-python-utils setools-console audit
```

---

## Task 1: Identify SELinux Denials Using Logs

### Subtask 1.1: Verify SELinux Status

Check whether SELinux is enabled and enforcing:

```bash
sestatus
```

**Expected Output:**

```
SELinux status:                 enabled
SELinuxfs mount:               /sys/fs/selinux
SELinux root directory:        /etc/selinux
Current mode:                  enforcing
```

If SELinux is not enforcing, enable it temporarily:

```bash
sudo setenforce 1
```

---

### Subtask 1.2: Analyze SELinux Denials in Audit Logs

Search for recent SELinux AVC denials:

```bash
sudo ausearch -m avc -ts recent
```

**Example Output:**

```
type=AVC msg=audit(1234567890.123:456): avc: denied { read } for pid=1234 comm="nginx" \
name="index.html" scontext=system_u:system_r:httpd_t:s0 \
tcontext=unconfined_u:object_r:default_t:s0 tclass=file
```

Alternatively, search directly in audit logs:

```bash
sudo grep "avc:.*denied" /var/log/audit/audit.log
```

**Troubleshooting Tip:**
If no denials appear, deliberately trigger one (for example, move a file to `/var/www/html` with an incorrect context).

---

## Task 2: Create Custom SELinux Policies

### Subtask 2.1: Generate a Policy Module Using `audit2allow`

Generate a custom policy from recent denials:

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mypolicy
```

**Expected Output:**

```
Generating type enforcement file: mypolicy.te
Compiling policy: checkmodule
Building policy package: mypolicy.pp
```

Apply the generated policy module:

```bash
sudo semodule -i mypolicy.pp
```

---

### Subtask 2.2: Verify Policy Installation

Confirm the policy module is loaded:

```bash
sudo semodule -l | grep mypolicy
```

**Expected Output:**

```
mypolicy
```

**Troubleshooting Tip:**
If the issue persists, additional denials may exist—review logs again and refine the policy.

---

## Task 3: Generate and Apply SELinux Rules

### Subtask 3.1: Review Generated Rules

View human-readable SELinux rules from audit logs:

```bash
sudo ausearch -m avc -ts recent | audit2allow
```

**Example Output:**

```bash
allow httpd_t default_t:file read;
```

Automatically generate and apply a new policy:

```bash
sudo ausearch -m avc -ts recent | audit2allow -M mynewpolicy
sudo semodule -i mynewpolicy.pp
```

---

### Subtask 3.2: Test the Applied Policy

* Retry the action that previously caused the denial
* Verify no new denials appear:

```bash
sudo ausearch -m avc -ts recent
```

**Troubleshooting Tip:**
If issues remain, consider fixing file labels instead of policies using:

```bash
restorecon -Rv /path/to/file
```

---

## Conclusion

In this lab, you successfully:

* Identified SELinux denials using audit logs
* Analyzed AVC messages for root cause
* Generated and installed custom SELinux policies
* Used `audit2allow` to safely resolve access issues

Mastering SELinux troubleshooting is a **critical RHCSA skill** and essential for maintaining secure, production-grade Linux systems.

---

## Next Steps

* Explore SELinux booleans using `getsebool` and `setsebool`
* Practice fixing issues with `restorecon` instead of custom policies
* Review real-world SELinux cases from web and database services

---

✅ **Lab Complete!** 🎉
