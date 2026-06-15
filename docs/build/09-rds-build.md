# PostgreSQL RDS Build

## 1. 文書情報

|項目|内容|
|---|---|
|システム名|web-infra-portfolio|
|対象環境|AWS dev|
|対象DB|PostgreSQL RDS|
|本番想定|Oracle RDS|
|版数|1.0|

---

# 2. 目的

本書はRDS構築手順および確認結果を記録する。

本番環境ではOracle RDSを想定するが、学習環境ではコストを考慮しPostgreSQL RDSを採用した。

---

# 3. システム構成

Internet

↓

ALB

↓

Apache EC2

↓

PostgreSQL RDS

---

# 4. 構築内容

## DB Engine

PostgreSQL

Version 16

---

## Instance Class

db.t3.micro

---

## Storage

20GB

gp3

暗号化有効

---

## Backup

保持期間

7日

---

## Network

Private DB Subnet

利用

外部公開禁止

---

# 5. Security Group

許可

Apache EC2

↓

PostgreSQL

5432

---

禁止

Internet

↓

RDS

直接接続

---

# 6. Terraform実施

```bash
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

---

# 7. 確認

```bash
aws rds describe-db-instances
```

---

確認項目

|項目|期待値|
|---|---|
|Status|available|
|Public Access|false|
|Backup|7日|
|Port|5432|

---

# 8. 運用設計

監視項目

- CPUUtilization
- FreeStorageSpace
- DatabaseConnections
- FreeableMemory

---

# 9. バックアップ

自動バックアップ

7日

---

Snapshot

変更前取得

---

# 10. 障害対応

障害発生

↓

Snapshot確認

↓

RDS復元

↓

接続確認

---

# 11. ロールバック

問題発生時

Terraform destroy

または

Snapshot復元

---

# 12. 学習ポイント

RDSは単なるDBサーバではない。

設計対象は

- Security Group
- Backup
- Monitoring
- Subnet Group
- 可用性

まで含まれる。



