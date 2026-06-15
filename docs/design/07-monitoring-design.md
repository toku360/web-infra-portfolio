# Monitoring Design

## 1. 目的

本書は web-infra-portfolio における監視設計を定義する。

対象

- AWS ALB
- Apache EC2
- Target Group

---

## 2. 監視方針

障害発生後に検知するのではなく、

障害予兆を検知する。

---

## 3. 監視対象

|区分|監視項目|
|---|---|
|EC2|CPU使用率|
|EC2|StatusCheckFailed|
|ALB|HTTPCode_ELB_5XX|
|ALB|TargetResponseTime|
|Target Group|HealthyHostCount|

---

## 4. 閾値

### CPU

警告

70%

重大

90%

---

### Status Check

1回でも失敗

重大

---

### ALB 5xx

1以上

重大

---

### Healthy Host

0

重大

---

## 5. 通知

通知先

SNS

本番では

- Teams
- Slack
- メール

を利用する。

---

## 6. 障害検知フロー

EC2停止

↓

StatusCheckFailed

↓

CloudWatch Alarm

↓

SNS通知

↓

運用担当確認

---

## 7. ロールバック

誤検知時

CloudWatch Alarm無効化

SNS通知停止



