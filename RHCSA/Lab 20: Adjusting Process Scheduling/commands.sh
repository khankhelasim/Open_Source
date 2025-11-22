
---

# ✅ **2. `commands.sh`**

```bash
#!/bin/bash

# start processes
sha1sum /dev/zero &
ps -l -p $(pgrep sha1sum)

# nice & renice
nice -n 10 sha1sum /dev/zero &
ps -l -p $(pgrep sha1sum | tail -1)

sudo renice -n 5 -p $(pgrep sha1sum | head -1)
ps -l -p $(pgrep sha1sum | head -1)

# monitoring
top
htop

# process states
ps aux

# kill processes
kill $(pgrep sha1sum)

# Optional scheduling
sudo chrt -f -p 99 $(pgrep sha1sum)
