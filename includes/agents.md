# Parallel Specialist Agents

## When to Use

Launch multiple specialists simultaneously when tasks are independent (no output dependencies). Only serialize when one agent's output informs another's parameters.

## Agent Categories (`~/.claude/agents/`)

| Category | Specialists | Use For |
|----------|-------------|---------|
| `01-core-development` | frontend-developer, backend-developer, fullstack-developer, api-designer, microservices-architect, mobile-developer | Application architecture, API design, UI/UX |
| `02-language-specialists` | python-pro, typescript-pro, golang-pro, rust-engineer, java-architect, react-specialist, nextjs-developer | Language-specific implementation |
| `03-infrastructure` | devops-engineer, sre-engineer, kubernetes-specialist, terraform-engineer, cloud-architect, database-administrator | Infrastructure, deployment, cloud |
| `04-quality-security` | code-reviewer, security-auditor, penetration-tester, test-automator, performance-engineer, debugger | Quality, security, testing, debugging |
| `05-data-ai` | data-scientist, data-engineer, ml-engineer, llm-architect, postgres-pro, prompt-engineer | Data pipelines, ML/AI, DB optimization |
| `06-developer-experience` | documentation-engineer, cli-developer, build-engineer, refactoring-specialist, mcp-developer | DX tooling, docs, build systems |
| `07-specialized-domains` | fintech-engineer, blockchain-developer, game-developer, iot-engineer, payment-integration | Domain-specific expertise |
| `08-business-product` | product-manager, technical-writer, ux-researcher, scrum-master | Product, documentation, process |
| `09-meta-orchestration` | multi-agent-coordinator, workflow-orchestrator, task-distributor | Complex multi-agent workflows |
| `10-research-analysis` | research-analyst, competitive-analyst, market-researcher, trend-analyst | Research, analysis, market intelligence |

## Patterns

```
PARALLEL: Full-stack feature + security
→ frontend-developer + backend-developer + security-auditor simultaneously

PARALLEL: Infrastructure + monitoring
→ terraform-engineer + sre-engineer + devops-engineer

SEQUENTIAL: Research → Implementation
→ research-analyst completes → findings guide python-pro

SEQUENTIAL: Design → Build → Review
→ api-designer → backend-developer → code-reviewer
```

---

## Code Review (`/cr` + `/cr-fx`)

### `/cr` — Comprehensive Review

Deploys 6 specialist agents in parallel: Security, Performance, Architecture, Code Quality, Test Coverage, Documentation.

Output artifacts:
```
CODE_REVIEW.md       # Full report with health scores (X/10 per dimension)
REVIEW_SUMMARY.md    # Executive summary
REMEDIATION_TASKS.md # Actionable checklist by priority
```

Focus flags: `--focus=security` | `--focus=performance` | `--focus=maintainability`

### `/cr-fx` — Remediation

Routes findings to appropriate specialists. Interactive mode has 5 decision points (severity, categories, conflict resolution, verification depth, commit strategy). Use `--quick` for automated defaults (Critical+High, all categories).

Agent mapping:
| Category | Agent | Focus |
|----------|-------|-------|
| Security | `security-engineer` | Vulnerabilities, auth, OWASP |
| Performance | `performance-engineer` | N+1, caching, algorithms |
| Architecture | `refactoring-specialist` | SOLID, patterns, complexity |
| Code Quality | `code-reviewer` | Naming, DRY, dead code |
| Tests | `test-automator` | Coverage, edge cases |
| Documentation | `documentation-engineer` | Docstrings, README |

---

## Opus 4.5 Quick Reference

Key behaviors when running as Opus 4.5:
- Avoid "think" when extended thinking disabled — use "consider", "evaluate", "believe"
- More tool-responsive than prior models — use normal phrasing, avoid "CRITICAL: MUST"
- Proactively delegates to subagents (native capability)
- Prefers fresh context from filesystem over compaction
- Use git logs + structured files (tests.json, progress.txt) for multi-session state
- ALWAYS read files before answering — no speculation about unread code
