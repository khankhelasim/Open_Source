## Troubleshooting Common Issues

### Permission Denied Errors

```bash
ls -l filename
groups
getfacl filename
```

### ACL Commands Not Found

```bash
sudo yum install acl -y
# or
sudo apt-get install acl -y
```

### ACLs Not Working

```bash
mount | grep acl
sudo mount -o remount,acl /
```

---

## Best Practices

* Apply the principle of least privilege
* Audit permissions regularly
* Use ACLs only when standard permissions are insufficient

Common patterns:

* Executables: `755`
* Configuration files: `644`
* Sensitive files: `600`
* Directories: `755`

---

## Conclusion

In this lab, you practiced essential Linux permission management skills using `chmod`, `chown`, and ACLs. These skills are critical for system security, troubleshooting, and Red Hat (RHCSA) certification preparation. You are now equipped to manage file and directory permissions confidently in real-world Linux environments.
