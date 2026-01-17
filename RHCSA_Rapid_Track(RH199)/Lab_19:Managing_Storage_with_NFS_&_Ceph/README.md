# Lab 19: Managing Storage with NFS and Ceph

## Objectives

By the end of this lab, students will be able to:

* Configure and deploy an **NFS (Network File System)** server for shared storage
* Set up a **Ceph distributed storage cluster** for block storage
* Integrate **NFS and Ceph with Kubernetes**
* Understand differences between **network-attached storage (NFS)** and **distributed block storage (Ceph)**
* Configure **Persistent Volumes (PV)** and **Persistent Volume Claims (PVC)** in Kubernetes
* Troubleshoot common storage-related issues

---

## Prerequisites

Before starting this lab, students should have:

* Basic understanding of Linux command-line operations
* Familiarity with file systems and storage concepts
* Basic knowledge of Kubernetes (pods, deployments, PVs, PVCs)
* Understanding of basic network configuration
* Experience with text editors such as `vi/vim` or `nano`

---

## Lab Environment


* 4 × CentOS/RHEL 8 virtual machines
* Docker and Kubernetes pre-installed
* Network connectivity between all machines
* Root or sudo access on all systems

---


## Conclusion

In this lab, you successfully:

* Deployed **NFS shared storage** for multi-client access
* Implemented **Ceph distributed block storage** with redundancy
* Integrated both storage backends into **Kubernetes**
* Used **StorageClasses** for dynamic provisioning

### Key Takeaways

* NFS is ideal for shared file access (RWX)
* Ceph provides scalable, fault-tolerant block storage
* Kubernetes storage integration is essential for stateful workloads

This lab builds strong foundations for **enterprise storage management**, **Kubernetes administration**, and **Red Hat/OpenShift certification paths**.
