# Lab 4 Notes – File and Directory Permissions


## Permission Basics
- r (read) = 4
- w (write) = 2
- x (execute) = 1


## Common Permission Sets
- 755 → executable files and directories
- 644 → configuration and text files
- 600 → sensitive files


## Ownership Commands
- chown user file
- chown user:group file
- chown -R user:group directory


## ACL Commands
- getfacl file
- setfacl -m u:user:rw file
- setfacl -b file (remove all ACLs)


## RHCSA Tip
ACLs are often tested for advanced permission scenarios.
