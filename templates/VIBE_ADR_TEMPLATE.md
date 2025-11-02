---
# Optional metadata elements — keep or remove as needed.
status: "{proposed | accepted | deprecated | superseded by ADR-XXXX}"
date: { YYYY-MM-DD when the decision was last updated }
decision-makers: { list everyone involved in the decision }
consulted: { subject-matter experts consulted }
informed: { people kept up-to-date on progress }
ai-agents: { list of AI agents/models involved (e.g., Claude Code v2.5, GPT-5) }
autonomy-level: "{assistive | supervised | execute}"
tags: [architecture, workflow, ai, implementation]
---

# {Short Title — clearly describe the solved problem and chosen solution}

## Context and Problem Statement

{Describe the background, goals, and problem this decision addresses.  
State the "why" before the "what".  
Include links to related issues, boards, or documents.}

## Vibe Context

{Describe the intuitive or emotional principle guiding this decision.  
What should this _feel_ like when done right?  
Example: “The system should feel lightweight, transparent, and fast to reason about.”}

## Decision Drivers

- {driver 1 — e.g., performance, maintainability, simplicity}
- {driver 2 — e.g., team skill set, compliance}
- {driver 3 — e.g., developer experience}
- …

## Considered Options

- {Option A — short title}
- {Option B — short title}
- {Option C — short title}

## Decision Outcome

Chosen option: **"{Option Name}"**, because {justification — e.g., best fits key drivers, simplest path, aligns with vibe principle, etc.}

### Consequences

- Good: {positive outcome or benefit}
- Bad: {trade-off or limitation}
- Neutral: {optional observations}

### Confirmation

{How will this ADR’s intent be validated?  
List manual or automated checks, test suites, or review processes.  
Include pointers to architecture-fitness tests, CI jobs, or validation scripts.}

---

## Pros and Cons of the Options

### {Option A}

{Short description, reference links, or prototype results.}

- Good: {pro}
- Good: {pro}
- Neutral: {note}
- Bad: {con}

### {Option B}

{Short description, reference links, or prototype results.}

- Good: {pro}
- Bad: {con}

### {Option C}

{Short description, reference links, or prototype results.}

- Good: {pro}
- Bad: {con}

---

## More Information

{Any additional context, evidence, confidence level, or decision timeline.  
Include when this decision should be revisited or what triggers a review.}

---

# AI-Specific Sections

The following extend standard MADR for **AI-enabled development**.

## AI Guidance Level

{Defines how much freedom the AI has when implementing this ADR.}

- **strict** – Follow exact specifications.
- **flexible** – Interpret intent with creativity within boundaries.
- **exploratory** – Research or prototype multiple alternatives.

Chosen level: **{strict | flexible | exploratory}**

## AI Tool Preferences

- Primary tool: {Claude Code, Copilot, etc.}
- Model/version: {e.g., Claude Sonnet 4.5}
- Parameters: {e.g., temperature=0.3, max-tokens=4096}
- Context files: {README.md, prior ADRs, or specs fed to model}

## Branching Experiments (optional)

If exploring multiple approaches, document each experimental branch:
| Branch | Description | Outcome | Preferred |
|---------|--------------|----------|-----------|
| `adr-001-a` | {Option A prototype} | {results/metrics} | ✅ |
| `adr-001-b` | {Option B prototype} | {results/metrics} | ❌ |

---

## Test Expectations

{Define pre-implementation tests or acceptance criteria.}

- Test 1: {expected behavior}
- Test 2: {performance metric or threshold}
- Acceptance criteria: {definition of done}

---

## Next Steps

### Immediate Actions

- {Action 1}
- {Action 2}

### Implementation Sequence

1. {Step 1}
2. {Step 2}
3. …

### Ownership

- Primary implementer: {name}
- Supporting roles: {names}
- Stakeholders to notify: {names or groups}

---

## Dependencies

- ADR-NNNN: {related decision}
- Component: {system module affected}
- External dependency: {API, library, or service}

---

## Risk Assessment

### Technical Risks

- {risk and mitigation}
- …

### Business Risks

- {risk and mitigation}
- …

---

## Human Review

- Review required: {yes | no}
- Reviewers: {names}
- Review stage: {before | after | both}
- Review criteria: {specific items to verify}

---

## Feedback Log

### Implementation Notes

- {date}: {observation, issue, or milestone}
- …

### AI Agent Feedback

- {agent name + date}: {comment on clarity, success, or issues}
- …

---

## Learning Reinforcement

{Key insights for future ADRs.}

- {what worked well}
- {what could improve}
- {patterns to repeat or avoid}

---

## Dynamic Documentation Metadata

_(Used for automation and summarization)_

```yaml
adr_id: adr-XXXX
status: accepted
decision: "..."
summary: "..."
ai_agents: ["Claude Code", "GPT-5"]
autonomy_level: flexible
linked_commits: ["abc1234"]
tags: ["ai", "architecture"]
supersedes: null
```
