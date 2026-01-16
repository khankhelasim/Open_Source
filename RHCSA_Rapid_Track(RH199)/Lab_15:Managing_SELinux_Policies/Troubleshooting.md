

## Troubleshooting & Verification

### Common Issues

* **Service fails to start** → Check AVC denials and file contexts
* **Web access denied** → Verify `httpd_sys_content_t` context
* **Port binding failure** → Add port using `semanage port`

### Verification Commands

```bash
getenforce
sestatus
ls -Z /home/testuser/website/
semanage port -l | grep 8080
getsebool httpd_can_network_connect
```

---

## Lab Cleanup

```bash
sudo rm -rf /opt/testapp
sudo rm -rf /home/testuser/website
sudo rm -f /etc/httpd/conf.d/testsite.conf

sudo semanage fcontext -d "/opt/testapp/config.conf"
sudo semanage port -d -t http_port_t -p tcp 8080

sudo systemctl restart httpd
```

---
