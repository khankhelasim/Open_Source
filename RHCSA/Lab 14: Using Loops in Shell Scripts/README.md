# Lab 14: Using Loops in Shell Scripts

This lab teaches the use of:
- `for` loops  
- `while` loops  
- `until` loops  
- Loop + conditional processing  
- `break` and `continue`  

These are essential for automation in Bash scripting.

---

## 📌 **1. for_script.sh**  
Basic `for` loop over a list of items.

```bash
#!/bin/bash
echo "Basic for loop example:"
for fruit in apple banana orange; do
    echo "I like $fruit"
done
```

---

## 📌 **2. file_loop.sh**  
Iterating through `.txt` files in the directory.

```bash
#!/bin/bash
echo "List of .txt files:"
for file in *.txt; do
    echo "Found file: $file"
done
```

---

## 📌 **3. while_script.sh**  
Counts from 1 to 5.

```bash
#!/bin/bash
count=1
while [ $count -le 5 ]; do
    echo "Count: $count"
    ((count++))
done
```

---

## 📌 **4. until_script.sh**  
Countdown from 3 to 1.

```bash
#!/bin/bash
count=3
until [ $count -eq 0 ]; do
    echo "Countdown: $count"
    ((count--))
done
echo "Done!"
```

---

## 📌 **5. filter_files.sh**  
Combining loops + conditionals — show only readable files.

```bash
#!/bin/bash
for file in *; do
    if [ -r "$file" ]; then
        echo "Readable file: $file"
    fi
done
```

---

## 📌 **6. control_loop.sh**  
Using `break`.

```bash
#!/bin/bash
for num in {1..10}; do
    if [ $num -eq 5 ]; then
        break
    fi
    echo "Number: $num"
done
echo "Loop exited at 5"
```

---

## ✔ How to Run All

```bash
chmod +x *.sh
./for_script.sh
./file_loop.sh
./while_script.sh
./until_script.sh
./filter_files.sh
./control_loop.sh
```

---

## ⭐ Continue Supporting the Project!

More labs are being uploaded soon —  
**Keep visiting my GitHub, star ⭐ the repo, and follow for updates!**

