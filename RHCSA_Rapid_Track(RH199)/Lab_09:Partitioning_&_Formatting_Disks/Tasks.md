# Lab 9: Partitioning and Formatting Disks

## Task 1: Create Partitions with fdisk and parted

### Subtask 1.1: Identify Available Storage Devices

```bash
lsblk
sudo fdisk -l
df -h
```

Expected: `/dev/sda` (primary disk) and `/dev/sdb`, `/dev/sdc` (practice disks)

---

### Subtask 1.2: Create Partitions Using fdisk (MBR)

```bash
sudo fdisk /dev/sdb
```

Inside fdisk:

```
o   # create DOS partition table
n   # new partition
p   # primary
1   # partition number
<Enter>
+2G

n
p
2
<Enter>
+1G

p   # print table
w   # write changes
```

Verify:

```bash
lsblk /dev/sdb
```

---

### Subtask 1.3: Create Partitions Using parted (GPT)

```bash
sudo parted /dev/sdc
```

Inside parted:

```
mklabel gpt
mkpart primary ext4 1MiB 1GiB
mkpart primary xfs 1GiB 3GiB
print
quit
```

Verify:

```bash
lsblk /dev/sdc
```

---

## Task 2: Format Partitions with mkfs

### Subtask 2.1: Format ext4

```bash
sudo mkfs.ext4 -L DataDisk1 /dev/sdb1
sudo blkid /dev/sdb1
```

---

### Subtask 2.2: Format xfs

```bash
sudo mkfs.xfs -L DataDisk2 /dev/sdb2
sudo blkid /dev/sdb2
```

---

### Subtask 2.3: Format GPT Partitions

```bash
sudo mkfs.ext4 -L GPTDisk1 /dev/sdc1
sudo mkfs.xfs -L GPTDisk2 /dev/sdc2
sudo blkid /dev/sdc1 /dev/sdc2
```

---

## Task 3: Mount and Unmount File Systems

### Subtask 3.1: Create Mount Points

```bash
sudo mkdir -p /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
ls -la /mnt/
```

---

### Subtask 3.2: Mount File Systems

```bash
sudo mount /dev/sdb1 /mnt/disk1
sudo mount /dev/sdb2 /mnt/disk2
sudo mount /dev/sdc1 /mnt/gpt1
sudo mount /dev/sdc2 /mnt/gpt2

df -h
mount | grep -E "(sdb|sdc)"
```

---

### Subtask 3.3: Test File System Access

```bash
sudo touch /mnt/disk1/test_ext4.txt
sudo touch /mnt/disk2/test_xfs.txt
sudo touch /mnt/gpt1/test_gpt_ext4.txt
sudo touch /mnt/gpt2/test_gpt_xfs.txt

echo "This is an ext4 file system" | sudo tee /mnt/disk1/test_ext4.txt
echo "This is an xfs file system" | sudo tee /mnt/disk2/test_xfs.txt
echo "This is a GPT ext4 file system" | sudo tee /mnt/gpt1/test_gpt_ext4.txt
echo "This is a GPT xfs file system" | sudo tee /mnt/gpt2/test_gpt_xfs.txt
```

Verify:

```bash
cat /mnt/disk1/test_ext4.txt
cat /mnt/disk2/test_xfs.txt
cat /mnt/gpt1/test_gpt_ext4.txt
cat /mnt/gpt2/test_gpt_xfs.txt
```

---

### Subtask 3.4: Unmount File Systems

```bash
sudo umount /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
df -h | grep -E "(sdb|sdc)"
ls -la /mnt/disk1/
ls -la /mnt/disk2/
```

---

### Subtask 3.5: Configure Persistent Mounts

```bash
sudo cp /etc/fstab /etc/fstab.backup
sudo blkid | grep -E "(sdb|sdc)"
```

Add to `/etc/fstab`:

```bash
echo "# Lab 9 - Disk partitions" | sudo tee -a /etc/fstab
echo "UUID=$(sudo blkid -s UUID -o value /dev/sdb1) /mnt/disk1 ext4 defaults 0 2" | sudo tee -a /etc/fstab
echo "UUID=$(sudo blkid -s UUID -o value /dev/sdb2) /mnt/disk2 xfs defaults 0 2" | sudo tee -a /etc/fstab
```

Test:

```bash
sudo mount -a
df -h | grep -E "(disk1|disk2)"
```

---

## Verification and Testing

```bash
lsblk -f
df -hT
cat /etc/fstab | tail -5
sudo fsck -n /dev/sdb1
sudo xfs_info /dev/sdb2
```

## Conclusion

* Created MBR and GPT partitions
* Formatted ext4 and xfs file systems
* Mounted and configured persistent storage
* Verified and troubleshot disk setups

These skills are essential for Linux system administration and RHCSA preparation.
