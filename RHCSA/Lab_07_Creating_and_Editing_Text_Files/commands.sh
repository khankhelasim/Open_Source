
---

# 💻 **commands.sh**
```bash
#!/bin/bash
# Lab 7 - Creating and Editing Text Files

# Open nano
nano first_file.txt

# View file contents
cat first_file.txt

# Open vi
vi second_file.txt

# View second file
less second_file.txt

# Check encoding
file first_file.txt

# Convert line endings
unix2dos first_file.txt
dos2unix first_file.txt

# Create Podman config
nano podman_config.conf

# Validate config file
grep -n '[[:space:]]$' podman_config.conf
wc -l podman_config.conf
