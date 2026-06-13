# Maintenance Design

## 1. 文書情報

|項目|内容|
|---|---|
|文書名|Maintenance Design|
|システム名|web-infra-portfolio|
|対象環境|AWS|
|対象システム|Apache / WebLogic / Oracle(RDS)|
|版数|1.0|

---

# 2. 目的

本書はシステム保守運用の標準方針を定義する。

対象は以下とする。

- OSパッチ
- Apacheアップデート
- JDKアップデート
- WebLogic PSU適用
- Oracle RDSメンテナンス
- Terraformモジュール更新
- AWSサービス設定変更

---

# 3. 保守運用方針

保守作業は以下を必須とする。

- 事前確認
- バックアップ取得
- 作業実施
- 動作確認
- 証跡取得
- ロールバック準備

---

# 4. 保守対象一覧

|分類|対象|
|---|---|
|OS|Rocky Linux|
|Web|Apache|
|Java|OpenJDK|
|AP|WebLogic|
|DB|Oracle RDS|
|IaC|Terraform|
|AWS|ALB|
|AWS|Route53|
|AWS|Security Group|

---

# 5. 保守スケジュール

## 日次

- CloudWatch確認
- Alarm確認
- RDS Event確認

---

## 週次

- 容量確認
- エラーログ確認
- バックアップ確認

---

## 月次

- パッチ適用計画確認
- バージョン確認
- AWS Advisor確認

---

## 四半期

- JDK更新確認
- WebLogic PSU確認
- Terraform Module確認

---

# 6. OSパッチ適用

## 対象

Rocky Linux

---

## 事前確認

```bash
cat /etc/os-release

uname -r

df -h

systemctl status
```

---

## パッケージ確認

```bash
dnf check-update
```

---

## 適用

```bash
dnf update
```

---

## 再起動

```bash
reboot
```

---

## 確認

```bash
uname -r
```

---

# 7. Apacheアップデート

## 確認

```bash
httpd -v
```

---

## 設定バックアップ

```bash
cp -pr /etc/httpd /backup/httpd
```

---

## 更新

```bash
dnf update httpd
```

---

## 構文確認

```bash
httpd -t
```

---

## サービス確認

```bash
systemctl status httpd
```

---

# 8. JDKアップデート

## 確認

```bash
java -version
```

---

## バックアップ

JDKパス確認

---

## 更新

新バージョン適用

---

## 確認

```bash
java -version
```

---

# 9. WebLogic PSU適用

## 事前確認

- 現行バージョン確認
- JVM確認
- Datasource確認

---

## バックアップ

Domain Backup

---

## 適用

PSU適用

---

## 確認

- AdminServer
- ManagedServer
- Datasource

---

# 10. Oracle RDSメンテナンス

## 確認

RDS Version

---

## 自動適用確認

Maintenance Window

---

## バックアップ

Snapshot取得

---

## 適用後確認

- 接続確認
- Alert Log確認
- Event確認

---

# 11. Terraformモジュール更新

## 確認

```bash
terraform version
```

---

## 初期化

```bash
terraform init -upgrade
```

---

## 差分確認

```bash
terraform plan
```

---

## 適用

```bash
terraform apply
```

---

# 12. AWSサービス保守

対象

- Route53
- ALB
- Security Group
- CloudWatch
- SNS
- SSM

---

# 13. 変更管理

保守作業はChange Management Designに従う。

必須

- 変更要求
- 承認
- 証跡取得

---

# 14. 動作確認

## Apache

```bash
curl -I http://localhost
```

---

## WebLogic

ログイン確認

---

## Oracle

接続確認

---

## AWS

Health Check確認

---

# 15. ロールバック

## 実施条件

- サービス停止
- 接続不可
- エラー増加
- 性能劣化

---

## Apache

設定復元

---

## JDK

旧バージョン戻し

---

## WebLogic

Domain Backup復元

---

## Oracle RDS

Snapshot Restore

---

## Terraform

Git管理版へ戻す

---

# 16. 証跡取得

作業前

- バージョン
- サービス状態

---

作業後

- バージョン
- ログ
- 動作確認

---

# 17. セキュリティ

禁止事項

- 本番直接変更
- 承認なし変更
- 手順書なし変更

---

# 18. KPI

|項目|目標|
|---|---|
|保守成功率|100%|
|ロールバック成功率|100%|
|証跡取得率|100%|

---

# 19. 監査対応

監査対象

- Git履歴
- Pull Request
- CloudTrail
- 証跡

---

# 20. 将来拡張

- Blue/Green Deployment
- Patch Manager
- Systems Manager Automation
- WebLogic Cluster Maintenance
- Oracle Data Guard



