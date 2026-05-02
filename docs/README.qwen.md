# Superpowers 中文版 — Qwen Code 安装指南

在 [Qwen Code](https://tongyi.aliyun.com/qianwen) (通义灵码) 中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.qwen
cp -r superpowers-zh/plugins/superpowers-zh/skills /your/project/.qwen/skills
```

或全局安装：

```bash
mkdir -p ~/.qwen/skills
cp -r superpowers-zh/plugins/superpowers-zh/skills/* ~/.qwen/skills/
```

## Skill 加载优先级

| 位置 | 优先级 | 说明 |
|------|--------|------|
| `.qwen/skills/` | 最高 | 项目级，仅当前项目 |
| `~/.qwen/skills/` | 中 | 用户级，所有项目共享 |

## 使用

安装完成后重启 Qwen Code，skills 会自动生效。

在 Qwen Code 中可以通过以下方式调用 skills：

```
请使用 brainstorming skill 来分析这个需求
```

```
按照 test-driven-development skill 的方法来实现这个功能
```

## 故障排查

### Skills 未生效

1. 确认 `.qwen/skills/` 目录存在且包含 skill 文件夹
2. 每个 skill 需要包含有效 YAML frontmatter 的 `SKILL.md` 文件
3. 重启 Qwen Code 或刷新会话

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- 通义灵码文档：https://tongyi.aliyun.com/lingma
