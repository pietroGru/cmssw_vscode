#!/bin/bash
# Wrapper to run clangd inside CMSSW EL8 container with environment setup

# Load your environment
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
cd "$SCRIPT_DIR"

# Escape user-passed arguments safely
set -euo pipefail
USER_ARGS=$(printf ' %q' "$@")

# Combine fixed default args with user-passed args
# Note: $CMSSW_BASE will expand *inside* the container after cmsenv sets it
DEFAULT_ARGS="--limit-references=100 --header-insertion=never --limit-results=20 -j=1 --background-index=false --pch-storage=memory --compile-commands-dir=\$CMSSW_BASE"

# Run clangd silently inside container
exec cmssw-el8 \
  --command-to-run "cmsenv 2>&1 && exec clangd ${DEFAULT_ARGS} ${USER_ARGS}"