# Azure Container Registry Deployment Setup

This repository includes a GitHub Actions workflow that automatically builds and deploys the AI Shopping Assistant application to Azure Container Registry when changes are pushed to the main branch.

## Prerequisites

1. An Azure Container Registry (ACR) instance
2. Service Principal or Admin credentials for the ACR
3. GitHub repository secrets configured

## Required GitHub Secrets

Configure the following secrets in your GitHub repository (Settings > Secrets and variables > Actions):

### 1. `ACR_USERNAME`
The username for your Azure Container Registry. This can be:
- The registry name (if admin user is enabled)
- Service Principal application ID

### 2. `ACR_PASSWORD`
The password for your Azure Container Registry. This can be:
- The registry password (if admin user is enabled)  
- Service Principal password/secret

### 3. `ENV`
The complete contents of your .env file with all environment variables. Copy the entire content from your local .env file into this secret.

Example content:
```
OTEL_INSTRUMENTATION_GENAI_CAPTURE_MESSAGE_CONTENT="true"
AZURE_OPENAI_ENDPOINT="https://your-endpoint.openai.azure.com/"
AZURE_OPENAI_KEY="your-api-key"
# ... all other environment variables
```

## Workflow Configuration

Update the following values in `.github/workflows/deploy-to-acr.yml`:

```yaml
env:
  REGISTRY_NAME: your-acr-name  # Replace with your ACR name (without .azurecr.io)
```

## How to Get ACR Credentials

### Option 1: Enable Admin User (Simpler)
```bash
# Enable admin user
az acr update -n your-acr-name --admin-enabled true

# Get credentials
az acr credential show --name your-acr-name
```

Use:
- `ACR_USERNAME`: The registry name
- `ACR_PASSWORD`: Either password or password2 from the output

### Option 2: Service Principal (Recommended for Production)
```bash
# Create service principal with push permissions
az ad sp create-for-rbac --name your-sp-name --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.ContainerRegistry/registries/{acr-name} --role AcrPush
```

Use:
- `ACR_USERNAME`: The `appId` from the output
- `ACR_PASSWORD`: The `password` from the output

## Workflow Triggers

The workflow is triggered on:
- Push to the `main` branch
- Changes in the `src/` folder

## Image Tags

The workflow creates two tags for each build:
- `{acr-name}.azurecr.io/ai-shopping-assistant:{git-sha}` - Specific commit version
- `{acr-name}.azurecr.io/ai-shopping-assistant:latest` - Latest version

## Security Notes

- The .env file is created temporarily during the build process and cleaned up immediately
- Environment variables are passed securely through GitHub Secrets
- The .env file is excluded from version control via .gitignore
- The build process uses Docker layer caching for faster builds

## Local Development

For local development, create a .env file in the `src/` folder based on `env_sample.txt` with your actual values. This file will not be committed to the repository.