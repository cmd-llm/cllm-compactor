---
status: "accepted"
date: 2025-11-02
decision-makers: ["Owen Zanzal"]
consulted: []
informed: []
ai-agents: ["Claude Sonnet 4.5"]
autonomy-level: "assistive"
tags: ["architecture", "cli", "tooling", "feature"]
---

# Build cllm-compactor CLI Utility

## Context and Problem Statement

While `cllm` provides powerful conversation management and multi-provider orchestration,
we need a specialized tool that orchestrates file-to-context workflows specifically for
compaction tasks. Users should be able to point at a directory of files, specify a
compaction prompt, and receive a consolidated output without manually building
conversation contexts or scripting file loops. Today, this requires custom bash scripts
or manual file selection, creating friction for both humans and automation workflows.

## Vibe Context

The compaction experience should feel effortless and intentional. Users ought to sense
that the tool understands their goal—transforming scattered files into focused
summaries—and handles the orchestration transparently. Each invocation should feel like
a single, purposeful command rather than cobbled-together scripts.

## Decision Drivers

- Provide a dedicated CLI for file-to-context compaction workflows
- Abstract away the boilerplate of looping through files and building conversation context
- Enable single-command compaction that combines file ingestion with prompt execution
- Maintain compatibility with `cllm` as the underlying LLM orchestration layer
- Support automation and CI workflows with predictable exit codes and output formats

## Considered Options

- Build `cllm-compactor` as a standalone CLI utility with directory and prompt flags
- Extend `cllm` directly with compaction-specific subcommands or plugins
- Continue using manual bash scripts for each compaction scenario

## Decision Outcome

Chosen option: **"Build `cllm-compactor` as a standalone CLI utility"**, because it
delivers a focused tool that handles file orchestration concerns separately from the
general-purpose conversation management that `cllm` provides, while keeping the
implementation simple and maintainable.

### Consequences

- Good: Single command to specify directory and prompt for compaction workflows
- Good: Abstracts file looping, context building, and prompt execution into one utility
- Good: Provides a clean interface for both interactive use and automation
- Good: Keeps compaction-specific logic separate from upstream `cllm` maintenance
- Neutral: Adds another CLI tool to the project's dependency surface
- Bad: Requires coordination between `cllm-compactor` and `cllm` for conversation management

### Confirmation

- ✅ Implemented initial CLI with `--directory` and `--prompt` flags (cllm-compactor:1)
- ✅ Verified directory traversal correctly includes all target files in conversation context
- ✅ Confirmed final prompt execution produces expected compacted output
- ✅ Tested exit codes for success, missing directory, and LLM failures
- ✅ Documentation complete with installation and usage examples (README.md:1)

---

## Pros and Cons of the Options

### Standalone cllm-compactor CLI (Chosen)

Build a dedicated utility that orchestrates file ingestion and prompt execution for
compaction scenarios.

- Good: Purpose-built interface for compaction workflows
- Good: Clear separation of concerns from general LLM conversation tools
- Good: Easy to extend with compaction-specific features (filters, templates, formats)
- Neutral: Requires installation alongside `cllm`
- Bad: Adds maintenance overhead for another CLI tool

### Extend cllm Directly

Contribute compaction features as subcommands or plugins to the upstream `cllm` project.

- Good: Consolidates all LLM tooling under one CLI
- Good: Could benefit broader `cllm` community if accepted upstream
- Bad: Ties compaction features to upstream release cycles and design decisions
- Bad: May not align with `cllm`'s scope or architectural direction
- Bad: Increases complexity of contributing and maintaining features

### Manual Bash Scripts

Continue writing custom scripts for each compaction scenario.

- Good: Maximum flexibility for one-off requirements
- Good: Zero additional tooling to install
- Bad: High duplication across similar compaction tasks
- Bad: Brittle to changes in file structures or prompt templates
- Bad: Difficult to share patterns or automate consistently

---

## More Information

Monitor `cllm` API stability to ensure `cllm-compactor` remains compatible as a wrapper.
Revisit this decision if the compaction workflow diverges significantly from file-based
context building, or if `cllm` adds native features that obsolete custom orchestration.

---

# AI-Specific Sections

## AI Guidance Level

Chosen level: **flexible**

## AI Tool Preferences

- Primary tool: CLLM CLI (via cllm-compactor wrapper)
- Model/version: Follow project `Cllmfile.yml` defaults
- Parameters: Compaction-optimized presets (configurable via flags or config files)
- Context files: README.md, docs/decisions/*.md, implementation files for cllm-compactor

## Test Expectations

- Test 1: `cllm-compactor --directory docs/decisions --prompt "Summarize key decisions"` produces coherent output
- Test 2: Missing directory returns non-zero exit code with clear error message
- Test 3: File traversal includes all relevant files in conversation context before executing prompt
- Acceptance criteria: Compacted output faithfully represents input files with no dropped content

---

## Next Steps

### Immediate Actions

- Scaffold initial CLI structure with argument parsing for `--directory` and `--prompt`
- Implement directory traversal to collect file contents
- Build conversation context from collected files and append final prompt
- Wire up `cllm` invocation to execute conversation and return output

### Implementation Sequence

1. Create CLI entry point with flag parsing (`--directory`, `--prompt`)
2. Implement recursive file discovery within specified directory
3. Build conversation context by adding each file's content sequentially
4. Append user-specified prompt as final conversation turn
5. Execute conversation via `cllm` and stream or return final output
6. Add error handling for missing directories, file read failures, and LLM errors
7. Document usage examples in README with common compaction scenarios

### Ownership

- Primary implementer: Owen Zanzal
- Supporting roles: Claude Sonnet 4.5
- Stakeholders to notify: Future contributors and automation workflows

---

## Dependencies

- ADR-0003: Adopt CLLM for Context Compaction Workflows
- Component: File orchestration and conversation context building
- External dependency: `cllm` CLI for LLM execution

---

## Risk Assessment

### Technical Risks

- File traversal may include unwanted files (binaries, large assets) — mitigate with
  sensible defaults and optional filtering flags
- Large directories could exceed context windows — mitigate with file count warnings and
  chunking strategies in future iterations
- `cllm` API changes could break integration — mitigate by pinning tested versions and
  monitoring upstream changes

### Business Risks

- Additional CLI tool increases onboarding complexity — mitigate with clear installation
  documentation and usage examples
- Standalone utility may fragment workflow patterns — mitigate by keeping interface
  intuitive and well-documented alongside `cllm` usage

---

## Human Review

- Review required: yes
- Reviewers: Owen Zanzal
- Review stage: before
- Review criteria: CLI interface design, error handling completeness, integration with existing workflows

---

## Feedback Log

### Implementation Notes

- 2025-11-02: ADR drafted and implemented as bash CLI utility
- 2025-11-02: Core implementation completed with all required flags and error handling
- 2025-11-02: Successfully tested with docs/decisions directory - all files processed correctly
- 2025-11-02: Documentation updated with installation instructions and usage examples

### AI Agent Feedback

- Claude Sonnet 4.5 (2025-11-02): Recommend starting with simple directory flag and
  text-based prompt; structured prompt templates can follow in subsequent iterations
- Claude Sonnet 4.5 (2025-11-02): Implemented as bash script rather than Python to keep it
  lightweight and close to shell workflows; tested successfully with various scenarios

---

## Learning Reinforcement

- Purpose-built CLIs reduce friction for repeated workflows
- Separating orchestration logic from core LLM tools maintains clear boundaries
- Early attention to error handling and exit codes pays dividends for automation

---

## Dynamic Documentation Metadata

```yaml
adr_id: 0004-build-cllm-compactor-cli
status: accepted
decision: "Build cllm-compactor as a standalone CLI utility for file-to-context compaction workflows"
summary: "Create a dedicated CLI tool that orchestrates directory file ingestion and prompt execution to produce compacted outputs."
ai_agents: ["Claude Sonnet 4.5"]
autonomy_level: flexible
linked_commits: []
tags: ["architecture", "cli", "tooling", "feature"]
supersedes: null
implementation: "Implemented as bash script at cllm-compactor with full argument parsing, error handling, and documentation"
```
