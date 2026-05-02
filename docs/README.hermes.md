# Superpowers 中文版 — Hermes Agent 安装指南

在 [Hermes Agent](https://github.com/NousResearch/hermes-agent) 中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.hermes
cp -r superpowers-zh/skills /your/project/.hermes/skills
```

## 通过 HERMES.md 引导

Hermes Agent 在会话开始时自动加载项目根目录下的 `HERMES.md`（或 `.hermes.md`）作为上下文。可以手动创建此文件，写入：

- 工具映射表（Claude Code → Hermes Agent 工具名称）
- 所有可用 skills 的列表和描述
- 核心规则和使用说明

## 通过 config.yaml 配置外部 skills 目录

如果希望全局使用 superpowers-zh skills，可以在 `~/.hermes/config.yaml` 中配置：

```yaml
skills:
  external_dirs:
    - /path/to/superpowers-zh/skills
```

## 工具映射

Skills 中引用的 Claude Code 工具名称对应 Hermes Agent 的等价工具：

| Claude Code | Hermes Agent |
|-------------|-------------|
| `Read` | `read_file` |
| `Write` | `write_file` |
| `Edit` | `patch` |
| `Bash` | `terminal` |
| `Grep` / `Glob` | `search_files` |
| `Skill` | `skill_view` |
| `Task`（子智能体） | `delegate_task` |
| `WebSearch` | `web_search` |
| `WebFetch` | `web_extract` |
| `TodoWrite` | `todo` |

完整映射参见 `skills/using-superpowers/references/hermes-tools.md`。

## 使用技能

Hermes Agent 支持三级渐进式加载：

```
# 浏览所有可用技能
skills_list

# 加载某个技能的完整内容
skill_view("brainstorming")

# 查看技能的引用文件
skill_view("using-superpowers", "references/hermes-tools.md")
```

## 故障排查

### Skills 未发现

1. 确认 `.hermes/skills/` 目录存在且包含 skill 文件夹
2. 每个 skill 目录下需要有 `SKILL.md` 文件
3. 使用 `skills_list` 查看已发现的技能

### HERMES.md 未加载

1. 确认文件在项目根目录（与 `.hermes/` 同级）
2. 文件名可以是 `HERMES.md` 或 `.hermes.md`

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- Hermes Agent 文档：https://hermes-agent.nousresearch.com/docs/
