#!/usr/bin/env bash
set -e

echo "=============================================="
echo " Post-create: verifying hackathon prerequisites"
echo "=============================================="

echo ""
echo "--- Java ---"
java -version || true
javac -version || true

echo ""
echo "--- Maven ---"
mvn -version || true

echo ""
echo "--- Git ---"
git --version || true

echo ""
echo "--- GitHub CLI ---"
gh --version || true

echo ""
echo "--- Azure CLI ---"
az --version | head -n 1 || true

echo ""
echo "--- Azure Developer CLI (azd) ---"
azd version || true

echo ""
echo "--- Docker ---"
docker --version || true

echo ""
echo "=============================================="
echo " Dev container ready."
echo ""
echo " Next steps:"
echo "  1. Sign in to GitHub:  gh auth login"
echo "  2. Sign in to Azure:   az login --use-device-code"
echo "  3. Select Claude Sonnet 4.6 in Copilot Chat model picker"
echo "=============================================="
