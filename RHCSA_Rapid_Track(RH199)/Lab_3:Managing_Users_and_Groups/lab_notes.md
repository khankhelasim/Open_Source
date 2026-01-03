# Lab 3 Notes – Managing Users and Groups


## Key User Commands
- useradd / userdel / usermod
- passwd / passwd -S
- chage


## Key Group Commands
- groupadd / groupdel / groupmod
- gpasswd


## Important Files
- /etc/passwd → user account info
- /etc/group → group info
- /etc/shadow → encrypted passwords


## Security Best Practices
- Lock unused accounts
- Use password aging policies
- Delete users safely with userdel -r
- Verify changes with id, groups, getent


## RHCSA Tip
User & group management questions are guaranteed in the exam.
