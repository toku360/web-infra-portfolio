# Monitoring Architecture Design

## 1. 文書情報

| 項目 | 内容 |
|---|---|
| 文書名 | Monitoring Architecture Design |
| システム名 | web-infra-portfolio |
| 対象環境 | AWS dev |
| 対象リージョン | ap-northeast-1 |
| 版数 | 1.0 |

---

## 2. 目的

本書は web-infra-portfolio における監視アーキテクチャを定義する。

本システムは、ALB、Apache EC2、PostgreSQL RDSで構成されるWeb三層構成である。

監視の目的は、障害を利用者からの申告で初めて把握するのではなく、CloudWatch Alarmにより早期に検知し、運用担当が迅速に一次対応できる状態を作ることである。

---

## 3. 対象システム構成

```text
Internet
  ↓
ALB
  ↓
Apache EC2
  ↓
PostgreSQL RDS
```

---

## 4. 監視設計方針
### 4.1 早期検知

障害発生後にユーザー申告で気付く運用は避ける。

CloudWatch Alarmにより、以下の異常を早期検知する。

- EC2障害
- ALB障害
- Target Group異常
- RDSリソース逼迫
- DB接続数増加

### 4.2 層別監視

Web三層構成では、どの層で異常が発生しているかを分けて監視する必要がある。

層	対象	主な監視項目
Web入口	ALB	5XX、応答時間
Web	Apache EC2	CPU、Status Check
DB	RDS	CPU、Storage、Connections

### 4.3 誤検知抑制

短時間の一時的な負荷で過剰通知しないよう、評価期間を設定する。

一方、EC2 Status CheckやHealthyHostCountなどサービス影響に直結する項目は短い周期で検知する。

## 5. 監視項目一覧

分類	メトリクス	閾値	重要度	対応
EC2	CPUUtilization	70%以上	Warning	プロセス確認
EC2	StatusCheckFailed	1以上	Critical	EC2状態確認
ALB	HTTPCode_ELB_5XX_Count	1以上	Critical	ALB/Target確認
ALB	TargetResponseTime	2秒以上	Warning	Apache/RDS遅延確認
Target Group	HealthyHostCount	1未満	Critical	Apache確認
RDS	CPUUtilization	70%以上	Warning	SQL/接続数確認
RDS	FreeStorageSpace	5GB未満	Critical	容量拡張検討
RDS	DatabaseConnections	50以上	Warning	接続元確認

## 6. 通知設計

通知はSNS Topicへ集約する。

dev環境ではSNS Topic作成までを行う。

本番想定では以下へ連携する。

- メール
- Teams
- Slack
- ServiceNow
- 監視運用センター

## 7. EC2監視設計

### 7.1 CPUUtilization

CPU使用率が継続して高い場合、Apacheプロセス、OSプロセス、異常アクセスを確認する。

### 7.2 StatusCheckFailed

EC2の基盤障害またはOS応答不能を示す可能性があるため、Criticalとして扱う。

## 8. ALB監視設計

### 8.1 HTTPCode_ELB_5XX_Count

ALBが5XXを返す場合、Target不在、Listener設定不備、Target Group異常などが考えられる。

### 8.2 TargetResponseTime

応答時間が遅い場合、Apache処理遅延、DB遅延、ネットワーク遅延を疑う。

## 9. Target Group監視設計

HealthyHostCountが0の場合、ALB配下に正常なターゲットが存在しない。

ユーザー影響が出る可能性が高いため、Criticalとして扱う。

## 10. RDS監視設計

### 10.1 CPUUtilization

RDS CPU高騰時は、SQL負荷、接続数増加、バッチ処理、ロック待ちを確認する。

### 10.2 FreeStorageSpace

ストレージ枯渇はDB停止につながるため、早期検知が必要である。

### 10.3 DatabaseConnections

接続数増加はアプリケーション側のConnection Pool枯渇、異常リトライ、接続リークの兆候となる。

## 11. 障害検知から一次対応までの流れ

CloudWatch Alarm
  ↓
SNS通知
  ↓
一次切り分け
  ↓
影響範囲確認
  ↓
暫定対応
  ↓
恒久対応
  ↓
報告


## 12. 運用リーダー観点

運用リーダーは、単にAlarmを受け取るだけでなく、以下を判断する。

- ユーザー影響の有無
- 暫定対応の要否
- エスカレーション要否
- 顧客報告要否
- 恒久対応の優先順位


## 13. 今後の改善

- CloudWatch Logs収集
- Apache error_log監視
- RDS拡張監視
- SNSメール購読
- Teams通知連携
- ServiceNow連携
- ダッシュボード作成


