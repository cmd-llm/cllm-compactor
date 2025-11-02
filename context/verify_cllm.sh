#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPACTION_CONFIG_DIR="$SCRIPT_DIR/compaction"
CLLM_CMD="${CLLM_CMD:-cllm}"

if ! command -v "$CLLM_CMD" >/dev/null 2>&1; then
  echo "Error: \`cllm\` CLI not found in PATH." >&2
  exit 1
fi

echo "Checking cllm version..."
"$CLLM_CMD" --version

CONVERSATION_ID="compactor-smoke-$(uuidgen)"
BASE_ARGS=(--cllm-path "$COMPACTION_CONFIG_DIR" --conversation "$CONVERSATION_ID")

echo "Running smoke prompt..."
"$CLLM_CMD" "${BASE_ARGS[@]}" "Smoke check: respond with OK." >/dev/null
"$CLLM_CMD" "${BASE_ARGS[@]}" --read-only "Summarize the prior response with one calm word." >/dev/null

echo "Cleaning up smoke conversation..."
"$CLLM_CMD" --cllm-path "$COMPACTION_CONFIG_DIR" --delete-conversation "$CONVERSATION_ID" >/dev/null

echo "cllm verification complete."
