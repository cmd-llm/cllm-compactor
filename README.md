# cllm-compactor

Simple bash tooling that wraps the `cllm` CLI to squeeze large or scattered context
into focused prompts. The goal is to make it easy to stage relevant excerpts before
handing them to an AI assistant.

---

## What We’re Building

- Bash-friendly wrapper for `cllm` that trims big or scattered inputs into a prompt-ready digest
- Defaults aimed at preserving nuance while staying small enough for quick LLM handoffs
- Reusable patterns you can graft into dotfiles, git hooks, or CI steps

---

## Existing Experiments You Can Peek At

- `context/compaction.sh` loops over ADRs, feeds them into `cllm`, and saves a final summary
- `context/compaction/Cllmfile.yml` pins the summarizer persona we liked during early tests
- `context/compaction/output/compacted_summary.txt` shows the tone and fidelity we’re chasing

Use these as inspiration—not final code. We’ll streamline the flow, add guardrails, and expose
flags once the main script shapes up.

---

## Prerequisite: Install `cllm`

- We test with `cllm` CLI **v0.1.6 or newer** from [o3-cloud/cllm](https://github.com/o3-cloud/cllm)
- Install with `uv tool install https://github.com/o3-cloud/cllm.git`
- Verify the install before running scripts: `cllm --version`

---

## Quick Verification

- Run `context/verify_cllm.sh` to confirm the CLI responds with your local config
- The script issues a short smoke prompt, replays it in read-only mode, and cleans up the conversation

---

## Current Focus

- Mapping the input discovery model (globs vs. explicit file lists vs. piped stdin)
- Designing how conversations, config files, and temp output should coexist
- Sketching a minimal verification step to catch broken `cllm` invocations

---

## How to Contribute Ideas Now

- Drop notes about real-world compaction pain points
- Point out must-have safety checks (binary filters, size caps, redaction hints)
- Share `cllm` command patterns that already work well for you

---

## Next Readme Update

Expect installation, usage snippets, and testing pointers once the script hits its first draft.
