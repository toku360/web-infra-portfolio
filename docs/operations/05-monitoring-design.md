# Monitoring Design

## 1. 文書情報

|項目|内容|
|---|---|
|文書名|Monitoring Design|
|システム名|web-infra-portfolio|
|対象環境|AWS|
|対象システム|Apache / WebLogic / Oracle(RDS)|
|版数|1.0|

---

# 2. 目的

本書はシステム監視設計を定義する。

対象システムはAWS上で稼働する以下とする。

- Apache EC2
- WebLogic EC2
- Oracle RDS
- ALB
- VPC
- Systems Manager

本設計の目的は以下である。

- 障害の早期発見
- 障害影響の最小化
- 可用性向上
- 運用負荷軽減

---

# 3. システム構成

User

↓

Route53

↓

ALB

↓

Apache EC2

↓

WebLogic EC2

↓

Oracle RDS

---

# 4. 採用サービス

|サービス|用途|
|---|---|
|CloudWatch|監視|
|CloudWatch Logs|ログ収集|
|SNS|通知|
|SSM|運用管理|
|S3|ログ保管|
|RDS Monitoring|DB監視|

---

# 5. 監視対象一覧

|分類|対象|
|---|---|
|OS|CPU|
|OS|Memory|
|OS|Disk|
|OS|Load Average|
|Apache|サービス状態|
|Apache|Error Log|
|WebLogic|Managed Server|
|WebLogic|Datasource|
|WebLogic|JVM Heap|
|Oracle|CPU|
|Oracle|Storage|
|Oracle|Connection|
|Oracle|Backup|
|ALB|Health Check|
|ALB|5xx Error|

---

# 6. CPU監視

## 対象

Apache EC2

WebLogic EC2

Oracle RDS

---

## 閾値

|状態|値|
|---|---|
|正常|70%未満|
|警告|80%以上|
|重大|90%以上|

---

## 通知

SNS通知

---

# 7. Memory監視

## 対象

Apache

WebLogic

---

## 閾値

|状態|値|
|---|---|
|正常|70%未満|
|警告|80%以上|
|重大|90%以上|

---

# 8. Disk監視

## 対象

EC2

---

## 閾値

|状態|値|
|---|---|
|正常|70%未満|
|警告|80%以上|
|重大|90%以上|

---

# 9. Apache監視

## サービス監視

対象

httpd

---

## ログ監視

対象

error_log

---

## 監視内容

- サービス停止
- Error増加
- Port Listen異常

---

# 10. WebLogic監視

## Managed Server

監視

- 起動状態

---

## Datasource

監視

- Connection取得失敗

---

## JVM

監視

- Heap使用率

---

## ログ

対象

AdminServer.log

ManagedServer.log

---

# 11. Oracle(RDS)監視

## CPU

CloudWatch

---

## Storage

CloudWatch

---

## Connection数

CloudWatch

---

## Backup

自動バックアップ監視

---

## Event

RDS Event監視

---

# 12. ALB監視

## Health Check

監視

Target Group

---

## エラー監視

対象

4xx

5xx

---

## レイテンシ

監視

Response Time

---

# 13. CloudWatch Logs

## Apache

収集対象

/var/log/httpd

---

## WebLogic

収集対象

AdminServer.log

ManagedServer.log

---

# 14. SNS通知設計

## 通知先

運用担当

---

## 通知対象

- CPU異常
- Memory異常
- Disk異常
- ALB異常
- RDS異常

---

# 15. SSM設計

## Session Manager

利用

理由

- Bastion不要
- 監査容易

---

## Run Command

利用

- 状態確認
- ログ取得

---

# 16. 障害対応フロー

1. CloudWatch検知

2. SNS通知

3. 一次調査

4. エスカレーション

5. 復旧

6. 報告

---

# 17. 証跡取得

取得対象

- CloudWatch Alarm
- CloudWatch Metrics
- RDS Event
- SSM実行結果

---

保管先

evidence/aws/

---

# 18. ロールバック

監視設定変更時

変更前

- Alarm Export
- 設定保存

変更後

- 通知確認

障害発生時

- 設定復元

---

# 19. 運用

## 日次

Alarm確認

---

## 週次

メトリクス確認

---

## 月次

閾値見直し

---

# 20. 将来拡張

- Grafana
- OpenSearch
- SIEM
- Security Hub
- GuardDuty



