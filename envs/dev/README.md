# Development environment

The `dev` environment contains configurations and overrides for the development environment.

## Folder Structure

This folder follows the same structure as the [base](../../base/README.md) folder:

- **`apps/`**: Application deployments
- **`namespaces/`**: Namespace bound besources that are not directly applicable to an application

## Environment characteristics

The development environment typically features:

- **Deviations from base/production are expected**: The development environment often differs from base or production to support rapid iteration and testing
- **Lower resource limits**: Resource allocations suitable for development workloads
- **Relaxed security settings**: Less restrictive policies to facilitate development

## Environment purpose

This environment is used for:

- **Experimentation**: Safe environment for trying new configurations
- **Feature development**: Testing new features and changes
