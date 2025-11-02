# cllm-compactor

A bash CLI utility that orchestrates file-to-context compaction workflows using `cllm`.
Point it at a directory of files and a prompt, and it will build conversation context
from your files and execute your compaction prompt in one command.

---

## Installation

### Prerequisites

Install the `cllm` CLI (**v0.1.6 or newer**) from [o3-cloud/cllm](https://github.com/o3-cloud/cllm):

```bash
uv tool install https://github.com/o3-cloud/cllm.git
cllm --version  # Verify installation
```

### Install cllm-compactor

Add the `cllm-compactor` script to your PATH:

```bash
# Option 1: Copy to a directory in your PATH
cp cllm-compactor /usr/local/bin/
chmod +x /usr/local/bin/cllm-compactor

# Option 2: Add this repo to your PATH
export PATH="/path/to/cllm-compactor:$PATH"
```

---

## Quick Start

```bash
# Summarize all markdown files in a directory
cllm-compactor --directory docs/decisions --prompt "Summarize all decisions"

# With verbose output to see what's happening
cllm-compactor -d docs/ -p "Create overview" -v

# Save output to a file
cllm-compactor -d src/ -p "List all TODO comments" -o summary.txt
```

---

## Usage

```bash
cllm-compactor --directory <dir> --prompt <prompt> [options]
```

### Required Arguments

- `-d, --directory DIR` - Directory containing files to compact
- `-p, --prompt PROMPT` - Final prompt to execute after loading context

### Optional Arguments

- `-r, --recursive` - Recursively process subdirectories (default: false)
- `--pattern PATTERN` - Glob pattern for file filtering (default: `*.md`)
- `-o, --output FILE` - Write output to file instead of stdout
- `--cllm-path PATH` - Custom cllm configuration directory
- `--conversation-id ID` - Reuse existing conversation for iterative refinement
- `--no-cleanup` - Don't clean up conversation after completion
- `-v, --verbose` - Show verbose output including file processing details
- `--version` - Show version information
- `-h, --help` - Show help message

### Examples

**Summarize architectural decisions:**

```bash
cllm-compactor -d docs/decisions -p "Summarize all architectural decisions"
```

**Recursive search with custom pattern:**

```bash
cllm-compactor -d src/ -r --pattern "*.py" -p "List all TODO comments"
```

**Iterative refinement using the same conversation:**

```bash
# First pass
cllm-compactor -d docs/ -p "Create initial summary" \
  --conversation-id abc-123 --no-cleanup

# Add more details to the same conversation
cllm-compactor -d docs/ -p "Now add risk analysis" \
  --conversation-id abc-123
```

**Pipe output to another tool:**

```bash
cllm-compactor -d . -p "List key files" | grep "important"
```

---

## How It Works

1. **File Discovery** - Scans the specified directory for files matching the pattern
2. **Context Building** - Feeds each file's content into a `cllm` conversation
3. **Prompt Execution** - Executes your final prompt with all file context loaded
4. **Output** - Returns the compacted result to stdout or a file

The tool wraps `cllm` to handle the orchestration of file looping and context
building, so you can focus on crafting effective compaction prompts.

---

## Exit Codes

- `0` - Success
- `1` - Invalid arguments or usage
- `2` - Missing dependencies (cllm not found)
- `3` - File or directory errors
- `4` - LLM execution failure

---

## Configuration

You can customize `cllm` behavior by providing a custom configuration directory:

```bash
cllm-compactor -d docs/ -p "Summarize" --cllm-path ./my-config/
```

Your config directory should contain a `Cllmfile.yml` with settings like model,
temperature, and system messages. See `context/compaction/Cllmfile.yml` for an
example compaction configuration.

---

## Architecture

This project follows the [Vibe ADR](https://github.com/joelparkerhenderson/architecture-decision-record/tree/main/locales/en/examples/vibe-adr) methodology for capturing architectural decisions. All major design choices are documented in `docs/decisions/`.

### Project Components

```text
cllm-compactor/
├── cllm-compactor          # Main CLI utility (bash)
├── context/
│   ├── compaction.sh       # Original prototype script
│   ├── verify_cllm.sh      # CLLM installation smoke test
│   └── compaction/         # Example CLLM configuration
│       └── Cllmfile.yml    # Model and prompt settings
├── docs/
│   └── decisions/          # Architecture Decision Records
└── llms.txt                # AI agent onboarding instructions
```

### Key Design Decisions

All architectural decisions are documented as ADRs in `docs/decisions/`:

1. **[ADR-0001: Adopt Vibe ADR for Decision Records](docs/decisions/0001-adopt-vibe-adr.md)**
   - Status: ✅ Accepted
   - Standardizes decision documentation with vibe-oriented language
   - Ensures consistent structure for both humans and AI agents

2. **[ADR-0002: Define llms.txt Bootstrap Instructions](docs/decisions/0002-define-llms-txt.md)**
   - Status: ✅ Accepted
   - Publishes `llms.txt` for zero-friction AI agent onboarding
   - Follows community standards at [llmstxt.org](https://llmstxt.org)

3. **[ADR-0003: Adopt CLLM for Context Compaction Workflows](docs/decisions/0003-adopt-cllm.md)**
   - Status: ✅ Accepted
   - Uses [CLLM](https://github.com/o3-cloud/cllm) for bash-native LLM orchestration
   - Enables conversation management and multi-provider support

4. **[ADR-0004: Build cllm-compactor CLI Utility](docs/decisions/0004-build-cllm-compactor-cli.md)**
   - Status: ✅ Accepted
   - Implements standalone CLI for file-to-context compaction
   - Abstracts directory traversal and prompt execution patterns

---

## Experiments and Examples

Prototype scripts that inspired this tool:

- `context/compaction.sh` - Original bash prototype showing the core workflow
- `context/compaction/Cllmfile.yml` - Example configuration for summarization tasks
- `context/compaction/output/compacted_summary.txt` - Sample output showing target quality

---

## Documentation

- **[Architecture Decision Records](docs/decisions/)** - All major design decisions
- **[llms.txt](llms.txt)** - AI agent onboarding instructions
- **Templates** - Vibe ADR templates for new decisions

---

## Contributing

We welcome contributions! Areas of interest:

- Additional file filtering options (size limits, binary detection)
- Support for piping file lists via stdin
- Template prompt library for common compaction tasks
- Enhanced conversation management and cleanup
- Integration examples for git hooks and CI workflows

Before making significant changes, please:

1. Review existing [Architecture Decision Records](docs/decisions/)
2. Create a new ADR for major architectural changes
3. Follow the [Vibe ADR template](templates/VIBE_ADR_TEMPLATE.md)

Share your ideas, pain points, and `cllm` command patterns that work well for you.
