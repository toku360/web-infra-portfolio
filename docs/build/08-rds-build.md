# RDS Design

## 1. 文書情報

|項目|内容|
|---|---|
|システム名|web-infra-portfolio|
|対象環境|AWS dev|
|対象DB|Oracle RDS（本番想定）|
|検証DB|PostgreSQL RDS|
|版数|1.0|

---

# 2. 目的

本書はRDS設計方針を定義する。

本番環境ではOracle RDSを想定する。

学習環境ではコストを考慮しPostgreSQLを採用する。

---

# 3. システム構成

Internet

↓

ALB

↓

Apache EC2

↓

Oracle RDS

---

# 4. 設計方針

## 4.1 RDS採用理由

理由

- DB管理負荷削減
- 自動バックアップ
- Multi-AZ対応
- CloudWatch連携
- 高可用性

---

## 4.2 Oracle採用理由

銀行系システムで利用実績が多い。

- PL/SQL
- Data Guard
- RAC

など企業利用が多い。

---

## 4.3 PostgreSQL採用理由

学習環境コスト削減。

RDS設計自体は共通。

---

# 5. ネットワーク設計

## Subnet

Private DB Subnet

利用

外部公開しない。

---

# 6. Security Group

許可

Apache EC2

↓

RDS

5432

---

拒否

Internet

↓

RDS

禁止

---

# 7. バックアップ

保持期間

7日

---

スナップショット

変更前取得

---

# 8. 監視

CloudWatch

監視項目

- CPU
- FreeStorageSpace
- FreeableMemory
- DatabaseConnections

---

# 9. 障害対応

対応

- Snapshot復元
- Point In Time Recovery
- Multi-AZ切替

---

# 10. ロールバック

障害発生時

Snapshotから復元する。



