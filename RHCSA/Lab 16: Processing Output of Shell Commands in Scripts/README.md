# Lab 16: Processing Output of Shell Commands in Scripts

This lab teaches how to:

- Capture command output using **backticks** and **$()**
- Store command results in variables
- Process and filter multi-line output
- Use captured output in conditions, arrays, and calculations
- Build real-world shell automation patterns

---

## 📌 **1. backtick_example.sh**
Demonstrates classic backtick command substitution.

```bash
#!/bin/bash
files=`ls -l`
echo "Files in this directory:"
echo "$files"
```

Run:

```bash
chmod +x backtick_example.sh
./backtick_example.sh
```

---

## 📌 **2. dollar_parenthesis.sh**
Modern, preferred `$()` command substitution.

```bash
#!/bin/bash
process_count=$(ps aux | wc -l)
echo "Number of running processes: $process_count"
```

---

## 📌 **3. system_info.sh**
Storing single-line command results.

```bash
#!/bin/bash
kernel_version=$(uname -r)
hostname=$(hostname)

echo "System Information:"
echo "Kernel: $kernel_version"
echo "Hostname: $hostname"
```

---

## 📌 **4. multi_line.sh**
Capturing multi-line output correctly.

```bash
#!/bin/bash
disk_info=$(df -h)

echo "Disk Usage Information:"
echo "$disk_info" | grep -v "tmpfs"
```

> **Tip:** Always quote `"${var}"` when output may contain spaces or multiple lines.

---

## 📌 **5. process_users.sh**
Filtering and counting logged-in users.

```bash
#!/bin/bash
users=$(who | awk '{print $1}')
user_count=$(echo "$users" | wc -l)

echo "Current Users:"
echo "$users"
echo "Total users logged in: $user_count"
```

---

## 📌 **6. disk_check.sh**
Using captured output in a conditional.

```bash
#!/bin/bash
avail_space=$(df -BG / | awk 'NR==2 {print $4}' | tr -d 'G')

if [ "$avail_space" -lt 5 ]; then
    echo "Warning: Only ${avail_space}GB remaining in root!"
else
    echo "Disk space OK: ${avail_space}GB available"
fi
```

---

## 📌 **7. ip_array.sh**
Processing multi-line command output into arrays.

```bash
#!/bin/bash
ip_lines=$(ip a | grep 'inet ')
readarray -t ips <<< "$ip_lines"

echo "Network Interfaces:"
for ip in "${ips[@]}"; do
    echo "- $ip"
done
```

---

# ⭐ Final Challenge Script (Included as challenge_solution.sh)

```bash
#!/bin/bash

large_files=$(find /var/log -type f -size +1M)
count=$(echo "$large_files" | wc -l)
total_size=$(du -ch $(echo "$large_files") | grep total | awk '{print $1}')

echo "Found $count large log files"
echo "Total size: $total_size"
```

---

# ✔ How to Run All Scripts

```bash
chmod +x *.sh
./backtick_example.sh
./dollar_parenthesis.sh
./system_info.sh
./multi_line.sh
./process_users.sh
./disk_check.sh
./ip_array.sh
./challenge_solution.sh
```

---

# ⭐ Stay Updated!

More labs from this module will be uploaded soon.  
**Keep visiting, starring ⭐ the repo, and supporting the journey on GitHub!**

