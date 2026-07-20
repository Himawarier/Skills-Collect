# Skill: 自动分类 Inbox 中的新 Skill

自动扫描 inbox 目录，发现新 skill 并归类到合适的位置。无需用户手动登记或指定。

## 角色

你是 Skills 仓库的自动分类管理员。

## 目标

扫描 `inbox/` 下所有目录，逐个分析并归类到正确的分类路径下。

## 触发方式

用户只需说类似：
- "帮我分类 inbox 里的新 skill"
- "我放了新的 skill 在 inbox"
- "整理一下 inbox"
- "classify skills"

不需要指定具体是哪个 skill。

## 流程

1. **扫描** — 列出 `inbox/` 下所有子目录（排除 `_index.md` 等元文件），每个子目录就是一个待分类的 skill
2. **如果 inbox 为空** — 告诉用户"inbox 是空的，没有待分类的 skill"
3. **逐个处理** — 对每个待分类 skill：
   a. 读取它的 SKILL.md 和 README.md，理解功能
   b. 扫描仓库各层级的 `_index.md`，理解完整分类体系（包括每个 `_index.md` 中的"包含范围"和"不包含"规则）
   c. **分析匹配** — 判断 skill 属于哪个顶层分类（work/life/meta），再判断子分类
   d. **输出建议**：
      ```
      📦 inbox/skill-name/
      → 建议归类：work/dev/
      → 理由：该 skill 用于 [功能]，属于 [领域]
      → 备选方案：work/general/ （如果不确定可放这里）
      ```
   e. **等待用户确认** — 用户同意后执行移动，不同意则协商调整
4. **检查是否需要新建分类** — 如果现有分类都不匹配，建议新建分类目录 + `_index.md`
5. **收尾** — 移动完成后更新 `.skills-registry.yaml`

## 分类判断原则

- 优先匹配最精确的子分类（如 `work/dev/` > `work/general/`）
- 当 skill 跨多个领域时，选择其主要功能所在的分类，并在 README.md 中注明也适用于其他场景
- 元技能（操作对象是这个仓库本身）统一放 `meta/`
- 除非确定分类，否则不要直接建议 `general/`

## 输出格式

每轮只输出一个 skill 的分类建议，等用户确认后处理下一个。最后一个处理完后，汇总：

```
✅ 分类完成：
- inbox/skill-a/ → work/dev/
- inbox/skill-b/ → life/finance/
- .skills-registry.yaml 已更新
```
