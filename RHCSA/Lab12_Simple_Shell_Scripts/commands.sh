
---

# ✅ **commands.sh**

```bash
#!/bin/bash
# Lab 12: Simple Shell Scripts - Command Script

# Create scripts directory
mkdir -p ~/shell_scripts
cd ~/shell_scripts

# hello_world.sh
echo '#!/bin/bash' > hello_world.sh
echo 'echo "Hello, World!"' >> hello_world.sh
chmod +x hello_world.sh

# system_info.sh
echo '#!/bin/bash' > system_info.sh
echo 'echo "Current date: $(date)"' >> system_info.sh
echo 'echo "User: $USER"' >> system_info.sh
echo 'echo "Current directory: $(pwd)"' >> system_info.sh
chmod +x system_info.sh

# variables.sh
echo '#!/bin/bash' > variables.sh
echo 'name="OpenShift Learner"' >> variables.sh
echo 'age=25' >> variables.sh
echo 'echo "Name: $name, Age: $age"' >> variables.sh
chmod +x variables.sh

# check_user.sh
echo '#!/bin/bash' > check_user.sh
echo 'if [ "$USER" == "root" ]; then' >> check_user.sh
echo '  echo "Running as root. Be cautious!"' >> check_user.sh
echo 'else' >> check_user.sh
echo '  echo "Running as $USER."' >> check_user.sh
echo 'fi' >> check_user.sh
chmod +x check_user.sh

# loop.sh
echo '#!/bin/bash' > loop.sh
echo 'for i in {1..5}; do' >> loop.sh
echo '  echo "Number: $i"' >> loop.sh
echo 'done' >> loop.sh
chmod +x loop.sh
