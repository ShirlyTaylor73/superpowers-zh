# Superpowers 中文版 — OpenClaw 安装指南

在 [OpenClaw](https://github.com/anthropics/openclaw) 中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/skills
cp -r superpowers-zh/skills/* /your/project/skills/
```

或安装到全局（所有项目共享）：

```bash
cp -r superpowers-zh/skills/* ~/.openclaw/skills/
```

## 工作原理

OpenClaw 按以下优先级加载 skills：

| 位置 | 优先级 | 说明 |
|------|--------|------|
| `<workspace>/skills/` | 最高 | 工作区级，当前项目专用 |
| `~/.openclaw/skills/` | 中 | 用户级，所有项目共享 |
| 内置 skills | 最低 | OpenClaw 自带 |

每个 skill 是一个 `skills/{name}/SKILL.md` 文件，包含 YAML frontmatter 和指令内容。OpenClaw 会自动发现并加载。

### 推荐配置方式

在项目根目录的 `CLAUDE.md` 或 `AGENTS.md` 中引用：

```markdown
# CLAUDE.md

本项目使用 superpowers-zh skills 框架。
优先使用 brainstorming（头脑风暴）开始新任务。
Skills 位于 skills/ 目录下。
```

### 工具映射

OpenClaw 与 Claude Code 使用相同的工具名称，skills 无需额外适配：

| 工具 | OpenClaw | Claude Code |
|------|----------|-------------|
| 读文件 | `Read` | `Read` |
| 写文件 | `Write` | `Write` |
| 编辑 | `Edit` | `Edit` |
| 终端 | `Bash` | `Bash` |
| Skills | `Skill` | `Skill` |

## 使用

安装完成后重启 OpenClaw，所有 skills 会自动生效。你可以：

- 输入 `/brainstorming` 开始头脑风暴
- 输入 `/commit` 使用中文提交规范
- 在任何编码任务中，skills 会被自动调用

## 全局 Skills

如果你想让所有项目都能使用 superpowers-zh：

```bash
mkdir -p ~/.openclaw/skills
cp -r superpowers-zh/skills/* ~/.openclaw/skills/
```

也可以通过 `~/.openclaw/openclaw.json` 配置额外 skills 目录：

```json
{
  "skills": {
    "load": {
      "extraDirs": ["/path/to/superpowers-zh/skills"]
    }
  }
}
```

## 更新

```bash
cd /path/to/superpowers-zh
git pull
cp -r skills/* /your/project/skills/
```

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- QQ 群：833585047
