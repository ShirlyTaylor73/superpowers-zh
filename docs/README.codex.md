# Superpowers 中文版 — Codex CLI 安装指南

在 Codex CLI 中使用 superpowers-zh 的完整指南。

> Codex CLI 自 2026-04 起已原生支持插件市场（含远程市场缓存、插件升级、hooks 启用状态等）。**强烈推荐用插件市场安装**，这也是 OpenAI 官方推荐方式。本文档同时保留了旧的符号链接方案作为 fallback。

---

## 方式一：插件市场安装（推荐）

### 前置条件

- Codex CLI ≥ 2026-04（`codex --version` 查看；旧版本请先升级 `npm i -g @openai/codex` 或 `brew upgrade codex`）

### 注册市场并安装

```bash
codex plugin marketplace add ShirlyTaylor73/superpowers-zh
```

支持的来源格式（Codex 官方）：
- GitHub shorthand：`ShirlyTaylor73/superpowers-zh`
- 锁定 ref：`ShirlyTaylor73/superpowers-zh@v1.1.8` 或 `--ref v1.1.8`
- HTTPS Git URL：`https://github.com/ShirlyTaylor73/superpowers-zh.git`
- SSH Git URL：`git@github.com:ShirlyTaylor73/superpowers-zh.git`
- 本地路径：`/path/to/superpowers-zh`

注册成功后启动 Codex，在交互界面输入：

```
/plugins
```

在列表中选中 `superpowers-zh` → 安装。

### 更新 · 移除 · 禁用

```bash
codex plugin marketplace upgrade                 # 刷新所有 Git 市场
codex plugin marketplace upgrade superpowers-zh  # 仅刷新本市场
codex plugin marketplace remove superpowers-zh   # 移除市场
```

不卸载只禁用：编辑 `~/.codex/config.toml`，将 `superpowers-zh` 条目设为 `enabled = false`，重启 Codex。

---

## 方式二：符号链接（fallback）

如果你的 Codex 版本 < 2026-04 还不支持 `codex plugin marketplace`，或插件市场方式失败，可以走符号链接方案。

### 步骤

1. 克隆仓库：
   ```bash
   git clone https://github.com/ShirlyTaylor73/superpowers-zh.git ~/.codex/superpowers-zh
   ```

2. 创建 skills 符号链接：
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/superpowers-zh/skills ~/.agents/skills/superpowers
   ```

3. 重启 Codex。

4. **子代理 skills（可选）：** `dispatching-parallel-agents` 和 `parallel-executing-plans` 需要 Codex 的多代理功能。在 `~/.codex/config.toml` 中添加：
   ```toml
   [features]
   multi_agent = true
   ```

### Windows

使用 junction 代替符号链接（无需开发者模式）：

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\superpowers" "$env:USERPROFILE\.codex\superpowers-zh\skills"
```

### 工作原理

Codex 启动时扫描 `~/.agents/skills/` 目录，解析 SKILL.md 的 frontmatter，按需加载 skills。通过一个符号链接即可注册所有 skills：

```
~/.agents/skills/superpowers/ → ~/.codex/superpowers-zh/skills/
```

`using-superpowers` skill 会自动被发现并强制执行 skill 使用纪律——无需额外配置。

### 更新 / 卸载（fallback 方案）

```bash
cd ~/.codex/superpowers-zh && git pull       # 更新（符号链接即时生效）
rm ~/.agents/skills/superpowers              # 卸载
rm -rf ~/.codex/superpowers-zh               # 可选：删除克隆
```

Windows 卸载：
```powershell
Remove-Item "$env:USERPROFILE\.agents\skills\superpowers"
```

---

## 使用

不论走哪种方式，Skills 都会自动发现。Codex 在以下情况激活 skills：

- 你提到 skill 名称（如 "use brainstorming"）
- 任务匹配 skill 的描述
- `using-superpowers` skill 指示 Codex 使用某个 skill

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- 项目主页：https://github.com/ShirlyTaylor73/superpowers-zh
- Codex 官方插件文档：https://developers.openai.com/codex/plugins
