# Namespaces

The `namespaces` folder contains Kubernetes namespace definitions and their associated configurations for organizing cluster resources.

## Folder Structure

- **`bar/`**: Configuration for the "bar" namespace including resource quotas.
- **`foo/`**: Configuration for the "foo" namespace including resource quotas.
- **`kustomization.yaml`**: Kustomize configuration that includes both namespace folders.

## Namespace Configuration

Each namespace folder contains:
- **`kustomization.yaml`**: Defines the namespace scope and included resources
- **`resourcequota.yaml`**: Sets resource limits and quotas for the namespace

## Purpose

These namespaces provide:
- **Resource Isolation**: Separate environments for different applications or teams
- **Resource Management**: Defined quotas to prevent resource overconsumption
- **Access Control**: Namespace-based security and access boundaries
- **Organization**: Logical separation of cluster workloads

## Environment Overrides

Environment-specific deployments may rename these namespaces:
- In production, "foo" might become "x" and "bar" might become "y"
- Each environment can apply its own naming conventions and resource limits
