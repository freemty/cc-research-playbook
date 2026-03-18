# Slide Outline: cc-research-playbook

Style: Terminal Green (developer-focused, monospace, dark terminal aesthetic)
Target: 38 slides

---

## Opening (Slides 1-3)

### Slide 1: Title
- "CC Research Playbook"
- Subtitle: "从 Assistant 到 Agent — AI 研究者的范式跃迁"
- Author: sum_young / Date: 2026-03-16

### Slide 2: The Question
- "如果模型一样，为什么 Harness 会有区别？"
- 左: Cursor / IDE 内嵌助手 — 问答式交互、用户主动驱动、结果一次性生成
- 右: Claude Code / Terminal Agent — 自主循环执行、工具调用 + 自我验证、持续迭代
- 底部: 两者底层使用相同模型，结果却截然不同

### Slide 3: The Answer — 范式跃迁
- 左框: Assistant 范式 — 单轮问答，用户驱动
- 右框: ReAct Agent 范式 — 自主循环，自我驱动
- 金句: "你不是换了工具，你换了工作方式"

---

## Part 1: 核心设计与范式 (Slides 4-12)

### Slide 4: Part 1 Section Title
- "核心设计与范式"
- "理解 Agent 的本质区别"

### Slide 5: 传统助手 vs Claude Code (Agent) — 对比表
- 5 行表格: 工作模式 / 能力范围 / 上下文 / 使用方式 / 反馈循环
- 左列: 传统聊天助手 (回答问题然后等待、仅文本回复、只看当前单文件、你写代码 AI 审查、依赖用户判断)
- 右列: Claude Code Agent (自主工作持续执行、执行操作编辑搜索运行部署、跨项目跨文件全局理解、你描述目标 AI 规划并实现、自我验证运行测试对比输出)
- 底部: "Delegate, don't dictate"

### Slide 6: Agentic Loop (ReAct 范式)
- 左: 流程图 — 1. 收集上下文 → 2. 采取行动 → 3. 验证结果 → loop back
- 右: 三个要点卡片
  - KEY INSIGHT: 非线性 — 迭代式自我纠正
  - 每一轮工具调用的结果都会反馈回循环，指导下一步决策
  - 用户始终在循环中，可随时中断并重定向

### Slide 7: 为什么 ReAct 对 AI Research 至关重要
- 多步实验自动化: data → run → analyze → iterate
- 自主探索代码库: 理解陌生的论文实现，自动追踪调用链与依赖
- 自导向调试: 发现 bug → 假设 → 验证 → 修复 → 确认，闭环
- 核心原则: "Delegate, don't dictate" — 给出目标与上下文，让 Claude 决定执行步骤

### Slide 8: 系统架构
- Two Pillars: Models (推理与理解) + Tools (动作执行, 28+ built-in + MCP + Skills + Hooks)
- Three Environments: 本地 (Local) / 云端 (Cloud) / 远程控制 (Remote Control)
- 底部: Claude Code = Agentic Harness built around Claude LLM

### Slide 9: 工具系统 — 28+ 内置工具
- 5 列网格:
  - 文件操作: Read, Edit, Write, NotebookEdit
  - 搜索: Glob, Grep
  - 执行: Bash (shell, tests, git, scripts)
  - Web: WebFetch, WebSearch
  - 代码智能: LSP (type errors, goto def, find refs)
- 底部 Orchestration Tools: Agent, Skill, TaskCreate, TaskList, TaskUpdate, CronCreate, AskUserQuestion, EnterPlanMode

### Slide 10: 四大扩展机制
- 2x2 网格:
  - Skills [on-demand] — 按需加载的领域知识 (Markdown 文件 → 复用的工作流与机构知识)
  - MCP [protocol] — 连接外部服务 (Notion, Jira, Slack, DB...)
  - Hooks [automation] — 工具执行前后自动脚本 (PreToolUse, PostToolUse, Stop, PreCompact)
  - Subagents [parallel] — 独立上下文专门化 Agent (独立 context window + system prompt + tools)

### Slide 11: Context Window — 最关键的资源
- 金句: "你最重要的资源是上下文，不是算力"
- 左: Context 包含 — 对话历史、文件内容、命令输出、CLAUDE.md 指令、加载的 Skills、系统提示
- 右上: Why It Matters — 上下文耗尽 = 任务失去记忆；主动管理上下文 = 持续工作能力
- 右下 (红色警告): MCP TOKEN TRAP — 200K 预算中 ~15-20K 是固定开销；5 个 MCP server 开对话前就吃掉 25K tokens

### Slide 12: 上下文管理三层策略
- Level 1 基础 (绿): /clear 任务切换时完全重置 + /compact 手动压缩可指定保留焦点
- Level 2 中级 (黄): CLAUDE.md ~2.5K tokens 精简指令 + Auto Memory 跨 session 持久化 + /btw 侧边快问不写入历史
- Level 3 高级 (蓝): Subagent delegation 重型任务外包 + Skills lazy-load 按需加载 + Pipeline state JSON 状态持久化 + Multi-session 跨会话拆分
- 底部: 核心原则 — 主动管理上下文 = 持续的高质量输出

---

## Part 2: 场景与功能实践 (Slides 13-27)

### Slide 13: Part 2 Section Title
- "场景与功能实践"
- "IDE 助手做不到的事"

### Slide 14: 四大核心 Feature
- 2x2 网格:
  - Hook — 自动化护栏与触发器 (事件驱动的确定性执行)
  - Skills — 可复用领域知识 (机器可读的实验室手册)
  - Sub-agent — 并行任务分解 (独立 context 的专家代理)
  - Loop — 循环自主监控 (定时轮询 + 自主响应)

### Slide 15: Hook — 事件驱动的自动化
- 表格: 4 种 Hook 类型
  - PreToolUse: 工具执行前 → 阻止 + 验证 + 修改参数
  - PostToolUse: 执行后 → 格式化 + 检查 + 推进流水线
  - Stop: 即将停止时 → 阻止停止 + 注入提醒
  - PreCompact: 压缩前 → 设标记 + 保存状态
- 要点: 确定性执行，不是建议

### Slide 16: Hook 实战 — 实验流水线
- Pipeline: dev → skill-update → experiment → monitoring → analysis → commit → dev (cycle)
- Stop hook 检测 10+ 文件编辑 → 提醒 /writing-skills
- PostToolUse 检测 Skill 完成 → 自动推进到下一阶段
- Stop hook 检测实验完成 → 提醒 /slides-dispatch
- 手动控制: pipeline-ctl.sh {status|set|skip|reset}

### Slide 17: Hook 实战 — 安全护栏
- slides-guard.sh (PreToolUse): 拦截对重型 skill 的直接调用，建议使用 dispatcher
- console.log audit (Stop): 会话结束前审计所有修改文件，阻止残留 console.log
- git push review (PreToolUse): 推送前在编辑器中打开 diff 供人工审查

### Slide 18: Skills — 机器可读的实验室手册
- 01: 文件夹，不只是 Markdown — 可含脚本、数据、模板；按需加载不占 token
- 02: 编码跨 session 生存的制度知识 — 实验流程、论文格式、代码规范永不遗忘
- 03: "你的研究 playbook，agent 可直接消费" — 从 idea 到 paper 每个阶段都有对应 skill

### Slide 19: 研究相关 Skills
- 表格:
  - fars-system: FARS 全自主研究系统架构指南
  - fars-reviewer: 论文 review agent 逻辑，完整性审计流水线
  - agent-exp-orchestration: 并行实验编排 (job 冲突、限速、子进程隔离、重试)
  - rope2sink: ICML 论文写作 (LaTeX 编辑与 attention sink 分析)
  - weekly-progress: 自动化周报生成

### Slide 20: Anthropic 内部 Skills 九大分类
- Source: Thariq Shihipar (@trq212)
- 3x3 网格:
  1. 库与 API 参考 — 正确用库/SDK + 踩坑点
  2. 产品验证 — Playwright/tmux 验证代码
  3. 数据获取与分析 — 连接数据/监控体系
  4. 业务流程自动化 — standup / ticket / weekly
  5. 代码脚手架 — 模板生成 + 自然语言需求
  6. 代码质量与审查 — adversarial-review / style
  7. CI/CD 与部署 — babysit-pr / deploy / rollback
  8. 运维手册 — 现象 → 排查 → 结构化报告
  9. 基础设施运维 — 维护操作 + 安全护栏
- 底部三条: description 写「何时触发」/ 踩坑点章节 = 信息量最大 / 渐进式披露用子目录

### Slide 21: Sub-agent — 独立上下文的专家
- 独立 context window + system prompt + tools，主 context 保持干净
- 内置类型: Explore (Haiku, 快速) / Plan / General-purpose / Custom
- 限制: 不能 spawn 其他 subagent — 防止无限嵌套与资源爆炸

### Slide 22: Subagent Delegation Pattern
- 图示:
  - Main Context (clean): User request → 收集需求 (~10 lines) → Spawn Agent → 收到 summary (5 lines)
  - Subagent Context (disposable): 读取 skill.md (~60KB) → 读取实验数据 → 生成 HTML (~3000 lines) → 写入文件
- 金句: "重活在一次性 context 里做，结果在干净 context 里收"

### Slide 23: Sub-agent 研究场景
- 并行执行: Agent 1 读论文提取方法论 / Agent 2 搜索已有实现 / Agent 3 查数据集可用性
- 分角色审查: 事实审查员 / 安全专家 / 资深工程师
- Writer / Reviewer 模式: Agent A 实现实验代码 + 生成 slides / Agent B 独立审计正确性

### Slide 24: Loop — 循环自主执行
- 命令: `/loop 5m <command>`
- 用例:
  - 训练监控: /loop 5m check GPU utilization and training loss
  - 实验轮询: /loop 10m check if experiment batch has completed
  - CI 观察: /loop 3m check GitHub Actions status for latest push
  - 资源监控: /loop 15m check disk space and memory usage on VPS

### Slide 25: 完整工作流 — Hooks + Skills + Subagents
- 三层架构图:
  - Trigger Layer (Hooks): Stop hook / PreCompact / PostToolUse
  - State Layer: current_stage / compact_pending / last_skill_upd / last_commit
  - Execution Layer (Skills): block + hint / user runs /skill-name / advance stage
- Pipeline: dev → skill-update → experiment → monitoring → analysis → commit → dev (cycle)

### Slide 26: Before / After — 论文复现
- 左 (IDE 助手): 8 步手动 — 读论文、问 AI 解释、手动粘贴代码、运行报错、问 AI 修复、重复、手动启动训练、手动监控
- 右 (Claude Code Agent): AReaL 案例 — 32 天 / 178 session / 72 万行净增 / 零手打代码 / Read 25,000 次 >> Edit 14,000 次 / 分层配置 / /pr-review 动态专家团队
- 底部: Agent 核心价值 = 理解与导航，不是生成

### Slide 27: Before / After — 实验生命周期
- 左 (传统): 手动追踪实验状态 / Context session 后丢失 / 无自动提醒 / 结果散落各处
- 右 (Pipeline + Hooks): Pipeline hooks 自动追踪阶段 (state.json) / Memory 跨 session 保留 / Stop hook 自动提醒下一步 / 自动生成 slides + changelog

---

## Part 3: 文档与管理技巧 (Slides 28-35)

### Slide 28: Part 3 Section Title
- "文档与管理技巧"
- "工程化你的 Harness，而不只是 Prompt"

### Slide 29: Harness Engineering 的核心理念
- 金句: "在 Cursor 里，你工程化 Prompt。在 Claude Code 里，你工程化 Harness。"
- Harness = CLAUDE.md + Hooks + Skills + Subagents + Pipeline

### Slide 30: 三篇 Harness Engineering 核心文章
- OpenAI — 系统生产工程: Repository knowledge / Agent legibility / 架构边界
- Anthropic — 长时运行框架: 任务分段 / 状态持久化 / 错误恢复 / self-check
- Manus — 工作记忆管理: 信息密度 / 相关性 / 时效性
- 一句话区分: OpenAI 偏系统工程 / Anthropic 偏运行框架 / Manus 偏上下文管理

### Slide 31: CLAUDE.md 最佳实践
- DO 写进去: 构建命令 / 代码风格偏好 / 测试指南 / 架构决策
- DON'T 不要写: Claude 能自行推断的 / 标准行业惯例 / 详细 API 文档 (用 Skills) / 频繁变化的配置
- 底部: Hooks > CLAUDE.md (100% 执行) / Skills > CLAUDE.md (按需加载) / Token 预算 ~2.5K

### Slide 32: 9 条 Coding Agent 原则
- 3x3 网格:
  1. 少即是多 — 不装插件，基础 CLI 已足够
  2. Context is Everything — 研究与实现阶段分离，指令精确
  3. 利用讨好倾向 — 用中立 Prompt，防止 Agent 编造
  4. 避免填空 — 在 CLAUDE.md 设规则，防止乱猜
  5. 定义终点 — 测试驱动 / CONTRACT.md 验收标准
  6. CLAUDE.md 作逻辑目录 — 写 IF-ELSE 树指向规则文件
  7. Rules vs Skills — Rules = 偏好；Skills = 执行菜谱
  8. 定期清理 — 让 Agent 自我整理，删除矛盾规则
  9. 别追新工具 — 官方集成的才是真正有用的
- Source: @systematicls

### Slide 33: Boris Cherny 10 Tips (1-5)
- 1. git worktree 多会话并行 — 同时运行多个 Claude 实例互不干扰
- 2. 先 Plan Mode 再实现 — 一个 Claude 写计划，另一个审计划
- 3. 每次纠正后更新 CLAUDE.md — 把规则写进去防止同类错误复现
- 4. 日常操作做成 Skills — 每天用 >1 次的操作变成自定义 slash command
- 5. Slack MCP 让 Claude 独立修 bug — 粘贴 bug thread 让 Claude 自主查看 CI 日志

### Slide 34: Boris Cherny 10 Tips (6-10)
- 6. Claude 做 reviewer 挑战代码 — 让 Claude 扮演审查者要求重写
- 7. Ghostty 终端 + 语音输入 — 更好的渲染 + 语音让 Prompt 更详细
- 8. "use subagents" 投入更多计算 — 附加关键词，主 context 保持干净
- 9. 直接用 BigQuery 等 CLI 做分析 — 无需手写 SQL 实时分析
- 10. 生成 HTML 演示文稿学习代码 — 可视化解释 + ASCII 架构图

### Slide 35: 常见失败模式
- 表格 (失败模式 / 问题 / 解决方案):
  - 厨房水槽 Session: 无关任务混入同一会话 → /clear
  - 反复纠正: 失败尝试堆积 → 纠正 2 次后 /clear 重新给干净 Context
  - CLAUDE.md 过长: 内容太多被忽略规则矛盾 → 无情删减 + IF-ELSE 逻辑目录 + Skills
  - 信任验证差距: 边界 case 未覆盖 Agent 走错路 → 提供可验证的完成标准 (CONTRACT.md)
  - 无限探索: Context 耗尽前仍漫无目的探索 → 缩小范围或用 subagent 隔离

---

## Closing (Slides 36-38)

### Slide 36: 核心要点
1. 这是范式跃迁，不是工具更换
2. 工程化你的 Harness: Hooks + Skills + Subagents + Loop
3. Context 是最关键的资源 — 主动管理它
4. 构建可复用的工作流，而非一次性 Prompt

### Slide 37: 参考阅读
- 左列:
  - OFFICIAL DOCS: overview / best-practices / how-claude-code-works / memory / hooks-guide / skills / sub-agents / features-overview
  - HARNESS ENGINEERING: OpenAI / Anthropic (x2) / Manus
- 右列:
  - KEY PEOPLE: @trq212 Skills 九大分类 / @bcherny 10 Tips / @systematicls 9 Principles / @HiTw93 六层架构
  - GITHUB: anthropics/claude-code (78.1k) / anthropics/skills / obra/superpowers / inclusionAI/AReaL / affaan-m/everything-claude-code
  - COMMUNITY: skills.sh / clawhub.com / Agent SDK

### Slide 38: End
- "Questions?"
- 金句: "未来属于那些工程化 Agent 的人，而非仅仅 Prompt 它们的人。"
- @sum_young | 2026-03-16
