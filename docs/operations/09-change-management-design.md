# Change Management Design

## 1. 文書情報

|項目|内容|
|---|---|
|文書名|Change Management Design|
|システム名|web-infra-portfolio|
|対象環境|AWS|
|対象システム|Apache / WebLogic / Oracle(RDS)|
|版数|1.0|

---

# 2. 目的

本書は変更管理の標準手順を定義する。

対象は以下とする。

- Apache設定変更
- WebLogic設定変更
- Oracle(RDS)設定変更
- AWS構成変更
- OSパッチ適用
- ミドルウェア更新

変更による障害発生リスクを低減し、安全なリリースを実現することを目的とする。

---

# 3. 変更管理とは

変更管理とはシステム変更を統制し、

- 安全性
- 再現性
- 監査性

を確保する活動である。

---

# 4. 対象変更

## 通常変更

例

- Apache設定変更
- Security Group変更
- CloudWatch Alarm変更

---

## 緊急変更

例

- セキュリティインシデント対応
- サービス停止復旧
- 障害回避対応

---

# 5. 変更管理フロー

## Step1

変更要求

---

## Step2

影響調査

---

## Step3

レビュー

---

## Step4

承認

---

## Step5

実施

---

## Step6

確認

---

## Step7

完了報告

---

# 6. 変更要求書

最低記載項目

|項目|内容|
|---|---|
|変更内容|内容|
|理由|目的|
|影響範囲|対象|
|実施日時|日時|
|担当者|実施者|
|ロールバック|有無|

---

# 7. 影響調査

確認対象

- Apache
- WebLogic
- Oracle
- ALB
- Route53
- Security Group
- SSM

---

## 例

Apache設定変更

↓

WebLogic影響有無

↓

利用者影響有無

---

# 8. リスク評価

|レベル|説明|
|---|---|
|低|利用者影響なし|
|中|一部影響|
|高|サービス停止可能性|

---

# 9. 承認

## 低リスク

リーダー承認

---

## 中リスク

運用責任者承認

---

## 高リスク

CAB承認

---

# 10. 実施前確認

## Apache

```bash
systemctl status httpd

httpd -t
```

---

## WebLogic

起動状態確認

Datasource確認

---

## Oracle

接続確認

バックアップ確認

---

## AWS

CloudWatch正常

ALB正常

---

# 11. バックアップ

変更前に取得する。

対象

- Apache設定
- WebLogic設定
- Oracle Parameter
- Terraformコード

---

# 12. 実施手順

手順書に従う。

飛ばし作業禁止。

---

# 13. 実施後確認

確認対象

- Apache
- WebLogic
- Oracle
- ALB

---

## 利用者確認

疎通確認

業務確認

---

# 14. ロールバック設計

## 実施条件

- サービス停止
- 接続不可
- エラー増加
- 性能劣化

---

## Apache例

設定戻し

```bash
cp httpd.conf.bak httpd.conf
```

---

## AWS例

Terraform

```bash
terraform apply
```

前バージョン適用

---

## Oracle例

Parameter復元

再起動

---

# 15. 証跡取得

必須

- 作業前
- 作業中
- 作業後

---

## 保管場所

```text
evidence/
```

---

# 16. 障害時対応

1. 作業停止

2. 状況確認

3. ロールバック

4. 報告

---

# 17. 報告書

記載事項

- 作業内容
- 結果
- 障害有無
- ロールバック有無

---

# 18. AWS変更管理

対象

- Route53
- ALB
- EC2
- RDS Oracle
- Security Group
- IAM
- SSM

---

# 19. Terraform運用

変更はTerraform管理を原則とする。

手動変更禁止。

---

# 20. 監査対応

変更履歴を保持する。

対象

- Git履歴
- Pull Request
- 証跡
- CloudTrail

---

# 21. 品質基準

変更内容を第三者が再現可能であること。

---

# 22. 将来拡張

- CAB運用
- ServiceNow連携
- 自動承認ワークフロー
- Change Calendar



