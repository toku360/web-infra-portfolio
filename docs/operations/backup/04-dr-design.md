
---

# docs/operations/backup/04-dr-design.md

```markdown
# Disaster Recovery Design

## 想定障害

- AZ障害
- Snapshot破損
- OS破損
- ランサムウェア
- 誤操作

---

## RTO

4時間

---

## RPO

24時間

---

## 復旧方式

### レベル1

Snapshot復旧

### レベル2

AMI復旧

### レベル3

Terraform再構築

---

## 運用責任

運用担当
↓
運用リーダー
↓
顧客報告



