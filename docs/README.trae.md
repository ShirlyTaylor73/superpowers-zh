# Superpowers 中文版 — Trae 安装指南

在 [Trae](https://www.trae.ai)（字节跳动 AI IDE）中使用 superpowers-zh 的完整指南。

## 安装

```bash
git clone https://github.com/ShirlyTaylor73/superpowers-zh.git
mkdir -p /your/project/.trae/rules
cp -r superpowers-zh/skills/* /your/project/.trae/rules/
```

## 工作原理

Trae 使用 `.rules` 机制管理 AI 行为：

- **目录**：`.trae/rules/`
- **格式**：Markdown + metadata（description、globs、alwaysApply、priority）
- **规则类型**：
  - **项目规则**（Project Rules）— 仅作用于当前项目
  - **个人规则**（Personal Rules）— 用户级别，可被项目规则覆盖
- **优先级**：1-4，数值越高优先级越高

### Skills 适配

superpowers-zh 的 SKILL.md 文件可以直接作为 Trae 的 rules 使用。Trae 会在初始化时加载 `.trae/rules/` 下的所有规则文件。

### 推荐配置

安装完成后，在 Trae 的 Builder Mode 或 Chat 中提到 skill 名称即可激活：

```
使用头脑风暴 skill 来分析这个需求
```

## 中文支持

Trae 原生支持中文，与 superpowers-zh 完美配合：
- 所有 skills 均为中文
- 中文代码审查、中文 Git 工作流等国内特色 skills 开箱即用
- 支持 MCP 协议扩展

## 更新

```bash
cd /path/to/superpowers-zh
git pull
cp -r skills/* /your/project/.trae/rules/
```

## 获取帮助

- 提交 Issue：https://github.com/ShirlyTaylor73/superpowers-zh/issues
- Trae 文档：https://docs.trae.ai/ide/rules
