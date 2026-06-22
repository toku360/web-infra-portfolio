# Web Infrastructure & Operations Portfolio

## 概要

本リポジトリは、AWS・Linux・Apache・RDS・WebLogic・Ansible を用いたインフラ設計・構築・運用を学習します。　
単なる構築手順ではなく、運用設計・変更管理・脆弱性管理・バックアップ運用・監査対応・災害対策までを含めた実践的な内容を目指しています。

---

# 想定ロール

* Linux運用エンジニア
* AWS運用エンジニア
* 基盤運用設計担当

---

# 技術スタック

## クラウド

* AWS
* EC2
* ALB
* RDS
* CloudWatch
* Systems Manager (SSM)

## IaC

* Terraform

## OS

* Rocky Linux 9
* RHEL系運用

## Web

* Apache HTTP Server

## Middleware

* PostgreSQL(Oracle RDSは高額のため代用)
* WebLogic

## 自動化

* Ansible
* AWS CLI
* SSM Run Command

---

# 構築環境

## AWS

* VPC
* Public Subnet
* Private Subnet
* Security Group
* ALB
* EC2
* RDS

## OS

* Rocky Linux 9

## 管理方式

* AWS Systems Manager
* Session Manager
* Run Command

---

# 実施内容

## Phase1 AWS基盤構築

### Network

* VPC設計
* Public / Private Subnet設計
* Route Table設計
* Internet Gateway設計

### Security

* Security Group設計
* 通信制御設計

### ALB

* Target Group
* Health Check
* Listener設計

### EC2

* Rocky Linux構築
* Apache導入
* SSM接続

### RDS

* RDS構築
* Backup設定確認
* 接続設計

---

## Phase2 運用監視

### CloudWatch

* EC2 CPU監視
* EC2 Status Check監視
* ALB監視
* RDS監視

成果物：

* CloudWatch Alarm設計書
* 監視設計書
* 障害対応手順書

---

## Phase3 WebLogic基盤

### WebLogicサーバ設計

実施内容

* WebLogicサーバ設計
* Domain設計
* JVM設計
* JDBC設計
* Oracle接続設計

成果物

* Domain Design
* JDBC Design
* Oracle Connectivity Design

---

## Phase4 自動化

### Ansible

実施内容

* サーバ情報収集
* SSM連携
* 証跡取得自動化

成果物

* gather-info.yml
* Patch Operation Automation
* Runbook

---

## Phase5 パッチ運用管理

### 実施内容

* SSM Run Command
* Patch確認
* Patch適用
* 事前証跡取得
* 事後証跡取得
* 再起動要否判定

確認コマンド例

```bash
dnf check-update
dnf update -y
needs-restarting -r
rpm -q kernel
uname -r
```

成果物

* Patch Operation Design
* Change Plan
* Execution Record
* Result Report
* Rollback Plan

---

## Phase6 バックアップ運用

### 実施内容

* EBS Snapshot取得
* Snapshot確認
* RDS Backup確認
* Restore設計
* DR設計

確認コマンド例

```bash
aws ec2 create-snapshot

aws ec2 describe-snapshots

aws rds describe-db-instances
```

成果物

* Backup Operation Design
* Restore Runbook
* DR Design
* Validation Report

---

## Phase7 脆弱性管理

### 実施内容

* 脆弱性評価
* CVSS評価
* 是正計画
* Change Request
* Remediation Report

確認コマンド例

```bash
rpm -qa | grep openssl

rpm -qa | grep glibc

rpm -qa | grep curl
```

成果物

* Vulnerability Assessment Report
* Remediation Plan
* Change Request
* Result Report

---

## Phase8 コンフィグ評価

### 実施内容

* CIS準拠評価
* SSH設定評価
* Password Policy評価
* Firewall評価

確認コマンド例

```bash
sshd -T

cat /etc/login.defs

ss -tulpn
```

成果物

* CIS Assessment Report
* Config Review Runbook
* Change Request
* Remediation Plan

---

# 運用設計・運用リーダー視点

本ポートフォリオでは、単なる構築だけでなく以下を重視しています。

* 変更管理
* 証跡管理
* 脆弱性管理
* バックアップ管理
* リストア設計
* 災害対策
* 監査対応
* Runbook整備

---

# 今後の実施予定

* SOX監査対応
* ID棚卸
* CAB変更管理
* 障害対応演習
* 災害対策訓練
* WebLogic運用
* Ansible運用自動化拡張

---

