## Troubleshooting

### Issue 1: Unable to exit vim

**Cause:** Still in insert mode

**Fix:**

```bash
Press Esc
:q!
```

---

### Issue 2: File opened as read-only

**Cause:** Insufficient permissions

**Fix:**

```bash
sudo vim filename
sudo nano filename
```

---

### Issue 3: Changes not saved in nano

**Cause:** Forgot to confirm save

**Fix:**

```bash
Ctrl + O → Enter → Ctrl + X
```

---

### Issue 4: vim shows swap file warning

**Cause:** Previous crash or file already open

**Fix:**

```bash
vim -r filename
rm .filename.swp
```

---

### Issue 5: Editor not installed

**Fix:**

```bash
sudo dnf install vim nano -y
```

---

## Conclusion

You now understand **both nano and vim**, can confidently edit configuration files, troubleshoot common editor issues, and choose the right editor for the task. These skills are **essential for RHCSA exams and real-world Linux administration**.

You now understand **both nano and vim**, can confidently edit configuration files, troubleshoot mistakes, and choose the right editor for the task. These skills are **core RHCSA exam objectives** and critical for real-world Linux administration.
