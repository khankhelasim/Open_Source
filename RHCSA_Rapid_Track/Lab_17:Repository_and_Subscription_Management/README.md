# Lab 17: Repository and Subscription Management

## Objectives

By the end of this lab, you will be able to:

* Register a system with Red Hat Subscription Manager (RHSM)
* Enable and disable repositories for software management
* Install software from enabled repositories

---

## Prerequisites

* A Red Hat Enterprise Linux (RHEL) 8 or 9 system
* Root or sudo access
* Active Red Hat subscription credentials
* Internet connectivity
* `subscription-manager` and `dnf` packages installed (default on RHEL)

---

## Lab Setup

Ensure your system is up to date:

```bash
sudo dnf update -y
```

---

## Task 1: Register System with Red Hat Subscription Manager

### Step 1.1: Verify Current Subscription Status

```bash
sudo subscription-manager status
```

**Expected Output:**

* `Overall Status: Unknown` (if unregistered)
* Subscription details (if already registered)

---

### Step 1.2: Register the System

Replace `<username>` and `<password>` with your Red Hat credentials:

```bash
sudo subscription-manager register --username=<username> --password=<password>
```

#### Troubleshooting Options

* **Behind a proxy:**

```bash
sudo subscription-manager register \
--username=<username> \
--password=<password> \
--proxy=<proxy_URL> \
--proxyuser=<proxy_user> \
--proxypassword=<proxy_password>
```

* **Using an activation key (recommended for organizations):**

```bash
sudo subscription-manager register --org=<org_ID> --activationkey=<key>
```

---

### Step 1.3: Attach a Subscription Automatically

```bash
sudo subscription-manager attach --auto
```

#### Verification

```bash
sudo subscription-manager list --consumed
```

---

## Task 2: Manage Software Repositories

### Step 2.1: List Available Repositories

```bash
sudo subscription-manager repos --list
```

---

### Step 2.2: Enable a Repository (Example: CodeReady Builder)

```bash
sudo subscription-manager repos --enable=codeready-builder-for-rhel-9-$(arch)-rpms
```

---

### Step 2.3: Disable a Repository

```bash
sudo subscription-manager repos --disable=codeready-builder-for-rhel-9-$(arch)-rpms
```

---

### Step 2.4: Verify Enabled Repositories

```bash
sudo dnf repolist enabled
```

---

## Task 3: Install Software from Repositories

### Step 3.1: Search for a Package (Example: Podman)

```bash
sudo dnf search podman
```

---

### Step 3.2: Install the Package

```bash
sudo dnf install -y podman
```

---

### Step 3.3: Verify Installation

```bash
podman --version
```

**Expected Output:**

```
podman version 4.x.x
```

---

## Conclusion

In this lab, you successfully:

* Registered a RHEL system with Red Hat Subscription Manager
* Attached a valid subscription
* Enabled and disabled software repositories
* Installed software using Red Hat-provided repositories

---

## Key Concepts

* **Subscription Management:** Required to access Red Hat official repositories
* **Repository:** A source location that provides RPM packages
* **DNF:** The default and modern package manager for RHEL 8/9

---

## Troubleshooting Tips

* **Registration Errors:** Check internet connectivity and credentials
* **Missing Repositories:** Ensure a valid subscription is attached
* **Package Not Found:** Verify enabled repositories using `dnf repolist`

---

## Next Steps

* Explore advanced repository management using `dnf config-manager`
* Configure custom or third-party repositories
* Practice repository pinning and priority management

---
