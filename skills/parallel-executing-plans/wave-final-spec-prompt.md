# Wave FINAL · F1 规格合规审查 prompt 模板

派发 F1 reviewer 时使用此模板。F1 与 F2/F3/F4 并发派发，关注点**互不重叠**。

**F1 关注点（独占）：** 全 plan vs 原始规格的**条目级**对账。每条规格需求都要在实现里找到对应。

```
Task tool (general-purpose):
  description: "Wave FINAL F1: 全 plan 规格合规审查"
  prompt: |
    你是 Wave FINAL 的 F1 reviewer，做**全 plan 规格合规审查**。
    与你并发的还有 F2（代码质量）/ F3（真实手测）/ F4（范围保真）——它们各自审查不同维度，**不要越界**。

    ## 你的范围

    你审查整个 plan 的实现 vs 原始规格/需求文档的**逐条对账**：
    - **Must Have** 列表中每一条需求 → 是否在代码中实现？
    - **Must NOT Have / 边界条件** 列表中每一条 → 是否被遵守（无违反）？
    - 规格中的每个章节/小节 → 至少有一个对应的实现任务覆盖？

    ## 你不审查的内容（避免与其它 reviewer 重叠）

    - 代码风格、命名、抽象层级 → 这是 F2 的工作
    - 真实功能跑起来对不对 → 这是 F3 的工作
    - 是否实现了规格之外的东西 → 这是 F4 的工作

    ## 输入

    - **原始规格/plan：** [PLAN_FILE_PATH]
    - **本次实现的 commit 范围：** [BASE_SHA..HEAD_SHA]
    - **完整的 task 清单 + 实现汇报：** [由 controller 提供]

    ## 你的工作

    1. 通读 plan/规格，列出全部 **Must Have**、**Must NOT Have**、章节级需求
    2. 对每一条，在 commit 范围内找证据：
       - 实现的 file:line（哪段代码履行了这条需求）
       - 测试的 file:line（如有）
    3. 对找不到证据的需求，明确标记**缺失**

    ## 输出格式

    ```
    VERDICT: APPROVE | REJECT

    Must Have 覆盖：[N/M] 条
    Must NOT Have 遵守：[N/M] 条
    章节覆盖：[N/M] 节

    REJECT 原因（仅当 REJECT）：
    - [需求描述] — 缺失：在 commit 范围内未找到对应实现
    - [需求描述] — 违反：file:line 处出现禁止的模式
    ```
```

**当 F1 给 REJECT 时**：controller 派发修复 subagent 修缺失的需求，再仅重跑 F1（不要顺带重跑 F2/F3/F4）。
