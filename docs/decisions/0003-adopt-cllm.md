---
status: "accepted"
date: 2025-11-01
decision-makers: ["Owen Zanzal"]
consulted: []
informed: []
ai-agents: ["GPT-5 Codex CLI"]
autonomy-level: "assistive"
tags: ["architecture", "ai", "tooling"]
---

# Adopt CLLM for Context Compaction Workflows

## Context and Problem Statement

`cllm-compactor` aims to squeeze sprawling decision records and project notes into
focused prompts that humans and AI agents can reuse. We need a programmable, bash-first
interface to large language models that supports chaining inputs, consistent
configuration, and conversation reuse without building bespoke SDK plumbing. Today’s
prototypes shell out to `cllm`, but the project has not formally committed to the tool
or documented why it fits this niche.

## Vibe Context

Interactions with the compaction pipeline should feel transparent, reliable, and calm.
Operators—human or AI—should sense that the tooling wraps LLM orchestration in clean,
predictable commands that stay close to the shell workflows we already favor.

## Decision Drivers

- Keep the compaction flow bash-native so contributors can script without new runtime
- Support multi-turn conversations and read-only reuse for compaction templates
- Lean on a community-maintained CLI with guardrails (structured output, logging)
- Avoid re-implementing provider switching, token accounting, or prompt streaming

## Considered Options

- Standardize on the `cllm` CLI and configuration model
- Build custom wrappers around provider SDKs or the LiteLLM Python client directly
- Depend on web UIs or ad-hoc scripts for manual LLM interactions

## Decision Outcome

Chosen option: **"Standardize on the `cllm` CLI and configuration model"**, because it
already delivers bash-friendly conversation management, provider abstraction via
LiteLLM, Jinja-powered templating, and read-only replay features that align with the
compactor’s needs while letting us ship value immediately.

### Consequences

- Good: Reuses `cllm` conversation management to persist compaction runs and summaries
- Good: Gains 100+ model options and structured outputs without extra integration work
- Good: Shares configuration between local scripts and future CI automation via
  `Cllmfile.yml`
- Bad: Inherits `cllm`’s release cadence and must track upstream breaking changes

### Confirmation

- ✅ Guarded `context/compaction.sh` with `cllm` availability checks (context/compaction.sh:12-21)
- ✅ Provided smoke helper `context/verify_cllm.sh` for verification
- ✅ Markdown linting configured via Trunk tooling

---

## Pros and Cons of the Options

### Standardize on `cllm` (Chosen)

Adopt the open-source CLI, use its `.cllm/` project scaffolding, and script compaction
runs through bash pipelines and conversations.

- Good: Rich CLI that already mirrors the bash ergonomics we target
- Good: Read-only conversations and config precedence simplify prompt template reuse
- Neutral: Requires contributors to install Python + `uv` or rely on `uv tool install`
- Bad: Upstream design decisions (flags, defaults) can shift without notice

### Roll Our Own LiteLLM Wrapper

Write a custom Python or bash tool that calls LiteLLM or provider SDKs directly,
replicating conversation storage and configuration logic in-repo.

- Good: Full control over features and release timing
- Good: Could slim dependencies to exactly what compaction needs
- Bad: Duplicates effort that the `cllm` maintainers already handle
- Bad: Significantly higher maintenance burden for token tracking and config merging

### Manual or Ad-Hoc Workflows

Keep using assorted scripts or provider dashboards to gather summaries on demand.

- Good: Zero additional dependencies to install
- Bad: No reproducible pipeline for automation or CI hooks
- Bad: Human-in-the-loop steps risk drift, tone shifts, and missing context

---

## More Information

Monitor the [`cllm` ADR catalog](https://github.com/o3-cloud/cllm/tree/main/docs/adr)
for roadmap changes, especially around configuration formats or conversation storage.
Revisit this ADR if the CLI’s licensing, maintenance velocity, or provider coverage
shifts materially, or if our compaction needs demand features `cllm` cannot support.

---

# AI-Specific Sections

## AI Guidance Level

Chosen level: **flexible**

## AI Tool Preferences

- Primary tool: CLLM CLI
- Model/version: Follow `context/compaction/Cllmfile.yml` defaults (currently GPT-4o
  tier via LiteLLM)
- Parameters: Use compaction presets; adjust temperature or max tokens per run as
  needed
- Context files: README.md, docs/decisions/*.md, context/compaction/Cllmfile.yml,
  templates/VIBE_ADR_TEMPLATE.md

## Test Expectations

- Test 1: `context/compaction.sh` runs successfully using local `.cllm` assets
- Test 2: `context/verify_cllm.sh` completes without errors
- Acceptance criteria: Compacted summaries remain faithful to source ADRs across at
  least two different provider models

---

## Next Steps

### Immediate Actions

- Ensure contributors install `cllm` via `uv tool install` or equivalent package method
- Refresh `context/compaction` configs to match the latest `cllm` schema

### Implementation Sequence

1. Document the install command and minimum version in README usage notes
2. Parameterize `context/compaction.sh` so it fails fast if `cllm` is missing
3. Add lightweight verification scripts for CI and local pre-flight checks
4. Capture confirmation evidence in this ADR once the pipeline ships

### Ownership

- Primary implementer: Owen Zanzal
- Supporting roles: GPT-5 Codex CLI
- Stakeholders to notify: Future repo collaborators

---

## Dependencies

- ADR-0001: Adopt Vibe ADR for Decision Records
- ADR-0002: Define llms.txt Bootstrap Instructions
- Component: Context compaction pipeline
- External dependency: `cllm` CLI releases and LiteLLM provider coverage

---

## Risk Assessment

### Technical Risks

- `cllm` may change flag names or configuration formats — mitigate by pinning a tested
  version and monitoring upstream release notes
- Multi-provider behavior differs subtly — mitigate with smoke prompts across preferred
  models

### Business Risks

- Contributors unfamiliar with Python tooling may hit blockers installing `cllm` —
  mitigate by scripting `uv tool install` and documenting prerequisites
- Reliance on third-party CLI — mitigate by caching critical configs and monitoring
  project health

---

## Human Review

- Review required: yes
- Reviewers: Owen Zanzal
- Review stage: before
- Review criteria: Accuracy of `cllm` feature summary, dependency pinning strategy,
  confirmation steps

---

## Feedback Log

### Implementation Notes

- 2025-10-29: Decision drafted; compaction script updates pending

### AI Agent Feedback

- GPT-5 Codex CLI (2025-10-29): Recommend adding a `cllm --version` guard in the main
  script before running compaction loops
- GPT-5 Codex CLI (2025-11-01): Added `context/verify_cllm.sh` for quick smoke checks

---

## Learning Reinforcement

- Leaning on a maintained CLI frees the team to focus on compaction heuristics, not
  provider plumbing
- Read-only conversations empower reproducible summaries without context drift
- Pinning versions and smoke testing keep AI pipelines from silently degrading

---

## Dynamic Documentation Metadata

```yaml
adr_id: 0003-adopt-cllm
status: accepted
decision: "Standardize on the CLLM CLI to power bash-native context compaction workflows"
summary: "Adopt the upstream CLLM toolchain for conversation-managed, multi-provider prompt compaction."
ai_agents: ["GPT-5 Codex CLI"]
autonomy_level: flexible
linked_commits: []
tags: ["architecture", "ai", "tooling"]
supersedes: null
```
