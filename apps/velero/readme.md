Remove all backups:
``` 
    velero backup get | tail -n +2 | awk '{{ print $1 }}' | xargs -I {} velero backup delete {} --confirm
```

## How to cleanup
When you delete a velero backup the restic volume is still present in Minio. To fully (clean) remove a restic backup you must do the following steps.

1. Remove the backup of the persistent volume in minio. For example when I made a backup of the etam-abacus-prd namespace with volume backup i need to remove the folder: /restic/team-abacus-prd in the Velero bucket in Minio.
2. Remove the corresponding resticrepositories.velero.io in Kubernets: kubectl -n velero get resticrepositories.velero.io ; kubectl -n velero delete resticrepositories.velero.io <NAME>