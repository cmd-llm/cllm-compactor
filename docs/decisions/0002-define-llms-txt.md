---
status: "accepted"
date: 2025-10-28
decision-makers: ["Owen Zanzal"]
consulted: []
informed: []
ai-agents: ["GPT-5 Codex CLI"]
autonomy-level: "assistive"
tags: ["documentation", "ai", "workflow"]
---

# Define llms.txt Bootstrap Instructions

## Context and Problem Statement

Future collaborators and AI agents need a single, machine-readable entry point that
explains how to spin up Vibe ADR practices inside any project. Right now, agents rely
on README.md excerpts, which are verbose for automation and hard to keep aligned
across repositories. The llmstxt.org convention offers a standard file (`llms.txt`) for
agent bootstrapping, but we have not adopted it yet.

## Vibe Context

Bootstrapping should feel confident, welcoming, and low-friction. Agents and humans
should sense that the path to using Vibe ADR is paved, not improvised, and that the
instructions honor our calm, intentional tone.

## Decision Drivers

- Provide zero-guesswork guidance for AI agents entering the repo
- Keep onboarding instructions version-controlled alongside ADRs
- Reuse the emerging llms.txt ecosystem to stay interoperable

## Considered Options

- Publish a curated `llms.txt` at the repository root
- Depend solely on README.md and ADR references
- Host instructions in an external knowledge base or wiki

## Decision Outcome

Chosen option: **"Publish a curated `llms.txt` at the repository root"**, because it
gives agents a predictable, standards-aligned bootstrap file that points directly to
the assets they need to work with Vibe ADR.

### Consequences

- Good: Standardizes AI onboarding with a discoverable, crawlable format
- Good: Keeps llms.txt changes tied to ADR history and pull requests
- Bad: Introduces another document that can drift without regular review

### Confirmation

- Add `llms.txt` with the instructions outlined here and commit alongside this ADR
- Validate formatting with the `llmstxt.org` guidance or community validators when
  available
- Reference this ADR in future updates to keep the file anchored to the decision

---

## Pros and Cons of the Options

### Publish `llms.txt` (Chosen)

Following the llmstxt.org structure, define scope, context files, and setup steps in a
root-level artifact so any agent can locate Vibe ADR assets instantly.

- Good: Speaks the standard language emerging around agent onboarding
- Good: Lets other projects reuse the same instructions with minimal edits
- Neutral: Requires new contributors to learn the llmstxt schema
- Bad: Adds upkeep each time onboarding changes

### Depend on README.md and ADRs

Keep existing documentation only and expect agents to parse human-oriented sections.

- Good: No new files to maintain
- Bad: Agents must interpret narrative text and may miss critical steps

### External Knowledge Base

Document instructions in Confluence, Notion, or similar outside the repo.

- Good: Offers richer formatting and analytics
- Bad: Fragments context away from code and complicates offline use

---

## More Information

Revisit this decision if the llms.txt specification evolves significantly or if agents
report confusion despite the new file. Monitor llmstxt.org for version changes and
deprecation notices.

---

# AI-Specific Sections

## AI Guidance Level

Chosen level: **strict**

## AI Tool Preferences

- Primary tool: GPT-5 Codex CLI
- Model/version: GPT-5 (Codex CLI harness)
- Parameters: Default harness settings
- Context files: README.md, docs/decisions/*.md, llms.txt once created

## Test Expectations

- Test 1: Run `npx markdownlint "**/*.md"` to guard ADR formatting each update
- Test 2: Manually verify `llms.txt` against llmstxt.org examples
- Acceptance criteria: Agents can locate Vibe ADR assets by following llms.txt links

---

## Next Steps

### Immediate Actions

- Draft `llms.txt` with sections for overview, required files, and setup checklist
- Link this ADR from the llms.txt footer for traceability

### Implementation Sequence

1. Copy template guidance into a new `llms.txt`
2. Outline instructions for bootstrapping Vibe ADR in new or existing repos
3. Add validation notes or commands for agents to confirm setup
4. Keep README.md references aligned with llms.txt updates

### Ownership

- Primary implementer: Owen Zanzal
- Supporting roles: GPT-5 Codex CLI
- Stakeholders to notify: Future repo collaborators

---

## Dependencies

- 0001-adr-description: Adopt Vibe ADR for Decision Records
- Component: Documentation workflow
- External dependency: llmstxt.org guidance

---

## Risk Assessment

### Technical Risks

- llms.txt schema may shift — mitigate by tracking spec updates quarterly
- Incomplete instructions could mislead agents — mitigate with real-world dry runs

### Business Risks

- Additional maintenance overhead — mitigate by pairing updates with ADR reviews

---

## Human Review

- Review required: yes
- Reviewers: Owen Zanzal
- Review stage: before
- Review criteria: llms.txt clarity, spec compliance, cross-links to ADRs

---

## Feedback Log

### Implementation Notes

- 2025-10-28: Decision recorded; llms.txt drafting pending execution

### AI Agent Feedback

- GPT-5 Codex CLI (2025-10-28): Recommend adding explicit links to README.md and
  ADR directory in the llms.txt body

---

## Learning Reinforcement

- Standards-aligned agent guidance scales better than bespoke prompts
- Tightly coupling ADRs with onboarding artifacts reduces drift
- Regular validation keeps automation-friendly docs trustworthy

---

## Dynamic Documentation Metadata

```yaml
adr_id: 0002-adr-description
status: accepted
decision: "Publish a standard llms.txt file to onboard AI agents into Vibe ADR workflows"
summary: "Adopt llms.txt so agents can find Vibe ADR resources and setup steps without guesswork."
ai_agents: ["GPT-5 Codex CLI"]
autonomy_level: strict
linked_commits: []
tags: ["documentation", "ai", "workflow"]
supersedes: null
```
