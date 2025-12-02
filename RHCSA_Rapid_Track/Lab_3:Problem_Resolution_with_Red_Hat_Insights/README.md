# RHCSA Rapid Track – Lab 3: Problem Resolution with Red Hat Insights

## 📘 Overview
This lab focuses on using **Red Hat Insights** to proactively detect, analyze, and resolve system issues. Insights provides predictive analytics, security checks, compliance monitoring, and automated recommendations to keep Red Hat Enterprise Linux (RHEL) systems healthy and secure.

---

## 🎯 Objectives

By completing this lab, you will:

- Register a RHEL system with Red Hat Insights  
- Perform system data analysis and health checks  
- Review Insights recommendations  
- Apply automated fixes to address system issues  

---

## 🧰 Prerequisites

- RHEL 8 or RHEL 9 system  
- Active Red Hat subscription  
- Root or sudo privileges  
- Internet connectivity  
- `insights-client` installed  

---

# ⚙️ Lab Setup

## ✅ Verify System Subscription

Register your system with Red Hat Subscription Manager (RHSM):

```bash
sudo subscription-manager register --username <your_username> --password <your_password>
sudo subscription-manager attach --auto
```
✅ Install Red Hat Insights Client
```bash
sudo dnf install -y insights-client
```
## 📝 Tasks
### Task 1: Set Up Red Hat Insights
#### 🔹 Step 1.1: Register the System with Insights
```bash
sudo insights-client --register
```

Expected Outcome:
```bash
Your system is successfully registered with Red Hat Insights.
```
#### Troubleshooting:
If registration fails:

Verify RHSM subscription

Check internet access

Ensure DNS is configured properly

#### 🔹 Step 1.2: Run Initial System Analysis
```bash
sudo insights-client
```

Expected Outcome:
```bash
System metadata is collected and uploaded to the Insights dashboard.
```
### Task 2: Investigate Health Checks and Recommendations
#### 🔹 Step 2.1: Access the Red Hat Insights Dashboard

Open a browser and go to the Red Hat Customer Portal.

Navigate to:

Red Hat Insights → Systems


You will see your registered RHEL system.

Insights organizes issues into:

Availability

Performance

Security

Stability

#### 🔹 Step 2.2: Review Recommendations

Click on your system to review issues categorized by severity:

Critical

Important

Moderate

Expected Outcome:
```bash
A clear list of recommendations such as:

Packages needing urgent updates

Vulnerabilities

Misconfigurations

Performance bottlenecks
```
### Task 3: Implement Recommended Fixes
#### 🔹 Step 3.1: Apply a Recommended Update

If Insights recommends updating a package:
```bash
sudo dnf update <package_name> -y
```

Expected Outcome:

The package is updated and the associated issue is resolved.

#### 🔹 Step 3.2: Resolve Configuration Issues

If a configuration file (e.g., SSH) needs correction:

Edit the file:
```bash
sudo vi /etc/ssh/sshd_config
```

Apply the recommended fix, such as:

PermitRootLogin no


Restart SSH:

sudo systemctl restart sshd


Expected Outcome:

Configuration issue is fixed and removed from Insights.

#### 🔹 Step 3.3: Verify Fixes in Insights

Re-upload data:
```bash
sudo insights-client
```

Expected Outcome:

Resolved issues no longer appear on the dashboard.

## 🎯 Conclusion

In this lab, you successfully:

Registered your RHEL system with Red Hat Insights

Performed system analysis and collected health data

Investigated and reviewed critical recommendations

Implemented updates and configuration fixes

Verified remediation through Insights

## 🔑 Key Takeaway

Red Hat Insights delivers proactive monitoring, security validation, and automated remediation guidance, dramatically reducing troubleshooting effort and improving system reliability.

## 🚀 Next Steps

Explore Insights Advisor, Vulnerability, and Compliance services

Automate fixes using Insights Playbooks

Continue with the next RHCSA Rapid Track lab

🎉 Lab Complete!
