# Bootstrap

Foundation configuration for ArgoCD system initialization and self-management.

## Folder structure

```bash
bootstrap/
├── README.md                                # This file
├── kustomization.yaml                       # Kustomize configuration combining all bootstrap resources
├── argocd-system-project.yaml               # ArgoCD system management project definition
└── bootstrap-system-applicationset.yaml     # ApplicationSet for auto-discovering ArgoCD components
```

## Purpose

This directory contains the foundational resources required to bootstrap an ArgoCD instance. These resources are deployed manually once and then create the GitOps system that manages all other ArgoCD configurations (projects, applicationsets) automatically.

### Key components

#### `argocd-system-project.yaml`

- **Purpose**: Defines the ArgoCD system management project
- **Scope**: ArgoCD namespace only
- **Permissions**: Restricted to ArgoCD resources (Applications, ApplicationSets, AppProjects)

#### `bootstrap-system-applicationset.yaml`

- **Purpose**: Automatically discovers and creates Applications for ArgoCD system components
- **Discovers**: All directories under `base/argocd/*` (except bootstrap itself)
- **Creates**: `argocd-projects`, `argocd-applicationsets` Applications

### What happens during bootstrap process

```bash
1. Manual Bootstrap
   └── kubectl apply -k envs/<env>/argocd/bootstrap/
       ├── Creates AppProject 'argocd-system'
       ├── Applies ConfigMap 'argocd-cm' (ArgoCD configuration)
       └── Deploys ApplicationSet 'bootstrap-system'

2. Automatic Discovery (by bootstrap-system ApplicationSet)
   ├── Discovers base/argocd/projects/
   │   └── Creates Application 'argocd-projects'
   │       └── Deploys AppProjects: 'applications', 'platform'
   └── Discovers base/argocd/applicationsets/
       └── Creates Application 'argocd-applicationsets'
           └── Deploys ApplicationSets: 'applications', 'namespaces'

3. Application Generation (by ApplicationSets)
   ├── ApplicationSet 'applications'
   │   └── Discovers envs/*/apps/*
   │       └── Generates Application per app (e.g., devex-dev-ingress-nginx)
   └── ApplicationSet 'namespaces'
       └── Discovers envs/*/namespaces/*
           └── Generates Application per namespace utility (e.g., devex-dev-ns-dev-foo)
```

## Usage

### Initial bootstrap

```bash
kubectl apply -k envs/<env>/argocd/bootstrap/
```

### Adding new ArgoCD components

To add a new ArgoCD component type (e.g., `repositories/`, `rbac/`):

1. Create new directory under `base/argocd/`:

   ```bash
   mkdir base/argocd/repositories/
   ```

2. Add your resources and kustomization.yaml

3. Commit and push to Git

4. ApplicationSet `bootstrap-system` automatically discovers and creates an ArgoCD Application for it

## Important notes

- **Manual deployment**: bootstrap resources are deployed manually, not via GitOps
- **One-time setup**: bootstrap is only run once per ArgoCD instance
- **Foundation layer**: everything else in ArgoCD is managed by the bootstrap ApplicationSet
- **Self expanding**: Adding new directories under `base/argocd/` automatically creates Applications
