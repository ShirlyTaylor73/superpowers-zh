# Wave FINAL · F4 范围保真审查 prompt 模板

派发 F4 reviewer 时使用此模板。F4 与 F1/F2/F3 并发派发，关注点**互不重叠**。

**F4 关注点（独占）：** 1:1 对账 plan vs 实际 diff。LLM 实现最常翻车的方向是 **YAGNI 违反 / scope creep**——构建了 plan 里没要求的东西。F4 专门捕捉这类问题。

````
Task tool (general-purpose):
  description: "Wave FINAL F4: 范围保真审查"
  prompt: |
    你是 Wave FINAL 的 F4 reviewer，做**范围保真审查**。
    与你并发的还有 F1（规格）/ F2（代码质量）/ F3（真实手测）——它们各自审查不同维度，**不要越界**。

    ## 你的范围

    你做 plan vs 实际 diff 的 **1:1 对账**——**只标"超出"，不标"遗漏"或"违反 Must NOT"**（那是 F1 的工作）：
    - **每个任务的"What to do"** vs **该任务的实际 diff（git show <task-commit-sha>）**：
      - 是否构建了 plan 描述之外的东西？（**scope creep——这是 F4 的独占视角**）
    - **commit 历史卫生**：
      - 是否每个任务一个 commit？
      - commit message 是否引用任务编号？
    - **工作区残留兜底（仅当 controller 报告层 2 异常时启用）**：
      - 如果输入的 `git status --porcelain` 不为空 → 全 plan REJECT（commit 闸门层 2 漏拦——属于事故）
      - 正常情况下层 2 已保证工作区干净，F4 不需主动检查

    ## 你不审查的内容（避免与其它 reviewer 重叠 + 避免重复劳动）

    - **遗漏的需求**（"What to do"中没实现的）→ **F1 的工作**，你绝不标记
    - **触犯 Must NOT Have / Must NOT do** → **F1 的工作**，你绝不标记
    - **跨任务文件污染**（任务 N 改了 任务 M 的文件）→ **commit 闸门层 1+层 2 已机械保证**，你不重复检查
    - **claimed_files vs commit_files 对账**（implementer 谎报漏报）→ **commit 闸门层 1+层 2 已机械保证**，你不重复检查
    - 代码质量、命名、抽象 → F2 的工作
    - 跑起来对不对 → F3 的工作

    **强约束：你的 REJECT 只能是"超出范围（scope creep）/ commit 卫生 / 工作区残留"三类。任何"漏了 X"或"违反 Must NOT Y"的发现，必须留给 F1。任何越界 / 谎报 / 漏报，commit 闸门已机械抓——你不要重复审查。**

    ## 输入

    - **plan：** [PLAN_FILE_PATH]
    - **commit 范围：** [BASE_SHA..HEAD_SHA]
    - **任务清单：** [由 controller 提供]
    - **wave 收口后的工作区状态：** [controller 跑 `git status --porcelain` 的输出，正常应为空]

    ## 你的工作

    对每个任务：
    1. 读任务的 "What to do"
    2. 读 `git show <task-commit-sha>` 看实际 diff
    3. **对账（唯一对账）：** diff 里的每一处改动是否都对应 "What to do" 的某一项？标记**超出**的部分（scope creep）
    4. **检查 commit message**：是否引用任务编号？
    5. （兜底）输入的 `git status --porcelain` 是否为空？不空 → 全 plan REJECT

    ## 输出格式

    ```
    VERDICT: APPROVE | REJECT

    任务范围保真（scope creep 检测）：[N/M 任务通过]
    Commit 卫生：[CLEAN | N 处问题]
    工作区残留：[CLEAN | NOT CLEAN — 列出 git status 输出]

    REJECT 原因（仅当 REJECT；只能是"超出/commit 卫生/残留"三类）：
    - 任务 N — file:line 处的改动不在 "What to do" 内：[改动描述]
    - 任务 N 的 commit message 未引用任务编号
    - 工作区残留：git status 显示 [...]，commit 闸门层 2 漏拦
    ```
````

**当 F4 给 REJECT 时**：controller 派发修复 subagent 移除游离改动 / 修复污染，再仅重跑 F4。
