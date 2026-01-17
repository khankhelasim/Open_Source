## Troubleshooting Tips

* **Permission denied:** Use `sudo podman` or configure rootless Podman properly.
* **Port already in use:**

```bash
ss -tulpn | grep :8080
podman run -p 8084:80 httpd:latest
```

* **Container fails to start:**

```bash
podman logs <container-name>
```

* **Image pull fails:** Try an alternative registry such as `quay.io`.

---

## Best Practices

* Use specific image tags (avoid `latest` in production)
* Clean up unused resources regularly
* Use meaningful names for containers and images
* Monitor container resource usage
* Use volumes for persistent data
* Prefer rootless containers for improved security

---
