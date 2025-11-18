# Acceptance Environment

The `acc` environment contains configurations and overrides for the acceptance environment.

## Folder Structure

This folder follows the same structure as the [base](../../base/README.md) folder:

- **`apps/`**: Application deployments
- **`namespaces/`**: Namespace bound besources that are not directly applicable to an application

## Environment characteristics

The acceptance environment typically features:

- **Production like settings**: Configurations that mirror production as closely as possible
- **Quality Assurance**: Environment for final testing before production deployment

## Environment purpose

This environment is used for:

- **Acceptance testing**: Final (stakeholder) validation before production deployment
- **Performance testing**: Load and performance validation
