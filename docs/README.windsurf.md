# Superpowers 中文版 — Windsurf 安装指南

在 [Windsurf](https://codeium.com/windsurf) 中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.windsurf
cp -r superpowers-zh/skills /your/project/.windsurf/skills
```

或全局安装：

```bash
cp -r superpowers-zh/skills ~/.windsurf/skills
```

## Skill 加载优先级

| 位置 | 优先级 | 说明 |
|------|--------|------|
| `.windsurf/skills/` | 最高 | 项目级，仅当前项目 |
| `~/.windsurf/skills/` | 中 | 用户级，所有项目共享 |

## 使用

安装完成后重启 Windsurf，skills 会自动生效。

也可以在 `.windsurfrules` 文件中引用 skills 目录：

```
请参考 .windsurf/skills/ 目录中的 SKILL.md 文件作为工作方法论。
```

## 故障排查

### Skills 未生效

1. 确认 `.windsurf/skills/` 目录存在且包含 skill 文件夹
2. 每个 skill 需要包含有效 YAML frontmatter 的 `SKILL.md` 文件
3. 重启 Windsurf

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- Windsurf 文档：https://docs.codeium.com/windsurf
