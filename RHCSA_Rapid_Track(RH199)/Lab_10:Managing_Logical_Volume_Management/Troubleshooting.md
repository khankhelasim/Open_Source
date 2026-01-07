# Lab 10: Managing Logical Volume Management (LVM)

##  Troubleshooting Common Issues

### Issue 1: Physical Volume Creation Fails

```bash
lsof /dev/sdb
fdisk -l /dev/sdb
wipefs -a /dev/sdb
```

### Issue 2: Volume Group Creation Problems

```bash
pvs
vgs | grep vg_data
vgcreate vg_data2 /dev/sdb /dev/sdc
```

### Issue 3: Logical Volume Mount Issues

```bash
fsck /dev/vg_data/lv_documents
ls -ld /mnt/documents
mount | grep documents
```

---

##  Lab Verification and Testing

### Final System Verification

```bash
echo "=== Physical Volumes ==="
pvs

echo "=== Volume Groups ==="
vgs

echo "=== Logical Volumes ==="
lvs

echo "=== Mounted File Systems ==="
df -h | grep -E "documents|projects|backup|archive"
```

### LVM Tree Structure

```bash
lsblk | grep -A 20 -B 5 -E "sdb|sdc|sdd"
```

---

##  Performance Testing (Optional)

```bash
time dd if=/dev/zero of=/mnt/documents/testfile bs=1M count=100
time dd if=/dev/zero of=/mnt/projects/testfile bs=1M count=100
```

```bash
rm /mnt/documents/testfile
rm /mnt/projects/testfile
```

---

## Cleanup (Optional)

### Unmount Logical Volumes

```bash
umount /mnt/documents
umount /mnt/projects
umount /mnt/backup
umount /mnt/archive
```

### Remove Logical Volumes

```bash
lvremove /dev/vg_data/lv_documents
lvremove /dev/vg_data/lv_projects
lvremove /dev/vg_backup/lv_backup
lvremove /dev/vg_backup/lv_archive
```

### Remove Volume Groups

```bash
vgremove vg_data
vgremove vg_backup
```

### Remove Physical Volumes

```bash
pvremove /dev/sdb
pvremove /dev/sdc
pvremove /dev/sdd
```

---

## Conclusion

This lab successfully demonstrated complete Logical Volume Management (LVM) lifecycle operations, including creation, extension, shrinking, monitoring, troubleshooting, verification, and cleanup. The exercises reinforced real-world storage management skills required for enterprise Linux environments.

---

## Result

✅ Lab 10 completed successfully with all objectives achieved.
