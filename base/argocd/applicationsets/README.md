# ApplicationSets

Dynamic [ArgoCD Application](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#applications) discovery and generation using [ArgoCD ApplicationSets](https://argo-cd.readthedocs.io/en/latest/user-guide/application-set/).

## Folder structure

```bash
applicationsets/
├── README.md               # This file
├── kustomization.yaml      # Combines all ApplicationSet definitions
├── applications.yaml       # ApplicationSet for discovering application workloads
└── namespaces.yaml         # ApplicationSet for discovering namespace utilities
```

## Purpose

This directory contains ApplicationSet definitions that automatically:

- **Discover** directories in the Git repository
- **Generate** ArgoCD Applications dynamically
- **Deploy** workloads without manual Application creation

### ApplicationSet overview

#### `applications`

- **Purpose**: discovers and deploys application workloads
- **Discovers**: directories under `envs/*/apps/*`
- **Generates**: applications like `devex-dev-ingress-nginx`, `devex-dev-victoria-logs`
- **Project**: `applications`
- **Sync policy**: automated with prune and self-heal

#### `namespaces`

- **Purpose**: discovers and deploys namespace utilities
- **Discovers**: directories under `envs/*/namespaces/*`
- **Generates**: ArgoCD Applications like `devex-dev-ns-dev-foo`, `devex-dev-ns-dev-bar`
- **Project**: `platform`
- **Sync policy**: automated with prune and self-heal
