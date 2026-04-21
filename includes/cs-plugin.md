# Architecture Planning — `cs` Plugin

**Requires**: Install via `/plugin` → `./claude-spec-marketplace`

## Commands

| Command | Description |
|---------|-------------|
| `/cs:p <idea>` | Strategic planner with Socratic elicitation, PRD, implementation plan |
| `/cs:i [id\|slug]` | Implementation tracker with PROGRESS.md checkpoint file |
| `/cs:s [id\|--list\|--expired]` | Project status and portfolio listing |
| `/cs:c <path\|id>` | Close project, archive artifacts, generate retrospective |
| `/cs:log <on\|off\|status\|show>` | Toggle prompt capture logging |
| `/cs:migrate` | Migrate projects from `docs/architecture/` to `docs/spec/` |
| `/cs:wt:create` | Create git worktree with Claude agent |
| `/cs:wt:status` | Show worktree status |
| `/cs:wt:cleanup` | Clean up worktrees |

Workflow: `/cs:p` → `/cs:i` → `/cs:s` → `/cs:c`

## PROGRESS.md Checkpoint System

`/cs:i` creates and maintains PROGRESS.md in the project directory:
- Tracks task status (pending/in-progress/done/skipped) with timestamps
- Calculates phase and project progress
- Logs divergences from the original plan
- Syncs to IMPLEMENTATION_PLAN.md checkboxes and README.md frontmatter
- Persists state across Claude sessions

## Prompt Capture Hook

Logs prompts during `/cs:*` sessions for traceability. On `/cs:c`, generates Interaction Analysis for retrospective.

## Worktree Directory Discipline

**NEVER** write files to the source repo when operating inside a worktree.

Before any file operation:
1. Check `cwd` or run `pwd`
2. If in a worktree (e.g. `worktrees/.claude/feature-branch/`), ALL writes go there
3. If accidentally in source root, copy files to worktree before committing

## Plugin Maintenance

Patches stored in `~/.claude/patches/`. After plugin updates:
```bash
cp -r ~/.claude/patches/<plugin>-<version>/* ~/.claude/plugins/cache/claude-code-plugins/<plugin>/<version>/
```

## Completed Projects

**Spec** (`docs/spec/completed/`):
- `2025-12-13-agent-file-best-practices/` — 115+ agents optimized (success)

**Architecture/Legacy** (`docs/architecture/completed/`):
- `2025-12-12-prompt-capture-log/` — partial (hooks need real-world validation)
- `2025-12-12-arch-lifecycle-automation/` — success
- `2025-12-12-git-fr-command/` — success
