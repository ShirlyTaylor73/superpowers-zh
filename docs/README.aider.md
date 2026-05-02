# Superpowers 中文版 — Aider 安装指南

在 [Aider](https://aider.chat) 中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.aider
cp -r superpowers-zh/skills /your/project/.aider/skills
```

## 通过 CONVENTIONS.md 引用

Aider 原生支持 `CONVENTIONS.md` 文件。在其中引用 skills：

```markdown
# 项目约定

## 工作方法论

本项目使用 superpowers-zh skills 作为工作方法论。
Skills 位于 `.aider/skills/` 目录，每个子目录的 SKILL.md 定义一个工作流。

- 新功能开发：先使用 brainstorming skill
- 编写代码：遵循 test-driven-development skill
- 调试问题：使用 systematic-debugging skill
```

## 通过 .aider.conf.yml 配置

在 `.aider.conf.yml` 中添加 read 配置来加载 skills：

```yaml
read:
  - .aider/skills/brainstorming/SKILL.md
  - .aider/skills/test-driven-development/SKILL.md
  - .aider/skills/systematic-debugging/SKILL.md
```

## 故障排查

### Skills 未生效

1. 确认 `.aider/skills/` 目录存在且包含 skill 文件夹
2. 确保在 `CONVENTIONS.md` 或 `.aider.conf.yml` 中引用了 skills
3. Aider 会自动读取 `CONVENTIONS.md`，无需额外配置

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- Aider 文档：https://aider.chat/docs/
