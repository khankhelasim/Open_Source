### Ansible Lab 4: Container Debugging Notes

This document lists all issues faced while running Lab 4 on Docker containers and the step-by-step debugging process.

---

#### 1️⃣ Docker BuildKit Error

**Error:**

```
ERROR: BuildKit is enabled but the buildx component is missing or broken.
```

**Cause:** BuildKit enabled but `buildx` is missing.
**Fix:**

* Either install `buildx` from Docker docs.
* Or disable BuildKit: `export DOCKER_BUILDKIT=0`

---

#### 2️⃣ YUM Package Install Error (CentOS)

**Error:**

```
Depsolve Error: problem with installed package curl-minimal
```

**Cause:** Package conflict in minimal container image.
**Fix:**

* Install only non-conflicting packages individually.
* Avoid `curl` conflicts by removing `curl-minimal` if needed.

---

#### 3️⃣ APT Module Error (Ubuntu)

**Error:**

```
Unsupported parameters for (apt) module: cache_valid
```

**Cause:** Wrong parameter `cache_valid`; correct is `cache_valid_time`.
**Fix:**

```yaml
apt:
  update_cache: yes
  cache_valid_time: 3600
```

---

#### 4️⃣ Missing Packages (RHEL Development Tools)

**Error:**

```
No package kernal_devel available
```

**Cause:** Typo (`kernal_devel` → correct: `kernel-devel`).
**Fix:**

* Correct spelling: `kernel-devel`
* Verify available packages: `dnf list kernel-devel`

---

#### 5️⃣ Service Module Failures

**Errors:**

```
Could not find the requested service httpd
Unsupported parameters for (service) module: register
```

**Causes:**

* Docker containers have **no systemd**, so `service` module cannot manage services.
* `register` must be **at task level**, not module parameters.

**Fix:**

* Use container-safe service start:

```yaml
- name: Start Apache in container
  shell: httpd -DFOREGROUND &
  when: ansible_virtualization_type == 'docker'
```

* Use `register` correctly:

```yaml
- name: Check service
  service:
    name: apache2
    state: started
  register: service_status
```

---

#### 6️⃣ ps command not found

**Error:**

```
/bin/sh: ps: command not found
```

**Cause:** Minimal container image lacks `procps` package.
**Fix:**

```bash
ansible centos_node -m dnf -a 'name=procps-ng state=present' --become
```

Or avoid `ps` and use Apache process checks directly.

---

#### 7️⃣ Apache syntax check warning (CentOS)

**Error:**

```
AH00558: Could not reliably determine the server's fully qualified domain name
```

**Cause:** Minimal container lacks proper FQDN.
**Fix:**

* This is harmless; optional fix:

```bash
echo 'ServerName localhost' >> /etc/httpd/conf/httpd.conf
```

---

#### 8️⃣ HTTP 403 Forbidden (CentOS)

**Error:**

```
Status code was 403: Forbidden
```

**Cause:** Apache running but **directory permissions** prevent access.
**Fix:**

```bash
ansible centos_node -m shell -a "mkdir -p /var/www/html && echo '<h1>CentOS Apache OK</h1>' > /var/www/html/index.html && chmod -R 755 /var/www && chown -R apache:apache /var/www" --become
```

---

#### 9️⃣ Verification Commands

* Ubuntu: `ansible all -m uri -a "url=http://{{ inventory_hostname }} method=GET"`
* CentOS (after fixes): same command → should return `status: 200`
* Check Apache process: `httpd -t` or `pgrep httpd`

---

### ✅ Lessons Learned

1. Minimal Docker images lack systemd and common utilities.
2. Service module depends on systemd → use `shell: httpd -DFOREGROUND &` in containers.
3. Package conflicts happen in minimal images → install carefully.
4. Always check directory permissions for web servers.
5. Use `ansible_virtualization_type` to differentiate container vs VM logic.
6. Use `uri` module for reliable service verification.

---

**End of Lab 4 Container Debug Notes**
