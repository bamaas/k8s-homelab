# ArgoCD Configuration

Base ArgoCD configuration for GitOps based continuous delivery.

## Folder Structure

```bash
argocd/
├── README.md               # This file
├── bootstrap/              # Bootstrap configuration (manual deployment)
├── projects/               # AppProject definitions (GitOps managed)
└── applicationsets/        # ApplicationSet definitions (GitOps managed)
```

## Overview

This directory contains the foundational ArgoCD configuration that provides:

- **Automatic bootstrapping** of ArgoCD system components.
- **Dynamic application discovery** using [ApplicationSets](https://argo-cd.readthedocs.io/en/latest/user-guide/application-set/).
- **RBAC and governance** through [AppProjects](https://argo-cd.readthedocs.io/en/stable/user-guide/projects/).
- **Consistent configuration** across environments by leveraging Kustomize overlays.
