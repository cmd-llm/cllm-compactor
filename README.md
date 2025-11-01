# cllm-compactor

Calm, intentional experimentation space for exploring compact AI-driven workflows.  
This repo pairs a lightweight codebase with the Vibe ADR rhythm so collaborators can
decide, build, and document in sync with their AI partners.

---

## 🚦 Start Here

1. Load `llms.txt` to configure your AI agent with the local context files.
2. Review the ADRs in `docs/decisions/` to understand the decisions that anchor this
   project.
3. Draft new decisions with `templates/VIBE_ADR_TEMPLATE.md`, trimming unused sections
   once the story is clear.

The vibe we aim for is calm, deliberate iteration. Each change should feel grounded in
context and easy for the next contributor—human or AI—to pick up.

---

## 📚 Decision Records

- `docs/decisions/0001-adopt-vibe-adr.md` sets the baseline for using the Vibe ADR workflow.
- `docs/decisions/0002-define-llms-txt.md` documents how and why `llms.txt` anchors AI onboarding.

Keep ADR numbering sequential (`0003-…`, `0004-…`, etc.) and capture measurable
confirmation steps so decisions stay alive over time.

---

## 🛠️ Authoring Flow

- Use Conventional Commit prefixes (e.g., `docs:`) when landing ADR updates.
- Run Markdown linting before submitting changes:

  ```bash
  npx markdownlint "**/*.md"
  ```

- Validate outbound links within documentation, especially when updating ADRs:

  ```bash
  npx markdown-link-check README.md docs/decisions/**/*.md
  ```

---

## 🤝 Collaboration Notes

- Quote relevant ADR IDs (e.g., `0002-define-llms-txt`) in issues, PRs, and commit messages.
- Update the `Feedback Log` sections of ADRs with insights from pairing sessions or agent runs.
- Highlight next steps in ADRs to guide reviewers and future contributors.

---

## 📬 Questions

Open an issue or start a discussion describing the decision space you’re exploring.  
Frame prompts and tasks around the existing ADRs so the AI agent can stay aligned with
the established vibe.
