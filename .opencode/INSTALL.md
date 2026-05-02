# 为 OpenCode 安装 Superpowers 中文版

OpenCode 不使用本仓库的 Claude/Codex marketplace 配置。它通过 `opencode.json` 加载 Git 插件，并读取 `package.json.main` 指向的入口。

## 安装

在全局或项目级 `opencode.json` 中添加：

```json
{
  "plugin": ["superpowers@git+https://github.com/ShirlyTaylor73/superpowers-zh.git"]
}
```

重启 OpenCode 后，插件会自动注册 `plugins/superpowers-zh/skills`。

## 使用

```text
use skill tool to list skills
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

- `package.json.main` 指向 `plugins/superpowers-zh/.opencode/plugins/superpowers.js`
- `config` hook 注册 skills 搜索路径
- `experimental.chat.messages.transform` hook 注入 `using-superpowers` 引导上下文
- `plugins/superpowers-zh/hooks/*.json` 只供 Claude/Codex/Cursor 等平台使用，不供 OpenCode 使用
