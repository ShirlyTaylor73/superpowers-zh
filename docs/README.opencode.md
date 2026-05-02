# Superpowers 中文版 — OpenCode 安装指南

在 [OpenCode.ai](https://opencode.ai) 中使用 superpowers-zh 的完整指南。

## 安装

OpenCode 不读取本仓库的 Codex marketplace（`.agents/plugins/marketplace.json`）或 Claude marketplace（`.claude-plugin/marketplace.json`）。它通过 `opencode.json` 的 `plugin` 数组加载 Git 插件，并使用 `package.json` 的 `main` 入口。

在全局或项目级 `opencode.json` 中添加：

```json
{
  "plugin": ["superpowers@git+https://github.com/ShirlyTaylor73/superpowers-zh.git"]
}
```

重启 OpenCode。插件会通过 `config` hook 自动注册 `plugins/superpowers-zh/skills`，无需手动符号链接。

验证方式：询问“告诉我你有哪些 superpowers”。

## 使用

列出可用 skills：

```text
use skill tool to list skills
```

加载某个 skill：

```text
use skill tool to load superpowers/brainstorming
```

## 更新

未锁定版本时，OpenCode 会在启动时按 Git 源更新插件。

锁定特定版本：

```json
{
  "plugin": ["superpowers@git+https://github.com/ShirlyTaylor73/superpowers-zh.git#v1.1.9"]
}
```

## 工作原理

插件入口由 `package.json.main` 指向 `plugins/superpowers-zh/.opencode/plugins/superpowers.js`。

插件做两件事：

1. 通过 `config` hook 把 `plugins/superpowers-zh/skills` 加入 OpenCode 的 skills 搜索路径。
2. 通过 `experimental.chat.messages.transform` hook，把 `using-superpowers` 的引导上下文注入首个用户消息。

Claude/Codex 的 `plugins/superpowers-zh/hooks/*.json` 不会被 OpenCode 使用。

## 故障排查

如果插件未加载：

1. 检查 `opencode.json` 中的 `plugin` 配置。
2. 运行 `opencode run --print-logs "hello"` 查看加载日志。
3. 确认仓库中的 `package.json.main` 指向存在的 OpenCode 插件入口。

如果 skills 未发现：

1. 使用 OpenCode 的 `skill` 工具列出可用 skills。
2. 确认 `plugins/superpowers-zh/skills/using-superpowers/SKILL.md` 存在。

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- OpenCode 文档：https://opencode.ai/docs/
