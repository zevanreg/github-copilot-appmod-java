#!/usr/bin/env bash
set -e

missing_required=0

check_tool() {
  local label="$1"
  local cmd="$2"
  local version_cmd="$3"

  if command -v "$cmd" >/dev/null 2>&1; then
    echo "OK: $label"
    eval "$version_cmd"
  else
    echo "MISSING: $label"
    missing_required=1
  fi
}

echo "=============================================="
echo " Post-create: verifying hackathon prerequisites"
echo "=============================================="

echo ""
echo "--- Java ---"
check_tool "Java runtime" "java" 'java -version'
check_tool "Java compiler" "javac" 'javac -version'

echo ""
echo "--- Maven ---"
check_tool "Maven" "mvn" 'mvn -version'

echo ""
echo "--- Git ---"
check_tool "Git" "git" 'git --version'

echo ""
echo "--- GitHub CLI ---"
check_tool "GitHub CLI" "gh" 'gh --version'

echo ""
echo "--- Azure CLI ---"
check_tool "Azure CLI" "az" 'az --version | head -n 1'

echo ""
echo "--- Azure Developer CLI (azd) ---"
check_tool "Azure Developer CLI (azd)" "azd" 'azd version'

echo ""
echo "--- Docker ---"
check_tool "Docker" "docker" 'docker --version'

echo ""
if [ "$missing_required" -ne 0 ]; then
  echo "=============================================="
  echo " One or more required prerequisites are missing."
  echo " Please install the missing tools and recreate the dev container."
  echo "=============================================="
  exit 1
fi
echo "=============================================="
echo " Dev container ready."
echo ""
echo " Next steps:"
echo "  1. Sign in to GitHub:  gh auth login"
echo "  2. Sign in to Azure:   az login --use-device-code"
echo "  3. Select Claude Sonnet 4.6 in Copilot Chat model picker"
echo "=============================================="
