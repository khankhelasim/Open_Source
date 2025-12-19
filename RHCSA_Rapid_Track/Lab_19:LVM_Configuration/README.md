# Lab 19: LVM Configuration

## Objectives

By completing this lab, you will be able to:

* Understand and configure Logical Volume Manager (LVM) for flexible storage management
* Create and manage Physical Volumes (PVs), Volume Groups (VGs), and Logical Volumes (LVs)
* Perform storage operations including extending and shrinking logical volumes

---

## Prerequisites

* Linux system (RHEL / CentOS / Fedora recommended)
* Root or sudo privileges
* Unallocated disk space or additional disks (physical or virtual)
* Basic familiarity with Linux command line and storage concepts

---

## Lab Setup

Ensure you have available storage devices such as:

* Unpartitioned disks (e.g., `/dev/sdb`, `/dev/sdc`)
* Unused disk partitions
* Loop devices (for testing environments)

Verify available disks:

```bash
lsblk
sudo fdisk -l
```

---

## Task 1: Create Physical Volumes (PVs) and Volume Groups (VGs)

### Subtask 1.1: Create Physical Volume

Identify the disk or partition to use (example: `/dev/sdb`).

Create a physical volume:

```bash
sudo pvcreate /dev/sdb
```

Verify PV creation:

```bash
sudo pvdisplay
```

**Expected Output:**

* Displays PV size, PE size, and free space information

**Troubleshooting:**

* If device is mounted, unmount it: `sudo umount /dev/sdb`
* If partitions exist, wipe signatures:

```bash
sudo wipefs -a /dev/sdb
```

---

### Subtask 1.2: Create Volume Group

Create a volume group named `vg01`:

```bash
sudo vgcreate vg01 /dev/sdb
```

Verify VG creation:

```bash
sudo vgdisplay vg01
```

**Expected Output:**

* VG name, size, number of PVs, and free space

---

## Task 2: Create Logical Volumes (LVs) and Format Them

### Subtask 2.1: Create Logical Volume

Create a 5GB logical volume named `lv01`:

```bash
sudo lvcreate -L 5G -n lv01 vg01
```

Verify LV creation:

```bash
sudo lvdisplay /dev/vg01/lv01
```

**Expected Output:**

* LV path, size, and status

---

### Subtask 2.2: Format and Mount Logical Volume

Format the LV with ext4 filesystem:

```bash
sudo mkfs.ext4 /dev/vg01/lv01
```

Create mount point and mount:

```bash
sudo mkdir /mnt/lv01
sudo mount /dev/vg01/lv01 /mnt/lv01
```

Verify mount:

```bash
df -h /mnt/lv01
```

**Expected Output:**

* Mounted filesystem showing approximately 5GB capacity

**Troubleshooting:**

* Check kernel logs: `dmesg`
* Ensure mount directory exists

---

## Task 3: Extend and Shrink Logical Volumes

### Subtask 3.1: Extend Logical Volume

Extend LV by 2GB:

```bash
sudo lvextend -L +2G /dev/vg01/lv01
```

Resize filesystem:

```bash
sudo resize2fs /dev/vg01/lv01
```

Verify size:

```bash
df -h /mnt/lv01
```

**Expected Output:**

* Filesystem shows approximately 7GB

---

### Subtask 3.2: Shrink Logical Volume

⚠️ **Warning:** Shrinking can cause data loss. Always back up first.

Unmount filesystem:

```bash
sudo umount /mnt/lv01
```

Check filesystem:

```bash
sudo e2fsck -f /dev/vg01/lv01
```

Resize filesystem to 4GB:

```bash
sudo resize2fs /dev/vg01/lv01 4G
```

Reduce LV size:

```bash
sudo lvreduce -L 4G /dev/vg01/lv01
```

Remount and verify:

```bash
sudo mount /dev/vg01/lv01 /mnt/lv01
df -h /mnt/lv01
```

**Expected Output:**

* Filesystem shows approximately 4GB

---

## Advanced Operations (Optional)

### Create LVM Snapshot

Create snapshot of `lv01`:

```bash
sudo lvcreate -s -n lv01_snap -L 1G /dev/vg01/lv01
```

Mount snapshot:

```bash
sudo mkdir /mnt/snap
sudo mount /dev/vg01/lv01_snap /mnt/snap
```

---

## Troubleshooting Tips

* Activate VGs if not visible:

```bash
sudo vgscan
sudo vgchange -ay
```

* Check logs:

```bash
journalctl -xe
```

* Use thin provisioning with `lvcreate -T` for advanced scenarios

---

## Conclusion

In this lab, you:

* Created and managed Physical Volumes, Volume Groups, and Logical Volumes
* Formatted and mounted LVM-based filesystems
* Performed dynamic resize operations (extend and shrink)
* (Optional) Created and mounted LVM snapshots

LVM is a critical skill for Linux system administrators, enabling flexible and scalable storage management.

---

## Cleanup (Optional)

Remove lab resources:

```bash
sudo umount /mnt/lv01
sudo lvremove /dev/vg01/lv01
sudo vgremove vg01
sudo pvremove /dev/sdb
```

---

## Further Reading

* `man lvm`
* Red Hat Storage Administration Guide (RHCSA / RHCE)
* Linux Documentation Project: LVM HOWTO

---

✅ **Lab 19 Complete!**
