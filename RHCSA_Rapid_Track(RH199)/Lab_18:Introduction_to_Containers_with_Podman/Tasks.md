## Task 1: Install Podman and Create Containers

### Subtask 1.1: Install Podman

1. Update system packages:

```bash
sudo dnf update -y
```

2. Install Podman:

```bash
sudo dnf install -y podman
```

3. Verify installation:

```bash
podman --version
```

4. View system information:

```bash
podman info
```

---

### Subtask 1.2: Create Your First Container (Web Server)

1. Pull an Apache HTTP Server image:

```bash
podman pull docker.io/library/httpd:latest
```

2. Run the container:

```bash
podman run -d --name my-web-server -p 8080:80 httpd:latest
```

3. Verify the container:

```bash
podman ps
```

4. Test the web server:

```bash
curl http://localhost:8080
```

---

### Subtask 1.3: Interactive Container

> **Note:** `centos:latest` is deprecated. Use a supported image such as `quay.io/centos/centos:stream9` or `registry.access.redhat.com/ubi9/ubi`.

1. Run an interactive container:

```bash
podman run -it --name interactive-centos quay.io/centos/centos:stream9 /bin/bash
```

2. Inside the container:

```bash
cat /etc/os-release
ps aux
ip addr show
echo "Hello from container" > /tmp/test.txt
cat /tmp/test.txt
```

3. Exit the container:

```bash
exit
```

---

## Task 2: Manage Container Images

### Subtask 2.1: Image Operations

1. List images:

```bash
podman images
```

2. Search for images:

```bash
podman search nginx
```

3. Pull a specific version:

```bash
podman pull docker.io/library/nginx:1.21-alpine
```

4. Inspect an image:

```bash
podman inspect httpd:latest
```

---

### Subtask 2.2: Image Management

1. Tag an image:

```bash
podman tag httpd:latest my-custom-web:v1.0
```

2. Verify:

```bash
podman images | grep my-custom-web
```

3. Remove the tag:

```bash
podman rmi my-custom-web:v1.0
```

4. Prune unused images:

```bash
podman image prune
```

---

### Subtask 2.3: Build a Custom Image

1. Create a working directory:

```bash
mkdir ~/custom-web-app && cd ~/custom-web-app
```

2. Create `index.html`:

```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>My Custom Web App</title></head>
<body>
<h1>Welcome to My Container Lab</h1>
<p>This is a custom web application running in Podman!</p>
<p>Lab 18: Introduction to Containers with Podman</p>
</body>
</html>
EOF
```

3. Create a `Containerfile`:

```bash
cat > Containerfile << 'EOF'
FROM httpd:latest
COPY index.html /usr/local/apache2/htdocs/
EXPOSE 80
EOF
```

4. Build the image:

```bash
podman build -t my-web-app:latest .
```

5. Run the container:

```bash
podman run -d --name custom-web -p 8081:80 my-web-app:latest
```

6. Test:

```bash
curl http://localhost:8081
```

---

## Task 3: Run and Manage Container Services

### Subtask 3.1: Lifecycle Management

```bash
podman ps -a
podman stop my-web-server
podman start my-web-server
podman restart my-web-server
podman logs my-web-server
podman logs -f my-web-server
```

---

### Subtask 3.2: Advanced Operations

1. Execute a shell in a running container:

```bash
podman exec -it my-web-server /bin/bash
```

2. Explore:

```bash
ls -la /usr/local/apache2/conf/
cat /usr/local/apache2/htdocs/index.html
exit
```

3. Copy files:

```bash
echo "This file was copied from host" > host-file.txt
podman cp host-file.txt my-web-server:/usr/local/apache2/htdocs/
podman cp my-web-server:/usr/local/apache2/htdocs/index.html ./container-index.html
```

4. Monitor resources:

```bash
podman stats my-web-server
```

---

### Subtask 3.3: Volumes

```bash
podman volume create web-data
podman volume ls
podman run -d --name web-with-volume -p 8082:80 -v web-data:/usr/local/apache2/htdocs httpd:latest
podman exec web-with-volume sh -c 'echo "<h1>Data from Volume</h1>" > /usr/local/apache2/htdocs/volume.html'
curl http://localhost:8082/volume.html
podman volume inspect web-data
```

---

### Subtask 3.4: Networking

```bash
podman network create lab-network
podman network ls
```

Run containers on the network:

```bash
podman run -d --name lab-database --network lab-network -e MYSQL_ROOT_PASSWORD=labpassword mysql:8.0
podman run -d --name lab-webapp --network lab-network -p 8083:80 httpd:latest
```

> **Note:** The `httpd` image is not Debian-based. Package installation with `apt-get` will fail. Use a diagnostic image if needed.

Test connectivity:

```bash
podman exec lab-webapp ping -c 3 lab-database
```

---

### Subtask 3.5: Cleanup

```bash
podman stop $(podman ps -q)
podman rm my-web-server custom-web interactive-centos
podman rm -v web-with-volume
podman container prune
podman image prune
podman volume prune
podman network prune
```

Verify:

```bash
podman ps -a
podman images
podman volume ls
podman network ls
```
