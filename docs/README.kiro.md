# Superpowers 中文版 — Kiro 安装指南

在 [Kiro](https://kiro.dev)（Amazon AI IDE）中使用 superpowers-zh 的完整指南。

## 快速安装

```bash
cd /your/project
npx superpowers-zh
```

安装脚本会自动检测 `.kiro/` 目录并将 skills 复制到 `.kiro/steering/`。

## 手动安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
cp -r superpowers-zh/skills/* /your/project/.kiro/steering/
```

## 工作原理

Kiro 使用 **Steering** 机制管理 AI 行为规则：

- **目录**：`.kiro/steering/`
- **格式**：Markdown + YAML frontmatter
- **加载模式**：
  - `alwaysApply: true` — 每次对话自动加载
  - `globs: "*.ts"` — 匹配特定文件时加载
  - 手动引用 — 在聊天中输入 `#steering-file-name`

### Skills 与 Steering 的对应

superpowers-zh 的 SKILL.md 文件格式与 Kiro Steering 文件兼容（都是 Markdown + YAML frontmatter）。安装后，Kiro 会自动识别并加载 skills。

### 推荐配置

在 `.kiro/steering/` 中创建 `superpowers.md`：

```markdown
---
description: 加载 superpowers skills 框架
alwaysApply: true
---

使用 .kiro/steering/ 目录下的 superpowers skills 来指导工作流程。
优先使用 brainstorming（头脑风暴）开始新任务。
```

## 使用

在 Kiro 中，你可以：
- 直接提到 skill 名称：「使用头脑风暴来分析这个需求」
- 手动引用：在聊天中输入 `#brainstorming`
- Skills 会根据任务类型自动激活

## 更新

```bash
cd /your/project
npx superpowers-zh
```

重新运行安装命令即可更新到最新版本。

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- Kiro 文档：https://kiro.dev/docs/steering/
