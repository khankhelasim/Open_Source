# Lab 18: Disk Partitioning and Formatting

## Objectives

By the end of this lab, you will be able to:

* Understand disk partitioning concepts in Linux
* Create disk partitions using **fdisk** and **parted**
* Format partitions with different filesystems using **mkfs**
* Configure **persistent mounts** using `/etc/fstab`

---

## Prerequisites

* A Linux system (RHEL / CentOS / Rocky / Alma Linux preferred)
* Root or sudo access
* An **additional unused disk** (physical or virtual)
* Basic Linux command-line knowledge
* Required packages:

  ```bash
  sudo dnf install -y util-linux parted e2fsprogs
  ```

---

## Lab Setup

Verify available disks:

```bash
lsblk
```

Identify the unused target disk.

> ⚠️ **Note:** Examples use `/dev/sdb`. Replace it with your actual unused disk.

---

## Task 1: Partitioning a Disk

### Subtask 1.1: Partitioning Using fdisk

Start fdisk on the target disk:

```bash
sudo fdisk /dev/sdb
```

Common `fdisk` commands:

* `n` → Create new partition
* `p` → Print partition table
* `d` → Delete a partition
* `t` → Change partition type
* `w` → Write changes and exit
* `q` → Quit without saving

Create a 5GB primary partition:

```
n → p → 1 → (default first sector) → +5G → w
```

### Expected Result

* New partition created as `/dev/sdb1`

---

### Subtask 1.2: Partitioning Using parted (Alternative)

Start parted:

```bash
sudo parted /dev/sdb
```

Create GPT label and partition:

```bash
mklabel gpt
mkpart primary ext4 1MiB 5GiB
print
quit
```

> 🛠 **Troubleshooting Tip:** If you see *"unrecognized disk label"*, always create a disk label first using `mklabel`.

---

## Task 2: Formatting Partitions

### Subtask 2.1: Create a Filesystem

Format the partition as **ext4**:

```bash
sudo mkfs.ext4 /dev/sdb1
```

(Optional) Format as **XFS**:

```bash
sudo mkfs.xfs /dev/sdb1
```

Verify filesystem creation:

```bash
sudo blkid /dev/sdb1
```

### Expected Result

* Filesystem type and UUID are displayed

---

## Task 3: Mounting and Persistent Configuration

### Subtask 3.1: Temporary Mount

Create a mount point:

```bash
sudo mkdir /mnt/mydata
```

Mount the partition:

```bash
sudo mount /dev/sdb1 /mnt/mydata
```

Verify:

```bash
df -hT /mnt/mydata
```

---

### Subtask 3.2: Persistent Mount Using /etc/fstab

Get the UUID:

```bash
sudo blkid /dev/sdb1
```

Edit `/etc/fstab`:

```bash
sudo nano /etc/fstab
```

Add the following entry (example for ext4):

```
UUID=your-uuid-here   /mnt/mydata   ext4   defaults   0   2
```

Test configuration:

```bash
sudo mount -a
```

Reboot and verify:

```bash
sudo reboot

df -hT /mnt/mydata
```

> ⚠️ **Important:** Incorrect fstab entries can prevent boot. Always test with `mount -a`.

---

## Advanced Exercise (Optional)

### Create a Swap Partition

Create a swap partition:

```bash
sudo fdisk /dev/sdb
```

(Change partition type to **82 - Linux swap**)

Format and enable swap:

```bash
sudo mkswap /dev/sdb2
sudo swapon /dev/sdb2
```

Add to `/etc/fstab`:

```
/dev/sdb2   none   swap   sw   0   0
```

Verify:

```bash
swapon --show
```

---

## Conclusion

In this lab, you successfully:

* Created disk partitions using **fdisk** and **parted**
* Formatted partitions with different filesystems
* Configured both temporary and persistent mount points
* Verified storage configuration at every step

These skills are **critical for RHCSA**, real-world Linux administration, and understanding persistent storage concepts used in containers and OpenShift.

---

## Cleanup (Optional)

To revert changes:

```bash
sudo umount /mnt/mydata
```

* Remove the `/etc/fstab` entry
* Delete partitions using `fdisk` or `parted`

---

## Additional Resources

* `man fdisk`
* `man parted`
* `man mkfs`
* `man mount`
* Red Hat Storage Administration Documentation

---

✅ **Lab 18 Completed Successfully!**
