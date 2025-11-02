#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPACTION_CONFIG_DIR="$SCRIPT_DIR/compaction"
COMPACTION_OUTPUT_DIR="$COMPACTION_CONFIG_DIR/output"
CLLM_CMD="${CLLM_CMD:-cllm}"

mkdir -p "$COMPACTION_OUTPUT_DIR"

if ! command -v "$CLLM_CMD" >/dev/null 2>&1; then
  echo "Error: Unable to find the \`cllm\` CLI in PATH. Install it with:" >&2
  echo "  uv tool install https://github.com/o3-cloud/cllm.git" >&2
  exit 1
fi

"$CLLM_CMD" --version >/dev/null 2>&1 || {
  echo "Error: \`cllm --version\` failed; verify your installation." >&2
  exit 1
}

CONVERSATION_ID="$(uuidgen)"
BASE_ARGS=(--cllm-path "$COMPACTION_CONFIG_DIR" --conversation "$CONVERSATION_ID")
SUMMARY_ARGS=("${BASE_ARGS[@]}" --read-only)

FILE_DIRECTORY="docs/decisions"

for FILE_PATH in "$FILE_DIRECTORY"/*; do
  [ -f "$FILE_PATH" ] || continue
  echo "Processing file: $FILE_PATH"
  echo "-----------------------------------"
  "$CLLM_CMD" "${BASE_ARGS[@]}" <"$FILE_PATH"
done

printf '%s\n' "Give me a summary of everything you collected so far without losing any key points or details." \
  | "$CLLM_CMD" "${SUMMARY_ARGS[@]}" >"$COMPACTION_OUTPUT_DIR/compacted_summary.txt"

