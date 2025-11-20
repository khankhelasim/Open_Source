# Lab 13: Conditionally Execute Code in Shell Scripts

This lab covers the fundamentals of conditional execution in Bash using:

- `if`, `elif`, and `else`
- File checks
- String comparisons
- Using `test` vs `[ ]`

Below are all the script files included in this lab.

---

## 📌 **1. basic_if.sh**

```bash
#!/bin/bash
read -p "Enter a number: " num
if [ $num -gt 10 ]; then
    echo "The number is greater than 10."
fi
```

---

## 📌 **2. if_elif_else.sh**

```bash
#!/bin/bash
read -p "Enter a number: " num
if [ $num -gt 10 ]; then
    echo "Greater than 10."
elif [ $num -eq 10 ]; then
    echo "Equal to 10."
else
    echo "Less than 10."
fi
```

---

## 📌 **3. file_check.sh**

```bash
#!/bin/bash
if [ -f "/etc/passwd" ]; then
    echo "File /etc/passwd exists."
else
    echo "File not found."
fi
```

---

## 📌 **4. string_compare.sh**

```bash
#!/bin/bash
read -p "Enter 'yes' or 'no': " answer

if [ "$answer" = "yes" ]; then
    echo "You agreed."
elif [ "$answer" = "no" ]; then
    echo "You disagreed."
else
    echo "Invalid input."
fi
```

---

## 📌 **5. test_command.sh**

```bash
#!/bin/bash
read -p "Enter a number: " num

if test $num -lt 5; then
    echo "Number is less than 5."
else
    echo "Number is 5 or greater."
fi
```

---

## 📌 **6. test_square_brackets.sh**

```bash
#!/bin/bash
read -p "Enter a number: " num

if [ $num -lt 5 ]; then
    echo "Number is less than 5."
else
    echo "Number is 5 or greater."
fi
```

---

## ✔ How to Use

```bash
chmod +x *.sh
./basic_if.sh
./if_elif_else.sh
./file_check.sh
./string_compare.sh
./test_command.sh
./test_square_brackets.sh
```

---

## 👍 More Labs Coming Soon!

I am uploading all labs in sequence.  
**Follow, star ⭐, and support my GitHub repo** to stay updated:

👉 *More labs coming soon — keep visiting and supporting me on GitHub!*  

