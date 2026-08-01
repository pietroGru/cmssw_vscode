#!/usr/bin/env bash
# Example wrapper for clangd

# Load your environment (adapt this line!)
SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"   # /eos/home-p/pgrutta/work/stripClust/CMSSW_16_0_0_pre2
cd $SCRIPT_DIR
cmsenv 2>&1

# Optionally print for debugging
# env | grep -E "LD_LIBRARY_PATH|INCLUDE"

# Execute clangd with all passed arguments
exec clangd \
  --limit-references=100 \
  --header-insertion=never \
  --limit-results=20 \
  -j=1 \
  --background-index=false \
  --pch-storage=memory \
  --compile-commands-dir="$CMSSW_BASE" "$@"