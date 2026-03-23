# CC Research Playbook — References

> 本 talk 所有引用链接 + TLDR，按主题分类。

---

## 1. Harness / Context Engineering (核心理论)

| Source | Link | TLDR |
|--------|------|------|
| Anthropic | [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) | 长时运行 agent 的 runtime 框架：任务分解、状态持久化、错误恢复、context 压缩、定期自检、明确终止条件 |
| Anthropic | [Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | Agent 的 context 工程方法论：如何让模型在每一步看到最有用的信息 |
| Anthropic | [Demystifying Evals for AI Agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) | Agent 评估方法论：如何衡量 agent 系统的真实能力 |
| OpenAI | [Harness Engineering](https://openai.com/index/harness-engineering/) | Codex 的工程系统设计：repo 知识、agent 可读性、架构边界、低阻塞合并、AI slop 清理 |
| Manus | [Context Engineering](https://manus.im/blog/context-engineering) | Agent 工作记忆管理：信息密度、相关性、时效性；组织/过滤/重写 context 让模型每步看到最有用的信息 |
| Ivan Zhao | [Steam, Steel, and Infinite Minds](https://www.notion.com/zh-cn/blog/steam-steel-and-infinite-minds-ai) | Notion CEO 的 AI 愿景："人应该从循环中跳出来，在更高层面监督循环" |

**一句话区分三篇 Harness 文章：** OpenAI = 系统生产工程；Anthropic = 长时运行 runtime 框架；Manus = 工作记忆 / context 管理。

---

## 2. Key People & Posts (社区关键人物)

### @bcherny — Boris Cherny (Claude Code creator), 10 Tips

- Link: [@bcherny on X](https://x.com/bcherny)
- TLDR: 10 条实战建议 — git worktree 并行多任务、先 Plan 再写码、持续迭代 CLAUDE.md、高频操作封装 Skill、Slack MCP 接 bug、用 subagent 保持 context 干净、用 Claude 做数据分析和学习工具

### @trq212 — Thariq Shihipar (Anthropic), Skills 九大分类

- Link: [原文](https://x.com/trq212/status/2033949937936085378) / [宝玉翻译](https://x.com/dotey/status/2034002188994060691)
- TLDR: Anthropic 内部几百个 Skills 提炼出 9 类 — 库/API 参考、产品验证、数据分析、业务自动化、代码脚手架、代码质量、CI/CD、运维手册、基础设施运维。写 Skill 关键：写"何时触发"而非"做什么"、建踩坑点章节、利用文件系统渐进披露

### @HiTw93 — Tw93, Claude Code 六层架构

- Link: [X Thread](https://x.com/HiTw93/status/2032091246588518683)
- TLDR: Claude Code 是六层 agentic 系统（系统指令→上下文加载→工具定义→技能工作流→执行控制→验证）。MCP 是"隐藏杀手"，5 个 MCP server 开局吃掉 25K tokens；CLAUDE.md 预算约 2.5K tokens

### @systematicls — 9 Coding Agent Principles

- Link: [@systematicls on X](https://x.com/systematicls)
- TLDR: 9 条原则 — 少即是多（别装太多插件）、context 是一切、利用谄媚意识、避免"脑补"、定义任务终点（测试驱动）、CLAUDE.md 写逻辑目录不写百科、Rules vs Skills 分清、定期清理、别追新工具

### @JamesAI — /insights 数据驱动 Skill 生成

- Link: [X Post](https://x.com/JamesAI/status/2028269700376097108)
- TLDR: 用 /insights 从日志数据自动生成 Skills 的工作流

### 胡渊鸣 — 如何有效地给 10 个 Claude Code 打工

- Link: [知乎](https://zhuanlan.zhihu.com/p/2007147036185744607)
- TLDR: 10 阶段演进路线 — Cursor→CC→容器隔离→Ralph Loop 任务队列→Worktree 并行→CLAUDE.md+PROGRESS.md→Web Manager→CC 管 CC (成功率 20%→95%)→语音输入→Plan Mode 封装→"不看代码，只写 CLAUDE.md"

---

## 3. Case Studies (实战案例)

### AReaL — 32 天零手打代码构建分布式 RL 框架

- Link: [知乎](https://zhuanlan.zhihu.com/p/2003269671630165191) / [GitHub](https://github.com/inclusionAI/AReaL)
- TLDR: 178 session、72 万行净增、零手打代码。分层配置：CLAUDE.md 精简入口 + rules/ + agents/ + skills/。Read 25,000 次 >> Edit 14,000 次 — agent 核心价值在理解和导航。`/pr-review` 动态专家团队按风险分级。Skill 升级为只读 Agent（权限隔离）

---

## 4. GitHub Repos (工具与框架)

| Repo | Link | TLDR |
|------|------|------|
| anthropics/claude-code | [GitHub](https://github.com/anthropics/claude-code) | Claude Code 官方 repo |
| freemty/labmate | [GitHub](https://github.com/freemty/labmate) | 研究项目 Claude Code plugin（本 talk 核心 demo） |
| obra/superpowers | [GitHub](https://github.com/obra/superpowers) | 完整软件工程工作流 plugin — 14 Skills（brainstorm→plan→TDD→review→finish），支持 CC/Cursor/Codex/Gemini CLI |
| inclusionAI/AReaL | [GitHub](https://github.com/inclusionAI/AReaL) | 华为分布式 RL 框架，CC 全程开发的标杆案例 |
| huggingface/skills | [GitHub](https://github.com/huggingface/skills) | HuggingFace Daily Paper Skill |
| affaan-m/everything-claude-code | [GitHub](https://github.com/affaan-m/everything-claude-code) | Claude Code 资源汇总 |

---

## 5. Skill 生态 (Skills Ecosystem)

| Resource | Link | TLDR |
|----------|------|------|
| Anthropic Skill Creator Guide | [GitHub](https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md) | 官方 Skill 编写指南 |
| Skills.sh | [skills.sh](https://skills.sh/) | MCP Skill 市场 |
| NanoBanana PPT Skills | [GitHub](https://github.com/op7418/NanoBanana-PPT-Skills) | PPT 生成 Skill |
| cc-nano-banana | [GitHub](https://github.com/kkoppenhaver/cc-nano-banana) | Claude Code 版图片生成 |
| NotebookLM Skill | [GitHub](https://github.com/PleasePrompto/notebooklm-skill) | Google NotebookLM 集成 |
| Frontend Slides | [GitHub](https://github.com/zarazhangrui/frontend-slides) | HTML 演示文稿生成 |
| Manim Skill | [GitHub](https://github.com/adithya-s-k/manim_skill) | 数学动画生成 |

---

## 6. Official Docs (官方文档)

### Core
| Page | Link |
|------|------|
| Overview | [code.claude.com/docs/en/overview](https://code.claude.com/docs/en/overview) |
| Best Practices | [code.claude.com/docs/en/best-practices](https://code.claude.com/docs/en/best-practices) |
| How Claude Code Works | [code.claude.com/docs/en/how-claude-code-works](https://code.claude.com/docs/en/how-claude-code-works) |

### Features (本 talk 重点)
| Feature | Link |
|---------|------|
| Skills | [code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills) |
| Hooks | [code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks) |
| Hooks Guide | [code.claude.com/docs/en/hooks-guide](https://code.claude.com/docs/en/hooks-guide) |
| Sub-agents | [code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents) |
| Memory | [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory) |
| MCP | [code.claude.com/docs/en/mcp](https://code.claude.com/docs/en/mcp) |
| Agent Teams | [code.claude.com/docs/en/agent-teams](https://code.claude.com/docs/en/agent-teams) |
| Plugins | [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins) |

### Other
| Page | Link |
|------|------|
| Permissions | [code.claude.com/docs/en/permissions](https://code.claude.com/docs/en/permissions) |
| Sandboxing | [code.claude.com/docs/en/sandboxing](https://code.claude.com/docs/en/sandboxing) |
| Settings | [code.claude.com/docs/en/settings](https://code.claude.com/docs/en/settings) |
| GitHub Actions | [code.claude.com/docs/en/github-actions](https://code.claude.com/docs/en/github-actions) |
| CLI Reference | [code.claude.com/docs/en/cli-reference](https://code.claude.com/docs/en/cli-reference) |
| Agent SDK | [platform.claude.com/docs/en/agent-sdk/overview](https://platform.claude.com/docs/en/agent-sdk/overview) |
| Costs | [code.claude.com/docs/en/costs](https://code.claude.com/docs/en/costs) |

---

## 7. Browser Automation Landscape (AI 浏览器自动化)

**三条路线：** Vision-based（截图像素理解）、Structure-based（DOM/Accessibility Tree）、Hybrid（AI + Code 混合）。趋势收敛到 Structure-first, Vision-fallback。

### Agent Layer — 端到端自主浏览器 Agent

| Project | Link | TLDR |
|---------|------|------|
| browser-use | [GitHub](https://github.com/browser-use/browser-use) | Python Agent 框架，Vision + DOM 双模式，支持多 LLM，自带 Agent loop + Cloud 托管，MIT |
| Skyvern | [GitHub](https://github.com/Skyvern-AI/skyvern) | 纯 Vision 驱动，swarm of agents 架构，不依赖 DOM，对任何 UI 都能工作，适合表单填写/电商自动化 |
| LaVague | [GitHub](https://github.com/lavague-ai/LaVague) | World Model + Action Engine 双层架构，解耦推理与执行，支持 Selenium/Playwright/Extension，学术味最浓 |

### SDK / Hybrid Layer — AI + 代码混合控制

| Project | Link | TLDR |
|---------|------|------|
| Stagehand | [GitHub](https://github.com/browserbase/stagehand) | Browserbase 出品，TypeScript SDK，三个核心方法 act()/agent()/extract()，auto-caching + self-healing，"write once, run forever" |
| Anthropic Computer Use | [GitHub](https://github.com/anthropics/anthropic-quickstarts/tree/main/computer-use-demo) | Anthropic 官方，纯截图 + 坐标点击，不限于浏览器可操控整个桌面，Docker 隔离运行 |

### Tool / Interface Layer — 给 LLM 提供浏览器工具

| Project | Link | TLDR |
|---------|------|------|
| playwright-mcp | [GitHub](https://github.com/microsoft/playwright-mcp) | Microsoft 出品，MCP Server，基于 Accessibility Tree 而非截图，不需要 Vision Model，适合探索性自动化和长时间 session |
| playwright-cli | [GitHub](https://github.com/microsoft/playwright-cli) | Microsoft 出品，Shell CLI，token 开销最小，专为 coding agent 设计，适合在写代码的同时偶尔操控浏览器 |

---

## 8. Multi-Agent Collaboration (多 Agent 协作工具)

| Project | Link | TLDR |
|---------|------|------|
| cmux | [cmux.com](https://cmux.com/zh-CN) | AI 版 tmux，原生 macOS + Ghostty 渲染，侧边栏 + 分屏 + 内置浏览器 + 通知环，专为多 Agent 并行设计，免费开源 |
| cmux-skill | [GitHub](https://github.com/jiahao-shao1/cmux-skill) | 让 Claude Code 操控 cmux：分屏管理、跨 pane 通讯、浏览器/侧边栏控制 |
| claude-peers-mcp | [GitHub](https://github.com/louislva/claude-peers-mcp) | 多 Claude Code 实例间即时通讯，Broker Daemon (localhost:7899 + SQLite)，支持 list_peers/send_message/set_summary，自动清理死 peer |

---

## 9. Misc Tools & Tips

| Item | Link / Detail |
|------|---------------|
| Jina AI Reader | `https://r.jina.ai/<URL>` — 提取任意网页内容为纯文本 |
| OpenClaw (Model Failover) | [docs.openclaw.ai](https://docs.openclaw.ai/concepts/model-failover) |
| ClawHub (Agent Reach) | [clawhub.com](https://clawhub.com) |
| Codex App (对比) | [openai.com](https://openai.com/zh-Hans-CN/index/introducing-the-codex-app/) |
| Haiku MCP 限制 | Haiku 不支持 MCP tool search，需切换到 `claude --model sonnet` |
