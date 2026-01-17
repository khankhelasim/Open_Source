# Task 1: Configure an NFS Server

## Subtask 1.1: Install and Configure NFS Server

### Step 1: Update system and install NFS utilities (server1)

```bash
sudo dnf update -y
sudo dnf install -y nfs-utils
```

### Step 2: Create NFS shared directories

```bash
sudo mkdir -p /nfs/shared /nfs/data
sudo chmod 755 /nfs/shared /nfs/data
sudo chown nobody:nobody /nfs/shared /nfs/data
```

### Step 3: Configure NFS exports

Edit the exports file:

```bash
sudo nano /etc/exports
```

Add the following entries:

```
/nfs/shared *(rw,sync,no_subtree_check,no_root_squash)
/nfs/data   *(rw,sync,no_subtree_check,no_root_squash)
```

**Export Options Explained:**

* `rw` – Read/write access
* `sync` – Synchronous writes for data integrity
* `no_subtree_check` – Improves performance
* `no_root_squash` – Allows root access from clients (⚠️ not recommended for production)

### Step 4: Start and enable NFS services

```bash
sudo systemctl enable --now rpcbind nfs-server
sudo exportfs -a
sudo exportfs -v
```

---

## Subtask 1.2: Configure NFS Client (server2)

### Step 1: Install NFS client utilities

```bash
sudo dnf install -y nfs-utils
sudo mkdir -p /mnt/nfs-shared /mnt/nfs-data
```

### Step 2: Mount NFS shares

```bash
SERVER_IP="192.168.1.10"  # Replace with actual IP

sudo mount -t nfs ${SERVER_IP}:/nfs/shared /mnt/nfs-shared
sudo mount -t nfs ${SERVER_IP}:/nfs/data /mnt/nfs-data

df -h | grep nfs
```

### Step 3: Test NFS functionality

```bash
echo "Hello from NFS client" | sudo tee /mnt/nfs-shared/test.txt
```

Verify on server1:

```bash
cat /nfs/shared/test.txt
```

### Step 4: Configure persistent mounts

```bash
echo "${SERVER_IP}:/nfs/shared /mnt/nfs-shared nfs defaults 0 0" | sudo tee -a /etc/fstab
echo "${SERVER_IP}:/nfs/data /mnt/nfs-data nfs defaults 0 0" | sudo tee -a /etc/fstab

sudo umount /mnt/nfs-shared /mnt/nfs-data
sudo mount -a
```

---

# Task 2: Set Up Ceph Distributed Block Storage

## Subtask 2.1: Install Ceph Components

### Step 1: Prepare all Ceph nodes (server1, server2, server3)

```bash
sudo dnf install -y centos-release-ceph-pacific
sudo dnf install -y ceph ceph-radosgw cephadm
```

### Step 2: Bootstrap Ceph cluster (server1)

```bash
sudo cephadm bootstrap --mon-ip 192.168.1.10
```

> Save the dashboard URL and admin password.

### Step 3: Add additional hosts

```bash
sudo ceph orch host add server2 192.168.1.11
sudo ceph orch host add server3 192.168.1.12

sudo ceph status
```

---

## Subtask 2.2: Configure Ceph Storage

### Step 1: Add OSDs

```bash
sudo ceph orch device ls
sudo ceph orch daemon add osd server1:/dev/sdb
sudo ceph orch daemon add osd server2:/dev/sdb
sudo ceph orch daemon add osd server3:/dev/sdb

sudo ceph osd status
```

### Step 2: Create RBD pool

```bash
sudo ceph osd pool create rbd 32 32
sudo ceph osd pool application enable rbd rbd
sudo rbd pool init rbd
```

### Step 3: Create block device

```bash
sudo rbd create --size 10G rbd/test-volume
sudo rbd ls rbd
sudo rbd info rbd/test-volume
```

---

## Subtask 2.3: Test Ceph Block Storage

```bash
sudo rbd map rbd/test-volume
rbd showmapped
sudo mkfs.ext4 /dev/rbd0
sudo mkdir -p /mnt/ceph-block
sudo mount /dev/rbd0 /mnt/ceph-block

echo "Hello from Ceph block storage" | sudo tee /mnt/ceph-block/test.txt
```

---

# Task 3: Integrate NFS and Ceph with Kubernetes

## Subtask 3.1: NFS Storage in Kubernetes

### Create Persistent Volume

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: nfs-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteMany
  nfs:
    server: 192.168.1.10
    path: /nfs/shared
  persistentVolumeReclaimPolicy: Retain
```

### Create Persistent Volume Claim

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: nfs-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 5Gi
```

### Deploy application using NFS

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nfs-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nfs-app
  template:
    metadata:
      labels:
        app: nfs-app
    spec:
      containers:
      - name: app
        image: nginx:latest
        volumeMounts:
        - name: nfs-storage
          mountPath: /usr/share/nginx/html
      volumes:
      - name: nfs-storage
        persistentVolumeClaim:
          claimName: nfs-pvc
```

---

## Subtask 3.2: Ceph Storage in Kubernetes

### Install Ceph CSI Driver

```bash
git clone https://github.com/ceph/ceph-csi.git
cd ceph-csi/deploy/rbd/kubernetes
kubectl apply -f .
```

### Create StorageClass

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ceph-rbd
provisioner: rbd.csi.ceph.com
parameters:
  clusterID: <CEPH_FSID>
  pool: rbd
  imageFeatures: layering
reclaimPolicy: Delete
allowVolumeExpansion: true
```

### Create Ceph Secret

```bash
kubectl create secret generic csi-rbd-secret \
  --from-literal=userID=admin \
  --from-literal=userKey=$(sudo ceph auth get-key client.admin)
```

### Create PVC and Deploy Application

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ceph-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: ceph-rbd
```
