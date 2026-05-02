# Superpowers 中文版 — DeerFlow 2.0 安装指南

在 [DeerFlow 2.0](https://github.com/bytedance/deer-flow)（字节跳动开源 SuperAgent）中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/deerflow-project/skills/custom
cp -r superpowers-zh/skills/* /your/deerflow-project/skills/custom/
```

## 工作原理

DeerFlow 2.0 使用 **Custom Skills** 机制扩展 Agent 能力：

- **目录**：`skills/custom/`
- **格式**：每个 skill 是一个目录，包含 `SKILL.md` 文件（Markdown + YAML frontmatter）
- **加载方式**：DeerFlow 自动扫描 `skills/custom/` 下的所有目录，通过 `description` 字段匹配 skill

### Skills 格式兼容

superpowers-zh 的 SKILL.md 文件格式与 DeerFlow 自定义 skills 完全兼容。安装后，DeerFlow 会自动发现并加载所有 skills。

### 环境变量

如果你的 DeerFlow 项目不在当前目录，可以手动指定安装路径：

```bash
export DEERFLOW_SKILLS_DIR=/path/to/deerflow/skills/custom
cp -r superpowers-zh/skills/* $DEERFLOW_SKILLS_DIR/
```

## 使用

安装后，在 DeerFlow 对话中引用 skill 名称即可：

- 「使用头脑风暴来分析这个需求」
- 「用测试驱动开发来实现这个功能」
- 「按系统化调试流程排查这个 bug」

DeerFlow 会根据 skill 的 `description` 自动匹配并加载。

## 更新

```bash
cd /path/to/superpowers-zh
git pull
cp -r skills/* /your/deerflow-project/skills/custom/
```

拉取最新仓库内容后重新复制 skills 即可更新。

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- DeerFlow 文档：https://github.com/bytedance/deer-flow
