## Troubleshooting

**Device Busy**

```bash
sudo fuser -m /mnt/disk1
sudo lsof +D /mnt/disk1
```

**Partition Not Recognized**

```bash
sudo partprobe /dev/sdb
sudo partprobe /dev/sdc
```

**Mount Point Already Used**

```bash
sudo umount /mnt/disk1
sudo mount /dev/sdb1 /mnt/disk1
```

---

## Cleanup (Optional)

```bash
sudo umount /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
sudo cp /etc/fstab.backup /etc/fstab
sudo rmdir /mnt/disk1 /mnt/disk2 /mnt/gpt1 /mnt/gpt2
```

---
