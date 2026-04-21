# CLAUDE.md

Global Claude instructions. Preserve protocols; keep wording minimal.

**ALWAYS** ask questions when producing a plan until you have reached 95% or GREATER confidence.

---

## Includes

Load the relevant file(s) at the start of any matching task:

| Topic | Include File |
|-------|-------------|
| Python | `~/.claude/includes/python.md` |
| React/TypeScript | `~/.claude/includes/react.md` |
| Go | `~/.claude/includes/golang.md` |
| Git/Version Control | `~/.claude/includes/git.md` |
| Testing (any language) | `~/.claude/includes/testing.md` |
| Documentation | `~/.claude/includes/documentation.md` |
| MCP Tools/Skills/Agents | `~/.claude/includes/mcp-reference.md` |
| GitHub Actions | `~/.claude/includes/github-actions.md` |
| Version Discovery | `~/.claude/includes/version-discovery.md` |
| Opus 4.5 (General) | `~/.claude/includes/opus-4-5.md` |
| Opus 4.5 (Agentic) | `~/.claude/includes/opus-4-5-agent.md` |
| HMHCO Organization | `~/.claude/includes/hmhco.md` |
| Architecture planning / `/cs` commands / worktrees | `~/.claude/includes/cs-plugin.md` |
| Parallel agents / multi-agent work / code review | `~/.claude/includes/agents.md` |
| External API calls / unexpected empty responses | `~/.claude/includes/api-validation.md` |

---

## Custom Commands

| Command | Description |
|---------|-------------|
| `/git:cm` | Stage + commit (conventional commits) |
| `/git:cp` | Stage, commit, push |
| `/git:pr [branch]` | Create PR via `gh` |
| `/git:fr [remote] [branch]` | Fetch + rebase onto remote branch |
| `/git:sync [remote] [branch]` | Fetch, rebase, push (with confirmation) |
| `/git:ff [remote] [branch]` | Fast-forward only |
| `/git:prune [--force]` | Prune stale local branches |
| `/explore` | Parallel subagent codebase exploration |
| `/deep-research` | Multi-phase research protocol |
| `/cr` | 6-agent parallel code review → `CODE_REVIEW.md` |
| `/cr-fx` | Interactive remediation of review findings |
| `/cs:*` | Architecture planning — see `cs-plugin` include |

---

## META — Maintaining This Document

After a mistake: *"Reflect on this mistake. Abstract and generalize. Write it to CLAUDE.md."*

**When writing new rules:**
1. NEVER / ALWAYS for non-negotiable directives
2. Lead with why — problem before solution (1–3 bullets max)
3. Bullets over paragraphs; action before theory
4. Be concrete — include actual commands or code
5. One clear point per example block

**Anti-bloat:**
- Skip "Warning Signs" for obvious rules
- Skip bad/good examples for trivial mistakes
- Skip "General Principle" when the section title already generalizes
- Max 1–3 bullets for rationale; no paragraph explanations
