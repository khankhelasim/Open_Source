## Troubleshooting Highlights

### NFS

* Check exports: `exportfs -v`
* Open firewall: `firewall-cmd --add-service=nfs --permanent`
* Verify permissions on `/nfs/shared`

### Ceph

* Cluster health: `ceph status`, `ceph health detail`
* OSD issues: `ceph osd tree`
* RBD module: `modprobe rbd`

### Kubernetes

* PVC pending: `kubectl describe pvc`
* CSI pods: `kubectl get pods -n kube-system`

---
