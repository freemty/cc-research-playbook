# Reference 02: Claude Code Features for AI Research

> Sources: Personal Memory files, ~/.claude/skills/, ~/.claude/workflow/

---

## 1. Hooks System — Automated Guardrails

Hooks = shell scripts that fire on specific events. They **cannot invoke skills**, but can **block actions + inject reminders**.

### Hook Types

| Type | Fires When | Can Do |
|------|-----------|--------|
| PreToolUse | Before tool execution | Block tool call, modify params, validate |
| PostToolUse | After tool execution | Auto-format, check results, advance pipeline |
| Stop | When Claude is about to stop | Block stopping, remind next step |
| PreCompact | Before auto-compaction | Set flags, save state |

### Real Examples (from personal config)

**Pre-commit guardrails:**
- `tmux reminder` — suggests tmux for long-running commands
- `git push review` — opens Zed for review before push
- `doc blocker` — blocks creation of unnecessary .md/.txt files
- `slides-guard.sh` — blocks direct invocation of heavy skills, suggests dispatcher

**Post-execution automation:**
- `Prettier` — auto-formats JS/TS after edit
- `TypeScript check` — runs tsc after .ts/.tsx edits
- `console.log warning` — warns about leftover logs
- `advance-stage.sh` — advances pipeline stage after skill completion
- `PR creation` — logs PR URL and GitHub Actions status

**Session-end verification:**
- `console.log audit` — checks all modified files before session ends
- `stop-guard.sh` — reads pipeline state, reminds next step if incomplete

### AI Research Showcase Scenario

**Experiment Pipeline Automation:**
```
dev → skill-update → experiment → monitoring → analysis → commit → dev (cycle)
```

Hook-driven flow:
1. Stop hook detects 10+ file edits → reminds to run `/writing-skills`
2. PostToolUse advances stage after skill completion
3. Stop hook detects "experiment complete" → reminds `/slides-dispatch`
4. PostToolUse detects slides generated → advances to analysis
5. Stop hook reminds `/commit-changelog`

Manual control via `pipeline-ctl.sh {status|set|skip|reset}`.

---

## 2. Skills System — Reusable Domain Knowledge

Skills 就是按需加载到 context 里的 markdown 文件。把你反复要用的知识写进去，下次开 session 不用重新解释。

### Research-Critical Skills

| Skill | Purpose | Research Value |
|-------|---------|---------------|
| `fars-system` | FARS (Full Autonomous Research System) architecture guide | Understanding multi-agent research pipeline |
| `fars-ideagen` | Idea generation module implementation details | Method-level reference for research agent code |
| `fars-reviewer` | Paper review agent logic | Integrity audit pipeline, preprocessing |
| `fars-plan` | Experiment plan generation agent | Plan generation flow, context compression |
| `agent-exp-orchestration` | Parallel experiment management | Job conflicts, rate limits, subprocess isolation, cron monitoring, retry, post-run analysis |
| `weekly-progress` | Weekly progress document writing | Structuring experiment sections, file references |
| `rope2sink` | ICML 2026 paper writing | LaTeX editing, attention sink analysis |

### Workflow Skills

| Skill | Purpose | Research Value |
|-------|---------|---------------|
| `slides-dispatch` | Thin dispatcher for slide generation | Context-clean delegation pattern |
| `agent-slides` | Experiment slides structure template | Multi-factor benchmarks, ablation studies |
| `frontend-slides` | 生成带动画的 HTML 演示文稿 | 单文件、无框架依赖 |
| `commit-changelog` | Git commit and changelog | Structured research progress tracking |
| `writing-skills` | Skill creation and editing | Meta-skill for building new workflows |
| `notebooklm` | Query Google NotebookLM | Source-grounded, citation-backed answers |

### Utility Skills

| Skill | Purpose |
|-------|---------|
| `humanizer` / `Humanizer-zh` | Remove AI writing artifacts |
| `nano-banana` | Image generation via Gemini CLI |
| `frontend-design` | Production-grade frontend interfaces |
| `notion-lifeos` | Notion PARA system integration |
| `agent-reach` | Multi-platform content access (Twitter, Reddit, YouTube, etc.) |
| `find-skills` | Discover and install new skills |
| `munger-observer` | Daily wisdom review with mental models |
| `proactive-agent` | Transform agents into proactive partners |

---

## 3. Subagent Delegation — Context Protection Pattern

### The Problem
Heavy skills (e.g., `frontend-slides` = 57KB prompt) pollute main context with:
1. Full skill prompt loaded
2. Generated HTML code (3000+ lines)
3. No room left for actual research work

### The Solution: Thin Dispatcher + Subagent

```
Main Context (clean)              Subagent Context (disposable)
────────────────────              ─────────────────────────────
User request                      Reads skill.md files (~60KB)
  |                               Reads experiment data
Gather requirements (~10 lines)   Generates HTML (~3000 lines)
  |                               Writes file to disk
Spawn Agent tool ──────────────>
  |                          <──  Returns summary (5 lines)
Report file path to user
```

### When to Use Subagent Delegation:
- Skill prompt > 10KB
- Generates large files (HTML, SVG, long markdown)
- Output is not the core focus of current session

### When NOT to Use:
- Need to see output in main context for immediate action (e.g., code-reviewer findings)
- Skill prompt is small, output is short
- Need multi-round interactive editing

### Guard Hook Integration
PreToolUse hook on `Skill` tool blocks direct heavy skill invocation:
```
[slides-guard] Direct use of /agent-slides would fill main context with HTML code.
Use /slides-dispatch instead — it delegates to a subagent automatically.
```

---

## 4. Loop — Recurring Autonomous Monitoring

`/loop` skill: run a prompt or slash command on a recurring interval.

### Research Use Cases:
- **Training job monitoring**: `/loop 5m check GPU utilization and training loss`
- **Experiment status polling**: `/loop 10m check if experiment batch has completed`
- **CI/CD watching**: `/loop 3m check GitHub Actions status for latest push`
- **Resource monitoring**: `/loop 15m check disk space and memory usage on VPS`

---

## 5. Multi-Agent Parallel Execution

### Pattern: Split-Role Sub-agents

For complex problems, spawn multiple agents with different perspectives:
- Factual reviewer
- Senior engineer
- Security expert
- Consistency reviewer
- Redundancy checker

### Research Application:
1. **Paper reproduction**: Agent 1 reads paper, Agent 2 searches for existing implementations, Agent 3 checks dataset availability
2. **Experiment analysis**: Agent 1 does statistical analysis, Agent 2 generates visualizations, Agent 3 writes summary
3. **Code review**: Agent 1 checks correctness, Agent 2 checks performance, Agent 3 checks reproducibility

---

## 6. Workflow Pipeline (Complete System)

### Architecture
```
Trigger Layer (Hooks)          State Layer (state.json)         Execution Layer (Skills)
┌──────────────┐             ┌─────────────────┐             ┌──────────────┐
│ Stop hook    │─read state─→│ current_stage   │─if trigger──→│ block + hint │
│ (command)    │ + transcript│ compact_pending │              │ next skill   │
├──────────────┤             │ last_skill_upd  │             ├──────────────┤
│ PreCompact   │─set flag───→│ last_commit     │             │ (user runs)  │
│ (command)    │             └─────────────────┘             │ /skill-name  │
├──────────────┤                     │                       ├──────────────┤
│ PostToolUse  │─after Skill────────→│ advance stage         │ auto advance │
│ (Skill match)│                     │                       └──────────────┘
└──────────────┘
```

### Pipeline Stages
```
dev → skill-update → experiment → monitoring → analysis → commit → dev (cycle)
```

| Stage | Trigger | Suggested Action |
|-------|---------|------------------|
| dev | 10+ file edits OR PreCompact | /writing-skills |
| skill-update | skill updated (auto-advanced) | /agent-exp-orchestration |
| experiment | experiment started | /loop for monitoring |
| monitoring | experiment complete detected | /slides-dispatch |
| analysis | slides generated | /commit-changelog |
| commit | always reminds | /commit-changelog, then reset to dev |

Hooks + Skills + Subagents 组合起来就是一个自动化的科研工作流。问答式助手做不到这件事。
