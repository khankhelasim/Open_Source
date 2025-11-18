# Lab 11: Using System Documentation

## Objectives
- Use man and info to read documentation on commands and config files
- Navigate and search documentation efficiently
- Access package-specific documentation in /usr/share/doc

---

## Task 1: Using man and info for Documentation

### Subtask 1.1: Using man Pages
View manual page:
```bash
man ls
```
Navigation:

Arrow keys → move

/search_term → search (example: /recursive)

q → quit

View a specific man section:
```bash
man 5 passwd
```

List all man sections for a command:
```bash
man -f passwd
```
### Subtask 1.2: Using info Pages

Open coreutils documentation:
```bash
info coreutils
```

Navigate:

Arrow keys

Enter → follow hyperlink

q → quit

Open ls topic directly:
```bash
info coreutils ls invocation
```
## Task 2: Navigating and Searching Documentation
### Subtask 2.1: Searching Man Pages

Search for keyword:
```bash
man -k network
```
# or:
```bash
apropos network
```

Update man database:
```bash
sudo mandb
```
### Subtask 2.2: Using --help and -h

Quick help:
```bash
grep --help
grep -h
```
## Task 3: Accessing Package-Specific Documentation
### Subtask 3.1: Exploring /usr/share/doc

List installed documentation:
```bash
ls /usr/share/doc
```

Specific package docs:
```bash
ls /usr/share/doc/bash
less /usr/share/doc/bash/README
```
### Subtask 3.2: Installing Documentation Packages

Install Apache docs:
```bash
sudo dnf install httpd-manual
```
# or:
```bash
sudo apt install apache2-doc
```

View installed docs:
```bash
ls /usr/share/doc/httpd-manual
```
## Troubleshooting

Install man/info if missing:
```bash
sudo dnf install man-db info
sudo apt install man-db info
```

If /usr/share/doc is empty, install documentation packages.

## Conclusion

You learned to:

Use man and info

Search and navigate documentation

Access package documentation in /usr/share/doc

These skills are essential for Linux administration and troubleshooting.
