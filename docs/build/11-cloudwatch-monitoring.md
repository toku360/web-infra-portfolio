# CloudWatch Monitoring Build

## 1. 文書情報

| 項目 | 内容 |
|---|---|
| 文書名 | CloudWatch Monitoring Build |
| システム名 | web-infra-portfolio |
| 対象環境 | AWS dev |
| 対象リージョン | ap-northeast-1 |
| 版数 | 1.0 |

---

## 2. 目的

本書はCloudWatch AlarmおよびSNS Topicの構築手順と確認結果を記録する。

対象は以下である。

- Apache EC2
- ALB
- Target Group
- PostgreSQL RDS

---

## 3. 構築対象

| リソース | 用途 |
|---|---|
| SNS Topic | Alarm通知先 |
| EC2 CPU Alarm | CPU高騰検知 |
| EC2 StatusCheck Alarm | EC2異常検知 |
| ALB 5XX Alarm | ALB異常検知 |
| ALB TargetResponseTime Alarm | 応答遅延検知 |
| Target HealthyHostCount Alarm | Target異常検知 |
| RDS CPU Alarm | DB CPU高騰検知 |
| RDS FreeStorageSpace Alarm | DB容量逼迫検知 |
| RDS DatabaseConnections Alarm | DB接続数増加検知 |

---

## 4. Terraform変更概要

### CloudWatch module

```text
terraform/modules/cloudwatch/
├ main.tf
├ variables.tf
└ outputs.tf
```



