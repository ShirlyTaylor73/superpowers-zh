# Wave FINAL · F2 代码质量审查 prompt 模板

派发 F2 reviewer 时使用此模板。F2 与 F1/F3/F4 并发派发，关注点**互不重叠**。

**F2 关注点（独占）：** 跨任务的**全局**代码质量——只看一个任务的代码看不出"质量好不好"，必须横向比较才有判断。

```
Task tool (superpowers:code-reviewer):
  description: "Wave FINAL F2: 跨任务代码质量审查"

  使用模板 requesting-code-review/code-reviewer.md，附加以下 F2 专属指令：

  ## 你的范围

  你审查整个 plan 实现的**跨任务代码质量**——**只看任务间的关系，不看单文件级问题**（单文件级 AI slop / 残留由 task-local spec-reviewer 在每任务收口时顺手抓）：
  - 命名一致性（不同任务的同类对象是否用了不同名字？例如任务 3 叫 `clearLayers()` 但任务 7 叫 `clearFullLayers()`）
  - 跨任务重复代码（多个任务实现了同样的工具函数 / 同样的 try-catch 模式）
  - 抽象层级一致性（有的任务直接操作底层 API、有的封装得很重）
  - 跨任务过度抽象（为了将来"可能"的扩展加了用不上的接口层）

  ## 你不审查的内容（避免与其它 reviewer 重叠）

  - 单个任务是否实现了规格 → 这是 task-local spec-reviewer 的工作
  - 全 plan 的需求覆盖 → F1 的工作
  - 跑起来对不对 → F3 的工作
  - 是否构建了规格外的东西 → F4 的工作

  ## 文件级质量检查（沿用原 code-quality-reviewer 的标准）

  - 每个文件是否有单一明确的职责和定义清晰的接口？
  - 各单元是否拆分得足以独立理解和测试？
  - 实现是否遵循了 plan 中的文件结构？
  - 本次实现是否创建了已经很大的新文件，或显著增大了现有文件？（不要标记已有的文件大小问题——聚焦于本次变更带来的影响。）

  ## 输入

  - **plan：** [PLAN_FILE_PATH]
  - **commit 范围：** [BASE_SHA..HEAD_SHA]
  - **任务清单（含每任务文件集）：** [由 controller 提供]

  ## 输出格式

  ```
  VERDICT: APPROVE | REJECT

  优点：[最多 3 条]

  问题（按严重度）：
  - 关键：[file:line — 描述]
  - 重要：[file:line — 描述]
  - 次要：[file:line — 描述]

  跨任务一致性问题：
  - [描述跨任务的命名/抽象/重复问题]
  ```
```

**当 F2 给 REJECT 时**：仅修关键和重要级别的问题。次要建议可以记录但不阻断。修完后仅重跑 F2。
