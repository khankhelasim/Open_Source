
---

# ✅ **2. `commands.sh`**

```bash
#!/bin/bash

# man pages
man ls
man 5 passwd
man -f passwd

# info pages
info coreutils
info coreutils ls invocation

# search documentation
man -k network
apropos network
sudo mandb

# quick help
grep --help
grep -h

# package documentation
ls /usr/share/doc
ls /usr/share/doc/bash
less /usr/share/doc/bash/README

# install documentation
sudo dnf install httpd-manual
# sudo apt install apache2-doc

# verify httpd docs
ls /usr/share/doc/httpd-manual
