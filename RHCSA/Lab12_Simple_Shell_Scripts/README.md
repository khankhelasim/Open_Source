# Lab 12: Creating Simple Shell Scripts

## Objectives
In this lab, you will learn to:

- Write and execute basic shell scripts in Linux
- Use variables, if-else conditions, and loops
- Debug scripts using `bash -x`
- Troubleshoot common scripting errors

---

## Prerequisites
- Linux-based OS (Ubuntu, CentOS, Fedora)
- Bash shell installed
- Text editor (nano, vim, gedit)
- Basic command-line skills

---

## Task 1: Write a Simple Shell Script

### Subtask 1.1: Create & Execute a Basic Script
Create a directory for scripts:
```bash
mkdir ~/shell_scripts
cd ~/shell_scripts
```
Create the script:
```bash
nano hello_world.sh
```
Add:
```bash
#!/bin/bash
echo "Hello, World!"
```
Make script executable:
```bash
chmod +x hello_world.sh
```

Run:
```bash
./hello_world.sh
```

Expected:
```bash
Hello, World!
```
### Subtask 1.2: Execute Commands in a Script

Create:
```bash
nano system_info.sh
```

Add:
```bash
#!/bin/bash
echo "Current date: $(date)"
echo "User: $USER"
echo "Current directory: $(pwd)"
```

Run:
```bash
chmod +x system_info.sh
./system_info.sh
```
## Task 2: Variables and Control Flow
### Subtask 2.1: Variables

Create:
```bash
nano variables.sh
```

Add:
```bash
#!/bin/bash
name="OpenShift Learner"
age=25
echo "Name: $name, Age: $age"
```
### Subtask 2.2: If Statement
```bash
nano check_user.sh
```

Add:
```bash
#!/bin/bash
if [ "$USER" == "root" ]; then
  echo "Running as root. Be cautious!"
else
  echo "Running as $USER."
fi
```
### Subtask 2.3: For Loop

Create:
```bash
nano loop.sh
```

Add:
```bash
#!/bin/bash
for i in {1..5}; do
  echo "Number: $i"
done
```
## Task 3: Debugging Shell Scripts
### Subtask 3.1: Run in Debug Mode
```bash
bash -x hello_world.sh
```

Example output:
```bash
+ echo 'Hello, World!'
Hello, World!
```
### Subtask 3.2: Error Handling

Remove shebang from hello_world.sh

Run it → expect failure

Add shebang back → runs correctly

# Conclusion

In this lab, you learned:

How to create and run shell scripts

How to use variables, if conditions, and loops

Debugging scripts with bash -x

Basic troubleshooting

# Next Steps

Explore functions & passing arguments

Automate real-world tasks (backups, system checks, logs)

To view all scripts:
```bash
ls -l ~/shell_scripts
```
