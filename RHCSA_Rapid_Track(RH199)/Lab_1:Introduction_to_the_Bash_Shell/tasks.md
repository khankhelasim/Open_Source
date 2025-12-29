# Lab 01: Introduction to the Bash Shell (Step-by-Step)

---

## Task 1: Access the Command Line Interface

### Task 1.1: Connect to the Lab Environment

1. Click **Start Lab** from the Al Nafi dashboard.
2. Wait for the environment to initialize (30–60 seconds).
3. Open the **Terminal** application if a desktop appears.

### Task 1.2: Verify Your Shell Environment

```bash
echo $SHELL
```

```bash
bash --version
```

```bash
whoami
```

```bash
date
```

Expected results:

* Shell path should be `/bin/bash`
* Username should be displayed
* Current date and time should appear

---

## Task 2: Use Basic Bash Commands

### Task 2.1: Navigate the File System

```bash
pwd
```

```bash
ls
```

```bash
ls -l
```

```bash
ls -la
```

```bash
cd /
```

```bash
ls
```

```bash
cd ~
```

---

### Task 2.2: Create and Manage Directories

```bash
mkdir lab1-practice
```

```bash
cd lab1-practice
```

```bash
mkdir scripts documents backups
```

```bash
mkdir -p projects/web/html projects/web/css
```

```bash
ls -R
```

---

### Task 2.3: Create and Manage Files

```bash
touch readme.txt
```

```bash
echo "Welcome to Bash Shell Lab" > welcome.txt
```

```bash
cat welcome.txt
```

```bash
cat > system-info.txt << EOF
System Information Lab File
Created on: $(date)
User: $(whoami)
Directory: $(pwd)
EOF
```

```bash
cat system-info.txt
```

---

### Task 2.4: Copy, Move, and Remove Files

```bash
cp welcome.txt documents/
```

```bash
cp welcome.txt welcome-backup.txt
```

```bash
mv readme.txt documents/
```

```bash
mv welcome-backup.txt welcome-copy.txt
```

```bash
rm welcome-copy.txt
```

```bash
ls
```

```bash
ls documents/
```

---

## Task 3: Input, Output Redirection and Pipes

### Task 3.1: Output Redirection

```bash
ls -la > file-listing.txt
```

```bash
cat file-listing.txt
```

```bash
date >> file-listing.txt
```

```bash
echo "--- End of listing ---" >> file-listing.txt
```

```bash
cat file-listing.txt
```

---

### Task 3.2: Input Redirection

```bash
cat > numbers.txt << EOF
10
25
5
30
15
EOF
```

```bash
sort < numbers.txt
```

```bash
sort < numbers.txt > sorted-numbers.txt
```

---

### Task 3.3: Using Pipes

```bash
ls | wc -l
```

```bash
ps aux | grep bash
```

```bash
du -h | sort -hr
```

```bash
cat /etc/passwd | grep root
```

```bash
ls -la | grep "^d" | wc -l
```

---

### Task 3.4: Advanced Redirection

```bash
ls /nonexistent-directory > output.txt 2> error.txt
```

```bash
ls /nonexistent-directory > combined.txt 2>&1
```

```bash
ls -la | tee directory-listing.txt
```

---

## Task 4: Shell Scripting

### Task 4.1: First Script

```bash
cd ~/lab1-practice/scripts
```

```bash
cat > hello-world.sh << 'EOF'
#!/bin/bash
echo "Hello, World!"
echo "Welcome to Bash scripting!"
echo "Today is: $(date)"
echo "Current user: $(whoami)"
EOF
```

```bash
chmod +x hello-world.sh
```

```bash
./hello-world.sh
```

---

### Task 4.2: System Report Script

```bash
cat > system-report.sh << 'EOF'
#!/bin/bash
echo "SYSTEM REPORT"
echo "-------------"
date
hostname
uptime
df -h | head -5
free -h
EOF
```

```bash
chmod +x system-report.sh
```

```bash
./system-report.sh
```

---

### Task 4.3: Interactive Script

```bash
cat > user-info.sh << 'EOF'
#!/bin/bash
read -p "Enter your name: " username
read -p "Enter your age: " age
echo "Name: $username"
echo "Age: $age"
echo "Date: $(date)"
EOF
```

```bash
chmod +x user-info.sh
```

```bash
./user-info.sh
```

---

### Task 4.4: File Management Script

```bash
cat > file-manager.sh << 'EOF'
#!/bin/bash
backup_dir="backup-$(date +%Y%m%d)"
mkdir -p "$backup_dir"
for file in *.txt; do
  [ -f "$file" ] && cp "$file" "$backup_dir/"
done
echo "Backup completed in $backup_dir"
EOF
```

```bash
chmod +x file-manager.sh
```

```bash
./file-manager.sh
```

---

## Task 5: Verification

```bash
cd ~/lab1-practice
```

```bash
find . -type d
```

```bash
ls -la scripts/
```

```bash
bash -n scripts/*.sh
```

✅ All scripts should run without errors.
