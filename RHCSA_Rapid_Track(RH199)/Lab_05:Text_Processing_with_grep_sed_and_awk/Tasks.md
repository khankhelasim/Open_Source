# Lab 5: Text Processing with grep, sed, and awk


## Task 1: Search Text in Files Using grep

### Subtask 1.1: Create Sample Data Files

```bash
mkdir ~/text_processing_lab
cd ~/text_processing_lab

cat > employees.txt << 'EOF'
John Smith,Manager,Sales,75000
Jane Doe,Developer,IT,65000
Mike Johnson,Analyst,Finance,55000
Sarah Wilson,Manager,IT,80000
Tom Brown,Developer,IT,60000
Lisa Davis,Analyst,Sales,50000
Robert Taylor,Manager,Finance,85000
Emily White,Developer,IT,62000
David Lee,Analyst,IT,58000
Maria Garcia,Manager,Sales,78000
EOF

cat > server_logs.txt << 'EOF'
2024-01-15 10:30:15 INFO: Server started successfully
2024-01-15 10:31:22 ERROR: Database connection failed
2024-01-15 10:32:10 WARNING: High memory usage detected
2024-01-15 10:33:45 INFO: User login: admin
2024-01-15 10:34:12 ERROR: File not found: /var/log/app.log
2024-01-15 10:35:30 INFO: Backup process completed
2024-01-15 10:36:18 WARNING: Disk space low
2024-01-15 10:37:25 ERROR: Network timeout occurred
2024-01-15 10:38:40 INFO: User logout: admin
2024-01-15 10:39:55 INFO: System maintenance scheduled
EOF

cat > products.txt << 'EOF'
Laptop,Electronics,999.99,50
Mouse,Electronics,29.99,200
Keyboard,Electronics,79.99,150
Chair,Furniture,299.99,25
Desk,Furniture,499.99,15
Monitor,Electronics,399.99,75
Headphones,Electronics,149.99,100
Lamp,Furniture,89.99,40
Notebook,Office,12.99,500
Pen,Office,2.99,1000
EOF
```

---

### Subtask 1.2: Basic grep Commands

```bash
grep "Manager" employees.txt
grep -i "manager" employees.txt
grep -c "IT" employees.txt
grep -n "Developer" employees.txt
grep -v "IT" employees.txt
```

---

### Subtask 1.3: Advanced grep with Regex

```bash
grep "^2024-01-15 10:3[0-5]" server_logs.txt
grep "000$" employees.txt
grep "[0-9]" products.txt
grep -E "(ERROR|WARNING)" server_logs.txt
mkdir logs
cp server_logs.txt logs/
grep -r "ERROR" .
```

---

## Task 2: Text Replacement Using sed

### Basic Substitution

```bash
sed 's/IT/Information Technology/' employees.txt
sed 's/IT/Information Technology/g' employees.txt
sed 's/IT/Information Technology/g' employees.txt > employees_updated.txt
```

### In-place Editing

```bash
cp employees.txt employees_backup.txt
sed -i 's/IT/Information Technology/g' employees_backup.txt
```

### Advanced sed Usage

```bash
sed '2d' employees.txt
sed '/Manager/d' employees.txt
sed '1i\\Employee Database Report' employees.txt
sed '$a\\End of Report' employees.txt
sed '3s/Analyst/Senior Analyst/' employees.txt
sed '/Finance/s/Analyst/Senior Analyst/' employees.txt
```

---

## Task 3: Data Processing Using awk

### Basic awk Commands

```bash
awk -F',' '{print $1}' employees.txt
awk -F',' '{print $1, $2}' employees.txt
awk -F',' '{print "Name: " $1 ", Position: " $2}' employees.txt
awk '{print NR ": " $0}' employees.txt
awk 'END {print "Total employees:", NR}' employees.txt
```

### Conditional Processing

```bash
awk -F',' '$2=="Manager" {print $1, $4}' employees.txt
awk -F',' '$4>60000 {print $1, $4}' employees.txt
awk -F',' '$3=="IT" {print $1, $2}' employees.txt
```

---

## Task 4: Combining grep, sed, and awk

```bash
grep "IT" employees.txt | sed 's/IT/Information Technology/g' | awk -F',' '{print $1 " works in " $3 " earning $" $4}'
```

---

## Task 5: Real-World Scenario – Data Cleaning

```bash
sed 's/^[ \t]*//; s/[ \t]*$//; s/[ \t]*,[ \t]*/,/g' messy_data.txt | \
awk -F',' '{printf "%-15s | %-10s | %-8s | $%s\n", $1, $2, $3, $4}'
```

---

## Verification

```bash
grep -c "IT" employees.txt
awk -F',' '{total+=$4;count++} END {print total/count}' employees.txt
awk -F',' '{if($4>max){max=$4;name=$1}} END {print name, max}' employees.txt
```

---

## Task 5: Real-World Scenarios

### Subtask 5.1: System Monitoring Script

```bash
cat > system_monitor.sh << 'EOF'
#!/bin/bash

cat > system_status.log << 'SYSEOF'
2024-01-15 10:30:00 CPU: 45% Memory: 67% Disk: 23%
2024-01-15 10:31:00 CPU: 52% Memory: 71% Disk: 23%
2024-01-15 10:32:00 CPU: 89% Memory: 78% Disk: 24%
2024-01-15 10:33:00 CPU: 34% Memory: 65% Disk: 24%
2024-01-15 10:34:00 CPU: 91% Memory: 82% Disk: 25%
2024-01-15 10:35:00 CPU: 28% Memory: 59% Disk: 25%
SYSEOF

echo "=== SYSTEM PERFORMANCE ANALYSIS ==="

echo "High CPU Usage (>80%):"
grep -E "CPU: [8-9][0-9]%" system_status.log | awk '{print "   " $1 " " $2 " - " $3}'

echo -e "
High Memory Usage (>75%):"
grep -E "Memory: [7-9][0-9]%" system_status.log | awk '{print "   " $1 " " $2 " - " $4}'

echo -e "
System Averages:"
awk '{
    gsub(/[CPU:Memory:Disk:%]/, "");
    cpu+=$3; mem+=$4; disk+=$5; count++
}
END {
    printf "   Average CPU: %.1f%%
", cpu/count
    printf "   Average Memory: %.1f%%
", mem/count
    printf "   Average Disk: %.1f%%
", disk/count
}' system_status.log

rm system_status.log
EOF

chmod +x system_monitor.sh
./system_monitor.sh
```

---

### Subtask 5.2: Data Cleaning and Formatting Script

```bash
cat > messy_data.txt << 'EOF'
  John Smith  ,  Manager  ,  Sales  ,  75000  
Jane Doe,Developer,IT,65000
  Mike Johnson,Analyst,Finance,55000
Sarah Wilson  ,Manager,IT,80000  
  Tom Brown,Developer  ,IT,60000
EOF

echo "=== DATA CLEANING EXAMPLE ==="

echo "Original Data:"
cat messy_data.txt

echo -e "
Cleaned & Formatted Data:"
sed 's/^[ 	]*//; s/[ 	]*$//; s/[ 	]*,[ 	]*/,/g' messy_data.txt | \
awk -F',' '{printf "%-15s | %-10s | %-8s | $%s
", $1, $2, $3, $4}'
```

---

## Conclusion

In this lab, you learned how to:

* Search text efficiently using **grep**
* Transform and clean data using **sed**
* Extract, analyze, and report data using **awk**
* Combine all three tools into powerful pipelines

These skills are essential for **Linux system administration** and **RHCSA-level tasks**. Practice regularly and explore advanced options using `man grep`, `man sed`, and `man awk`.
