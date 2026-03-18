# AI Research Claude Code Best Practice — Talk Outline

## 核心观点

> 这不是在比哪个 IDE 接了更好的模型。
> 重点是工作方式变了——从"问答助手"变成"自主跑任务的 Agent"。

给谁看：还停留在 Cursor 式 IDE 思维的 AI 研究者，觉得"模型一样，套什么壳都一样"。

---

## Part 1: Core Design & Paradigm

### 1a. Claude Code High-Level Architecture
- Source: `learn-claude-code` repo
- System design walkthrough
- How Claude Code differs architecturally from IDE-embedded assistants
- The agentic loop: tool use, context management, autonomous decision-making

### 1b. What the ReAct Paradigm Really Means
- Assistant paradigm: single-turn Q&A, user drives every step
- ReAct paradigm: Reasoning + Acting in a loop
  - Observe → Think → Act → Observe → ...
  - Agent autonomously decides next tool call
  - Agent can self-correct, backtrack, and chain complex operations
- Why this distinction matters for research workflows
  - Multi-step experiments
  - Autonomous exploration of codebases
  - Self-directed debugging and iteration

---

## Part 2: Scenarios & Feature Practice

### 2a. AI Research Critical Scenarios
- Sources: personal Memory files, installed Skills
- Potential scenarios:
  - Paper implementation & reproduction
  - Experiment orchestration & monitoring
  - Data pipeline debugging
  - Literature review & knowledge base construction
  - Multi-agent parallel evaluation

### 2b. Special Cases — Showcasing Unique Features
- **Hook**: automated guardrails and workflow triggers
  - e.g., pre-commit security checks, auto-formatting, build verification
  - Custom hooks for research-specific validation
- **Skills**: domain-specific reusable capabilities
  - e.g., experiment orchestration, slide generation, paper writing
  - How Skills encode institutional knowledge
- **Sub-agent**: parallel task decomposition
  - e.g., multi-perspective code review, parallel experiment analysis
  - Orchestrator + worker pattern for complex research tasks
- **Loop**: recurring autonomous monitoring
  - e.g., polling experiment status, watching training jobs

---

## Part 3: Documentation & Management Techniques

### 3a. Harness Engineering & Context Management
- CLAUDE.md as project-level instruction layer
- Context window awareness and management strategies
- Memory system: persistent knowledge across sessions
- Prompt engineering at the harness level (not just the model level)

### 3b. Curated Resources
- Source: Notion LifeOS — Claude Code Best Practice collection
- Links and references to be pulled from Notion
- Boris Cherny's Twitter tips on practical usage patterns

### 3c. Supplementary Materials
- Community best practices
- Real-world research workflow examples
- Before/after comparisons: IDE-assistant vs. agent-harness approach

---

## 做这个分享的原则

用真实场景说话。每个 demo 都要让人看到：Loop、Hook、Sub-agent、Skills 能干什么，
而这些事在问答式助手里根本做不了。

---

## Reference Documents

| File | Contents | Status |
|------|----------|--------|
| `ref-01-architecture.md` | Claude Code architecture, ReAct paradigm, tool system, context mgmt, official best practices | Done |
| `ref-02-features-for-research.md` | Hooks, Skills, Subagent, Loop, Pipeline — all with real examples from personal config | Done |
| `ref-03-docs-and-resources.md` | Harness engineering concepts, context techniques, Notion links, demo scenario ideas | Partial (awaiting Notion links) |
| `ref-04-notion-links.md` | All extracted URLs, Boris Cherny 10 tips, Harness Engineering articles, 9 coding agent principles, community links | Done |
| `ref-05-skills-inventory.md` | Full 23-skill inventory with descriptions, categories, and research relevance ranking | Done |
