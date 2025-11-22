# Lab 15: Processing Input in Shell Scripts

This lab covers:
- Using positional parameters (`$1`, `$2`, `$@`, `$#`)
- Reading user input with `read`
- Changing script behavior based on input
- Adding validation & error handling
- Using `set -e` for automatic error detection

---

## 📌 **1. input_script.sh**  
Basic positional parameter usage.

```bash
#!/bin/bash
echo "First argument: $1"
echo "Second argument: $2"
echo "All arguments: $@"
echo "Total arguments: $#"
```

Run:

```bash
./input_script.sh apple banana cherry
```

---

## 📌 **2. input_with_prompt.sh**  
Reads user input interactively.

```bash
#!/bin/bash
read -p "Enter your name: " name
echo "Hello, $name! You provided $# arguments."
```

---

## 📌 **3. flexible_input.sh**  
Uses positional parameter if provided; otherwise prompts the user.

```bash
#!/bin/bash
if [ $# -eq 0 ]; then
  read -p "Enter a directory path: " path
else
  path=$1
fi

ls -l "$path"
```

Test:

```bash
./flexible_input.sh /tmp
./flexible_input.sh
```

---

## 📌 **4. error_handling.sh**  
Validation + graceful error handling.

```bash
#!/bin/bash

if [ $# -eq 0 ]; then
  read -p "Enter a directory path: " path
else
  path=$1
fi

if [ ! -d "$path" ]; then
  echo "Error: $path is not a valid directory." >&2
  exit 1
fi

ls -l "$path"
```

---

## 📌 **5. safe_calc.sh**  
Demonstrates `set -e` for auto-exit on errors.

```bash
#!/bin/bash
set -e
[ -z "$1" ] && read -p "Enter a number: " num || num=$1
echo "Result: $((num * 2))"
```

Run with numeric + invalid inputs to see behavior.

---

## ✔ How to Run All Files

```bash
chmod +x *.sh
./input_script.sh a b c
./input_with_prompt.sh
./flexible_input.sh
./error_handling.sh
./safe_calc.sh
```

---

## ⭐ Stay Updated!

More labs are being uploaded soon —  
**Keep visiting my GitHub, star ⭐ the repo, and support this learning journey!**

