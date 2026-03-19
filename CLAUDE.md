# CC Research Playbook

研究 talk 幻灯片项目："CC Research Playbook — AI Researcher 的 CLI Agent 实践指南"

## 项目结构

```
slides/                    # 所有幻灯片相关文件
  academic-light.css       # Academic Light 主题 (Anthropic 风格)
  ch-opening.html          # ZH 片段: 标题页
  ch-part1.html            # ZH 片段: 范式之争 + Context is All You Need
  ch-part2.html            # ZH 片段: 18 页核心内容 (Skills/Hooks/Subagents/Loop/Superpowers/Labmate)
  ch-part3.html            # ZH 片段: CLAUDE.md 最佳实践 / Tips / 失败模式
  ch-closing.html          # ZH 片段: Mindset / References / End
  ch-*-en.html             # EN 片段 (待更新)
  presentation.html        # ZH 构建产物
  presentation-en.html     # EN 构建产物
  build.sh                 # 构建脚本
  slide-outline.md         # 25 页 slide 结构大纲
  color-mapping.txt        # 颜色映射参考
  theme-preview.html       # 主题独立预览
docs/
  references.md            # 所有参考链接 + TLDR (按主题分类)
```

## 构建

```bash
cd slides && ./build.sh        # 中文版
cd slides && ./build.sh en     # 英文版
```

编辑任何 `ch-*.html` 片段后，必须重新运行 build.sh。

## 叙事框架: "Context is All You Need"

核心论点: CLI Agent 工程的一切围绕 context 管理，分三个维度:
- **Input**: 喂足够的 context (Skills, Brainstorming, Paper Agents)
- **Output**: 驱动高效决策 (Hooks, Subagents, Pipelines)
- **Management**: 保持 agent 清醒 (Memory, /compact, docs)

## 主题样式

- Academic Light: 浅色背景 #FAFAF8, 衬线标题 (Source Serif 4), terra cotta 强调色 #C4704F
- CSS class: terminal-box, accent, dim, highlight, mono
- 参考链接用 terra cotta 色 + ↗ 图标

## 编辑约定

- 25 页 ZH slides, 分 5 个 fragment 文件
- EN 版尚未与 ZH 同步，待更新
- 每页 slide 是一个 `<section class="slide">` 块
