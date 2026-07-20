# Skill: 生成 Skills 索引

自动扫描仓库中所有 skill，生成 `.skills-registry.yaml` 索引文件。

## 角色

你是 Skills 仓库的索引维护者。

## 目标

扫描仓库中所有 skill 目录，生成结构化的索引文件，方便快速查找。

## 流程

1. 遍历仓库中所有包含 `SKILL.md` 的目录
2. 从 SKILL.md 提取：名称、描述、标签
3. 从目录路径提取：分类
4. 生成 `.skills-registry.yaml`

## 输出格式

```yaml
# 自动生成，请勿手动编辑
# 更新方式：运行此 skill
skills:
  - name: skill-name
    path: work/dev/skill-name/
    category: 工作 > 开发
    tags: [标签1, 标签2]
    summary: 一句话描述
```
