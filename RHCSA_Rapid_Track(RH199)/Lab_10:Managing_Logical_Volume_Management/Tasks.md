## Task 1: Creating Physical Volumes (PV)

### Step 1: Identify Available Disks

```bash
lsblk
fdisk -l
df -h
```

### Step 2: Verify Extra Disks

```bash
lsblk | grep -E "sdb|sdc|sdd"
fdisk -l /dev/sdb
fdisk -l /dev/sdc
fdisk -l /dev/sdd
```

### Step 3: Create Physical Volumes

```bash
pvcreate /dev/sdb
pvcreate /dev/sdc
pvcreate /dev/sdd
```

### Step 4: Verify Physical Volumes

```bash
pvs
pvdisplay
pvscan
```

---

## Task 2: Creating Volume Groups (VG)

### Step 1: Create Volume Group vg_data

```bash
vgcreate vg_data /dev/sdb /dev/sdc
```

### Step 2: Verify Volume Group

```bash
vgs
vgdisplay vg_data
```

### Step 3: Create Second Volume Group vg_backup

```bash
vgcreate vg_backup /dev/sdd
```

### Step 4: Verify All Volume Groups

```bash
vgs
vgdisplay
vgscan
```

---

## Task 3: Creating Logical Volumes (LV)

### Step 1: Create Logical Volumes in vg_data

```bash
lvcreate -L 2G -n lv_documents vg_data
lvcreate -L 1G -n lv_projects vg_data
```

### Step 2: Create Logical Volumes in vg_backup

```bash
lvcreate -L 500M -n lv_backup vg_backup
lvcreate -l 50%FREE -n lv_archive vg_backup
```

### Step 3: Verify Logical Volumes

```bash
lvs
lvdisplay
```

---

## Task 4: Formatting and Mounting Logical Volumes

### Step 1: Create Mount Points

```bash
mkdir -p /mnt/documents /mnt/projects /mnt/backup /mnt/archive
```

### Step 2: Format Logical Volumes

```bash
mkfs.ext4 /dev/vg_data/lv_documents
mkfs.ext4 /dev/vg_data/lv_projects
mkfs.ext4 /dev/vg_backup/lv_backup
mkfs.ext4 /dev/vg_backup/lv_archive
```

### Step 3: Mount Logical Volumes

```bash
mount /dev/vg_data/lv_documents /mnt/documents
mount /dev/vg_data/lv_projects /mnt/projects
mount /dev/vg_backup/lv_backup /mnt/backup
mount /dev/vg_backup/lv_archive /mnt/archive
```

### Step 4: Verify Mounting

```bash
df -h | grep -E "documents|projects|backup|archive"
```

---

## Task 5: Extending Logical Volumes

### Step 1: Extend lv_documents by 1GB

```bash
lvextend -L +1G /dev/vg_data/lv_documents
resize2fs /dev/vg_data/lv_documents
```

### Step 2: Extend lv_projects Using Free Space

```bash
lvextend -l +100%FREE /dev/vg_data/lv_projects
resize2fs /dev/vg_data/lv_projects
```

### Step 3: Verify Extension

```bash
df -h /mnt/documents /mnt/projects
```

---

## Task 6: Shrinking Logical Volumes

⚠️ Always unmount before shrinking

### Step 1: Unmount Volume

```bash
umount /mnt/archive
```

### Step 2: Check File System

```bash
e2fsck -f /dev/vg_backup/lv_archive
```

### Step 3: Shrink File System and LV

```bash
resize2fs /dev/vg_backup/lv_archive 200M
lvreduce -L 200M /dev/vg_backup/lv_archive
```

### Step 4: Remount and Verify

```bash
mount /dev/vg_backup/lv_archive /mnt/archive
df -h /mnt/archive
```

---

## Task 7: Monitoring LVM

```bash
pvs
vgs
lvs
lsblk
df -h
```

---

## Task 8: Creating LVM Snapshot

### Step 1: Create Snapshot

```bash
lvcreate -L 100M -s -n lv_documents_snapshot /dev/vg_data/lv_documents
```

### Step 2: Mount Snapshot

```bash
mkdir /mnt/snapshot
mount /dev/vg_data/lv_documents_snapshot /mnt/snapshot
```

### Step 3: Remove Snapshot

```bash
umount /mnt/snapshot
lvremove /dev/vg_data/lv_documents_snapshot
```

---
