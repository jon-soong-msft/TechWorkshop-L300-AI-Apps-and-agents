#!/bin/bash
# validate-env.sh - Helper script to validate .env file format

ENV_FILE="src/.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "❌ .env file not found at $ENV_FILE"
    echo "📋 Copy src/env_sample.txt to src/.env and fill in your values"
    exit 1
fi

echo "✅ .env file found"

# Check for common required variables
required_vars=(
    "AZURE_OPENAI_ENDPOINT"
    "AZURE_OPENAI_KEY"
    "SEARCH_ENDPOINT" 
    "SEARCH_KEY"
    "COSMOS_ENDPOINT"
    "COSMOS_KEY"
)

missing_vars=()

for var in "${required_vars[@]}"; do
    if ! grep -q "^${var}=" "$ENV_FILE" || grep -q "^${var}=\"\"$" "$ENV_FILE" || grep -q "^${var}=$" "$ENV_FILE"; then
        missing_vars+=("$var")
    fi
done

if [ ${#missing_vars[@]} -eq 0 ]; then
    echo "✅ All required environment variables appear to be set"
    echo "📝 Remember to add the complete contents of this file to the GitHub secret 'ENV'"
else
    echo "⚠️  The following required variables are missing or empty:"
    for var in "${missing_vars[@]}"; do
        echo "   - $var"
    done
    echo ""
    echo "📋 Please update your .env file with the missing values"
fi

echo ""
echo "🔒 Security check:"
if git check-ignore "$ENV_FILE" > /dev/null 2>&1; then
    echo "✅ .env file is properly ignored by git"
else
    echo "❌ WARNING: .env file is NOT ignored by git!"
    echo "   This could expose secrets. Check your .gitignore file."
fi