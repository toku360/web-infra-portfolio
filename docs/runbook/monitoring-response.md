# Monitoring Response Runbook

## 1. 目的

本書はCloudWatch Alarm発報時の一次対応手順を定義する。

---

## 2. 対象Alarm

| Alarm | 対応 |
|---|---|
| EC2 CPU High | EC2負荷確認 |
| EC2 StatusCheckFailed | EC2基盤/OS確認 |
| ALB 5XX | ALB/Target確認 |
| Target HealthyHostCount Low | Apache確認 |
| RDS CPU High | DB負荷確認 |
| RDS FreeStorage Low | 容量確認 |
| RDS DatabaseConnections High | 接続数確認 |

---

## 3. 共通初動

1. 発報時刻を確認する
2. 対象リソースを確認する
3. ユーザー影響を確認する
4. 直近変更作業の有無を確認する
5. 一次切り分けを行う
6. 必要に応じてエスカレーションする

---

## 4. ALB 5XX対応

### 4.1 確認

```bash
aws elbv2 describe-load-balancers
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw apache_target_group_arn)
```

### 4.2 判断

Targetがunhealthyの場合、Apache EC2を確認する。

### 4.3 復旧候補
- Apache再起動
- EC2再起動
- ecurity Group確認
- 直近変更の切り戻し

## 5. Target HealthyHostCount Low対応

### 5.1 確認
aws elbv2 describe-target-health \
  --target-group-arn $(terraform output -raw apache_target_group_arn)

### 5.2 判断

HealthyHostCountが0の場合、利用者影響が発生する可能性が高い。

### 5.3 対応

- EC2状態確認
- Apache起動確認
- ALB Health Check確認
- Security Group確認

## 6. EC2 CPU High対応
### 6.1 確認
aws cloudwatch get-metric-statistics

### 6.2 判断

一時的なCPU上昇か、継続的な高負荷かを判断する。

### 6.3 対応
- アクセス増加確認
- Apacheログ確認
- プロセス確認
- スケールアウト検討

## 7. EC2 StatusCheckFailed対応

### 7.1 判断
Status Check失敗はEC2基盤またはOS応答不能の可能性がある。

### 7.2 対応
- EC2停止/起動
- 別AZへの再作成
- Snapshotから復旧

## 8. RDS CPU High対応

### 8.1 確認
aws rds describe-db-instances

### 8.2 判断

SQL負荷、接続数増加、アプリケーション側リトライを確認する。

### 8.3 対応
- 接続数確認
- スロークエリ確認
- インスタンスサイズ変更検討
- アプリ側Connection Pool確認

## 9. RDS FreeStorage Low対応
### 9.1 判断

DBストレージ逼迫は障害につながるためCriticalとして扱う。

### 9.2 対応
- 不要データ確認
- Auto Scaling Storage確認
- ストレージ拡張
- バックアップ方針確認

## 10. RDS DatabaseConnections High対応
### 10.1 判断

接続数増加は以下の兆候である可能性がある。

- Connection Leak
- 異常リトライ
- アクセス増加
- DB応答遅延

### 10.2 対応
- アプリケーション接続設定確認
- Connection Pool確認
- RDS負荷確認
- 直近リリース確認

## 11. 報告テンプレート
発生時刻：
検知方法：
対象リソース：
影響範囲：
一次原因：
暫定対応：
恒久対応：
次回アクション：


