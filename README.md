# Skills 收集仓库

我工作与生活中使用的 AI Agent Skills 集合。每个 skill 是一个自包含目录，复制到任意 Agent 的 skills 目录即可使用。

---

## 📂 目录结构

```
skills-collection/
├── 📥 [inbox/](inbox/)              ← 新 skill 先放这里，让 AI 帮你归类
├── 💼 [work/](work/_index.md)       ← 工作相关
├── 🏠 [life/](life/_index.md)       ← 生活相关
├── 🔧 [meta/](meta/_index.md)       ← 管理 skills 本身的 skills
└── 📋 [templates/](templates/)      ← 新建 skill / 分类的模板
```

---

## 💼 工作 — [work/](work/_index.md)

与职业工作相关的技能，按领域细分。

| 分类 | 说明 |
|---|---|
| [dev/](work/dev/_index.md) | 软件开发：编码、调试、代码审查、重构 |
| [ops/](work/ops/_index.md) | 运维 & DevOps：部署、监控、CI/CD |
| [pm/](work/pm/_index.md) | 项目管理：需求分析、进度跟踪、沟通 |
| [writing/](work/writing/_index.md) | 写作 & 文档：技术文档、方案、邮件 |
| [data/](work/data/_index.md) | 数据分析：SQL、报表、数据清洗 |
| [general/](work/general/_index.md) | 通用工作类（不适合细分的放这里） |

---

## 🏠 生活 — [life/](life/_index.md)

与个人生活相关的技能，按场景细分。

| 分类 | 说明 |
|---|---|
| [health/](life/health/_index.md) | 健康：饮食、运动、睡眠 |
| [finance/](life/finance/_index.md) | 理财：记账、投资、税务 |
| [learning/](life/learning/_index.md) | 学习：读书笔记、课程规划、知识整理 |
| [travel/](life/travel/_index.md) | 出行：行程规划、攻略、打包清单 |
| [home/](life/home/_index.md) | 家居：收纳、清洁、装修 |
| [general/](life/general/_index.md) | 通用生活类（不适合细分的放这里） |

---

## 🔧 元技能 — [meta/](meta/_index.md)

管理这个 skills 仓库本身的技能。

| 分类 | 说明 |
|---|---|
| [classify-skill/](meta/classify-skill/) | 分析一个新 skill 并建议归类 |
| [generate-index/](meta/generate-index/) | 自动生成 `.skills-registry.yaml` 索引 |

---

## 📋 模板 — [templates/](templates/)

| 模板 | 用途 |
|---|---|
| [skill-template/](templates/skill-template/) | 新建一个 skill 的标准模板 |
| [category-template/](templates/category-template/) | 新建一个分类目录的标准模板 |

---

## 使用方式

### 添加新 Skill

```
1. 把新 skill 目录放入 inbox/
2. 让 AI 分析：读取 inbox 下的 skill 和各分类的 _index.md
3. AI 建议归类 → 确认 → 移动到对应目录
4. AI 自动更新 .skills-registry.yaml
```

### 使用已有 Skill

```
1. 在 .skills-registry.yaml 或对应目录下找到需要的 skill
2. 复制整个 skill 目录到目标 Agent 的 skills 目录
3. 在 Agent 中调用
```

### 扩展分类

当某个子目录下 skill 超过 **5~8 个**，考虑拆分子目录。参照 [templates/category-template/](templates/category-template/) 创建。

---

## 命名规范

| 项目 | 规范 | 示例 |
|---|---|---|
| 目录名 | 英文小写 + 连字符 | `code-review/` |
| Skill 目录 | 动词/名词，描述功能 | `refactoring/`, `travel-planner/` |
| 分类目录 | 名词，描述领域 | `dev/`, `health/` |
| 元文件 | 下划线前缀 | `_index.md` |

---

## 索引

详细的 skill 列表见 [.skills-registry.yaml](.skills-registry.yaml)，该文件由 AI 自动维护。
