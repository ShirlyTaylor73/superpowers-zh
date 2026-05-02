# Superpowers 中文版 — VS Code (Copilot) 安装指南

在 VS Code + GitHub Copilot 中使用 superpowers-zh 的完整指南。

## 前置条件

- VS Code（最新版本）
- GitHub Copilot 扩展（免费版或付费版均可）

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.github/superpowers
cp -r superpowers-zh/plugins/superpowers-zh/skills/* /your/project/.github/superpowers/
```

## 工作原理

VS Code Copilot 使用 `.github/copilot-instructions.md` 作为项目级自定义指令：

- **位置**：项目根目录 `.github/copilot-instructions.md`
- **格式**：Markdown
- **生效范围**：该工作区内的所有 Copilot Chat 和内联补全
- **自动加载**：保存文件后立即生效，无需重启

### 推荐配置

由于 Copilot 主要通过单个指令文件工作，建议创建 `.github/copilot-instructions.md` 引用 skills：

```markdown
# Copilot 自定义指令

## 工作流方法论

本项目使用 superpowers-zh skills 框架。开始新任务前，请参考以下方法论：

- 新需求 → 先头脑风暴（.github/superpowers/brainstorming/SKILL.md）
- 写代码 → TDD 驱动（.github/superpowers/test-driven-development/SKILL.md）
- 修 Bug → 系统化调试（.github/superpowers/systematic-debugging/SKILL.md）
- 审查代码 → 中文代码审查（.github/superpowers/chinese-code-review/SKILL.md）

## 中文项目规范

- 代码注释和文档使用中文
- Git commit 遵循中文提交规范
- 技术术语保留英文原文
```

### 使用 .instructions.md 文件（推荐）

VS Code 还支持更细粒度的 `.instructions.md` 文件：

```
.github/
  copilot-instructions.md          # 全局指令
  .instructions/
    typescript.instructions.md     # TypeScript 文件专用
    testing.instructions.md        # 测试相关
```

## 使用

在 VS Code 中：
- **Copilot Chat**（`Ctrl+Shift+I`）：直接引用 skill 名称
- **内联补全**：自动遵循 copilot-instructions.md 中的规则
- **`/init`**：在 Chat 中输入，自动生成项目配置

## 局限性

VS Code Copilot 不像 Claude Code 那样支持 `Skill` 工具或子 Agent 派遣。以下 skills 需要手动参考而非自动执行：

- 派遣并行 Agent（需要 Agent 框架支持）
- 子 Agent 驱动开发（需要 Agent 框架支持）
- Git Worktree 使用（需要终端操作）

其他方法论类 skills（头脑风暴、TDD、调试、代码审查等）完全兼容。

## 更新

```bash
cd /path/to/superpowers-zh
git pull
cp -r plugins/superpowers-zh/skills/* /your/project/.github/superpowers/
```

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- VS Code Copilot 文档：https://code.visualstudio.com/docs/copilot/customization/custom-instructions
