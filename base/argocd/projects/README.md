# Projects

ArgoCD [AppProject](https://argo-cd.readthedocs.io/en/stable/user-guide/projects/) definitions for resource access control.

## Folder Structure

```bash
projects/
├── README.md               # This file
├── kustomization.yaml      # Combines all project definitions
├── applications.yaml       # Project for application workloads
└── platform.yaml           # Project for platform infrastructure
```

## Purpose

This directory contains AppProject definitions that provide:

- **RBAC**: Role-based access control for ArgoCD resources
- **Governance**: Restrictions on what can be deployed and where
- **Security**: Source repository and destination namespace restrictions
- **Isolation**: Logical separation between different types of workloads

### Projects overview

#### `applications`

- **Purpose**: Manages application workloads (ingress-nginx, victoria-logs, etc.)
- **Scope**: Application namespaces
- **Permissions**: Standard application resources (Deployments, Services, Ingress, etc.)
- **Used by**: ApplicationSets that deploy business applications

#### `platform`

- **Purpose**: manages platform infrastructure (namespace utilities, resource quotas, etc.)
- **Scope**: All namespaces
- **Permissions**: Infrastructure resources (Namespaces, ResourceQuotas, LimitRanges, etc.)
- **Used by**: ApplicationSets that deploy platform components

## Important notes

- **Default Project**: Avoid using the `default` project for actual workloads
- **Bootstrap dependency**: The `argocd-system` project must exist before other projects can be created