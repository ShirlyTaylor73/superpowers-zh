# 我用了一段时间 superpowers，我把它又改了一遍：superpowers-zh 二次增强版

> 适合发到：公众号 / 知乎 / 掘金 / V2EX
> 仓库：https://github.com/ShirlyTaylor73/superpowers-zh

---

superpowers 是我接触 coding agent 以来一直在用的 harness 框架。但用下来之后，发现有几个让我特别难受的地方——估计很多佬友也有类似的体会：

## 我的 4 个痛点

**1. 开发速度太慢。**
superpowers 的计划制订和 subagent-driven 开发模式都是**串行**的——一个 subagent 干完下一个才上场。任务稍微复杂一点就开始拖，明明每一步可以并发，却被强行排成一队。

**2. plan 和 spec 全是英文。**
英文不好的看不懂，英文还行的也费劲——盯着一份 600 行的 markdown 计划读英文，眼睛先累了。明明是中文开发者在用，为啥要逼自己读英文方案？

**3. plan 多次回炉就崩。**
复杂项目里，对 agent 出的 plan 不满意要改。改一次还行，改两三次后 plan 就开始膨胀——AI 会自作主张写一堆 "版本记录"、"决策变更"、"补充说明 v2" 这种和 plan 本身没关系的东西，最后 plan 又长又前后矛盾，根本没法当执行手册用。

**4. brainstorming 阶段问得太少。**
Agent 不怎么追问，几个泛泛的问题就开干。导致开发到一半才发现某些关键细节没明确，被迫换技术路线。回头改 plan，又掉进痛点 3 的坑里——plan 漂移 → 上下文崩盘 → 推倒重来。

恶性循环。

---

## 所以我基于中文版的 superpowers-zh 重新做了一版

仓库地址：**https://github.com/ShirlyTaylor73/superpowers-zh**

我没有从头造轮子。中文翻译这一层 [`superpowers-zh`](https://github.com/obra/superpowers) 中文社区版已经做得很好，**直接解决了痛点 2**。我做的是在它的基础上**再叠加一层方法论增强**——专门针对剩下 3 个痛点。

四个核心升级，**每一个都精确对着一个痛点**：

### 🌊 升级 1：解决"开发太慢" → 多轮 Wave 并行执行

把原来的 `subagent-driven-development` 整个重写成 `parallel-executing-plans`：

- **wave 内并发**：同一波次的独立任务，全部并行派 subagent，不再串行排队
- **wave 间 gate**：有依赖的任务进入下一波次，等上一波 100% 完成才放行
- 全 plan 完成后启动 **Wave FINAL 4 审并发**：
  - **F1 规格合规** —— 实现是否吻合 spec
  - **F2 代码质量** —— 复用、可读、健壮性
  - **F3 真实手测** —— 用户视角端到端跑一遍
  - **F4 范围保真** —— 没有偷偷加超纲改动
- **修复回路 3 次未过 → 触发用户介入闸门**，不会无限循环烧 token

实际跑下来，原本要排队 1-2 小时的 plan，并发后基本能压到 20-30 分钟。

### 🛡️ 升级 2：解决"plan 多次回炉就崩" → "Plan 是执行手册"哲学

`writing-plans` 重写时，我把核心哲学定死成一句话：

> **plan 是 agent 一次性烧掉的执行手册，不是设计文档，更不是变更记录。**

围绕这句话布了 4 道防线：

1. **5 条设计原则**：Plan 是当前状态的唯一真相、可机械执行、并行结构显式、变更原地替换、无历史痕迹
2. **内容规定**：明确什么该写（任务清单、依赖图、metadata、验证步骤）、什么禁止写（"上一版决定..."、"经过讨论..."、"v2 补充..."）
3. **机械化校验**：每次编辑后强制 `git diff` 自检 + metadata 5 字段同步 + 并行图重算
4. **新建 / 编辑双路径 skill 适配**：`writing-plans` 自动判断当前是新建还是修订；编辑模式下任何 "新增段落" 都要求先证明能否原地替换

效果：plan 改十遍还是清爽干净的执行手册，**不会越改越长、越改越乱**。

### 🔥 升级 3：解决"brainstorming 不问问题" → 吸收 grill-me 风格的高强度盘问

`brainstorming` 不再是温和的"请问您想怎么做"。新版是按**决策树分层遍历**的高强度盘问：

- **决策树式遍历**：根（目标 / 约束 / 成功标准）→ 中（架构选择）→ 叶（实现细节），**父节点没定不下钻子节点**
- **每问必给推荐 + 选项 + 开放填空**：每个问题节点都提供多个互斥选项 + 1 个开放填空 + 1 个推荐方案 + 推荐理由
- **代码库优先**：能从代码 / 文档 / commit 读出的事实，绝不浪费用户时间去问
- **盘问到底**：模糊回答必追问，"看你"、"按你推荐"才放行

这一步逼你（和 AI）在动手之前**把 spec 一次说到位**，从源头掐死后期"换技术路线"导致的崩盘。

### ⚡ 升级 4：解决"交互轮次太多" → 单轮批量 ask user

光盘问还不够——盘问得越细，往返就越多。如果 10 个决策点要聊 10 轮，体验比不盘问还糟。

所以新版**直接利用 ask user tool**，在单轮问答里把同一深度的多个决策合并成一次发问：

- 一轮工具调用 = 同深度多个决策节点合并提问
- 每个节点都带选项和推荐
- 用户一次性把 5-10 个相关决策回答完，agent 立刻进入下一深度

**交互效率直接起飞。** 原来要聊 30 分钟的需求澄清，现在 3-5 轮批量问答就能锁定 spec。

---

## ✅ 已在 Claude Code 与 Codex CLI 双平台实测

不是只在自己机器上跑通就发——v1.1.9 已经在两大主流 Agent CLI 上完成端到端验证：

`brainstorming` → `writing-plans` → `parallel-executing-plans` → `finishing-a-development-branch`

完整链路全部跑通。两套独立的 plugin manifest（[`.claude-plugin/`](https://github.com/ShirlyTaylor73/superpowers-zh/tree/main/plugins/superpowers-zh/.claude-plugin) + [`.codex-plugin/`](https://github.com/ShirlyTaylor73/superpowers-zh/tree/main/plugins/superpowers-zh/.codex-plugin)）确保两边都能 `/plugin install` 一键到位，hooks 自动注入 SessionStart 上下文。

## 🚀 一行命令安装

**Claude Code：**

```
/plugin marketplace add ShirlyTaylor73/superpowers-zh
/plugin install superpowers-zh@superpowers-zh
```

**Codex CLI：**

```
codex plugin marketplace add ShirlyTaylor73/superpowers-zh
```

其余 15 款工具（Cursor / Windsurf / Kiro / Hermes Agent / Trae / Aider / Qwen Code（通义灵码）/ Claw Code / Antigravity / DeerFlow / VS Code 等）克隆仓库后把 `skills/` 复制到对应目录即可，README 有详细对照表。

## 📦 项目信息

- 🔗 **仓库：** https://github.com/ShirlyTaylor73/superpowers-zh
- 📦 **20 个 skills**（14 个翻译 + 6 个中国原创）
- 🤖 **17 款 AI 编程工具支持**
- 🇨🇳 **国内 Git 平台全覆盖：** GitHub + Gitee + Coding + 极狐 GitLab + CNB
- 📜 **MIT License**

## 🙏 致谢

- 感谢 [obra/superpowers](https://github.com/obra/superpowers) 提供方法论内核（159k+ stars，常看常新）
- 感谢中文社区维护的翻译版打了底，让我能把精力集中在方法论增强上

## 💬 邀请试用 + 反馈

如果你也受够了 AI "不问就开干"、"plan 改两次就崩"、"subagent 排长队" 这些毛病——

**欢迎 Star 试用。**
**欢迎提 Issue 反馈使用痛点。**
**更欢迎 PR：** 中国开发者的痛点你最懂，写成 skill 提交就行（贡献指南见 README）。

中文社区一起把 AI 编程工作流打磨得更顺手。

---

## 备选标题

如果上面的标题不喜欢，可以从下面挑一个：

1. 用了一段时间 superpowers，我把它又改了一遍：superpowers-zh 二次增强版（默认）
2. 改完 superpowers 我开发效率翻倍：分享我的中文二次增强版
3. 给 superpowers 二次开发：4 个用了就懂的痛点是怎么解的
4. AI 写代码不问就开干？我把 superpowers 重写了一版
5. 把 subagent 串行队列改成多轮 wave 并行：superpowers-zh 二次增强版发布

## 发布平台节奏建议

- **公众号 / 掘金：** 直接全文，配一张架构示意图（4 升级对应 4 痛点）
- **知乎：** 标题改成问句更好，比如《如何让 Claude Code / Codex 写代码前先问问题？》，正文裁短到 1500 字以内
- **V2EX：** 节点选 `share` 或 `programmer`，正文砍掉表情符号，保留代码块和命令
- **即刻 / X：** 用 README 里的"短稿"版本，140 字以内
