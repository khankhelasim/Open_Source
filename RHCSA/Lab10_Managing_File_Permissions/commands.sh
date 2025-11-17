
---

# ✅ **commands.sh **

```bash
#!/bin/bash
# Lab 10: Managing File Permissions - Command Script

# View permissions
ls -l

# Change permissions symbolically
chmod u+x example.txt
ls -l example.txt

# Change permissions numerically
chmod 640 example.txt
ls -l example.txt

# Change file owner
sudo chown newuser example.txt
ls -l example.txt

# Change group ownership
sudo chgrp newgroup example.txt
ls -l example.txt
