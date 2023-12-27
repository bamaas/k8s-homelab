# K8S HomeLab

## Prerequisites

- Sops
- Azure CLI
- SSH root access to manager node

## To do

* Set env vars to access keyvault instead of az cli usage
* Deploy apps with the use of ArgoCD.
* Proper disaster recovery for ArgoCD.
* ArgoCD + Helm Secrets setup: https://medium.com/@mprzygrodzki/argocd-with-helm-secrets-and-kms-encryption-1f0944728873
* In case of DNS failure backups will fail because nas.lan can't be resolved. Longhorn and nfs-subdir is making use of that hostname.
set nas.lan in /etc/hosts

## Velero usage

### Schedule

```
velero schedule create manifests --schedule="@every 24h" --default-volumes-to-restic=false --ttl 720h0m0s
```

### Backup

```
velero backup create mybackup --include-namespaces <NAMESPACE_NAME>
```

### Restore

```
velero restore create <RESTORE_NAME> --from-backup <BACKUP_NAME> --include-namespaces <NAMESPACE_NAME>
```

