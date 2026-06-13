# web-infra-portfolio

## 概要

銀行系システムを想定した
Apache + WebLogic + Oracle 構成の運用・設計ポートフォリオです。

## 目的

- Linux運用設計
- Apache運用設計
- Oracle運用設計
- WebLogic運用設計
- AWS基礎運用
- Terraformによる環境管理
- 変更管理
- ロールバック設計

## 想定構成

Internet

↓


Apache

↓

WebLogic

↓

Oracle

## 環境

### dev

検証環境

### prod

本番想定環境

## 今後作成予定

- 基本設計書
- 詳細設計書
- 運用設計書
- 監視設計書
- Runbook
- 障害対応手順
- ロールバック手順


# web-infra-portfolio

## 概要

本リポジトリは、銀行系Webシステムを想定したインフラ運用・設計ポートフォリオです。

Apache、WebLogic、Oracleを中心とした三層構成を題材に、設計・構築・運用・障害対応・変更管理・メンテナンス・ロールバックまでを体系的に整理します。

## 目的

このポートフォリオの目的は、単なる学習記録ではなく、以下を示すことです。

- Linuxサーバの運用設計ができること
- Apacheの構成・障害対応を理解していること
- WebLogicの基本構成・DataSource・Connection Poolを説明できること
- Oracleの接続構成・障害切り分けを理解していること
- AWS上の基本的なネットワーク・サーバ構成を説明できること
- Terraformでdev/prod環境を分けて管理できること
- 変更管理・ロールバック・メンテナンス手順を文書化できること
- 証跡を整理し、運用リーダーとして説明できること

## 想定システム構成

```text
Client
  |
  | HTTPS
  v
Apache
  |
  | HTTP / AJP / Proxy
  v
WebLogic
  |
  | JDBC
  v
Oracle
```

## 想定環境

### dev環境

検証・学習・障害演習を行う環境です。

- 構成変更の検証
- パッチ適用演習
- 障害再現
- ロールバック演習

### prod環境

本番想定の設計・手順化を行う環境です。

- 安定稼働を前提
- 変更前レビュー必須
- 作業前バックアップ必須
- ロールバック手順必須
- 証跡取得必須

## リポジトリ構成

```text
web-infra-portfolio/
├ README.md
├ docs/
│  ├ design/
│  ├ operations/
│  ├ security/
│  └ troubleshooting/
├ runbooks/
│  ├ linux/
│  ├ apache/
│  ├ weblogic/
│  ├ oracle/
│  └ aws/
├ evidence/
│  ├ linux/
│  ├ apache/
│  ├ weblogic/
│  ├ oracle/
│  ├ aws/
│  └ maintenance/
├ diagrams/
│  ├ logical/
│  ├ physical/
│  └ network/
├ maintenance/
│  ├ os-patch/
│  ├ apache-update/
│  ├ jdk-update/
│  ├ weblogic-patch/
│  └ oracle-patch/
└ terraform/
   ├ modules/
   └ envs/
      ├ dev/
      └ prod/
```

## セキュリティ方針

本リポジトリでは、実案件情報・秘密情報・顧客情報を扱いません。

以下はGit管理対象外とします。

- パスワード
- 秘密鍵
- 証明書
- Terraform State
- 実IPアドレス
- 顧客名
- 実ホスト名
- 生ログ

## 成果物

| 分類 | 内容 |
|---|---|
| 設計書 | 基本設計、詳細設計、運用設計、監視設計 |
| Runbook | Linux、Apache、WebLogic、Oracle、AWS |
| 変更管理 | パッチ適用、設定変更、ロールバック |
| 証跡 | コマンド結果、検証結果、マスク済みログ |
| Terraform | dev/prod環境の構成管理 |

## このポートフォリオで示すスキル

- Linux運用
- Apache運用
- WebLogic運用
- Oracle運用
- AWS基礎運用
- Terraform基礎
- 変更管理
- 障害対応
- ロールバック
- 設計書作成
- 運用リーダー視点


# Linux運用設計

作成済み設計書

- Linux Operation Design

対応範囲

- サービス管理
- 監視
- ログ管理
- 容量管理
- セキュリティ
- バックアップ
- 障害対応
- 変更管理
- ロールバック

# Linux運用設計

- Linux Operation Design
- LVM Capacity Management Design

## 対応範囲

- 容量管理
- LVM
- Filesystem拡張
- 運用設計
- ロールバック

- Linux Operation Design
- LVM Capacity Management Design
- NFS Operation Design

## 対応範囲

- NFS
- 共有ストレージ
- マウント管理
- 容量管理
- 障害対応
- ロールバック


# Linux運用設計

- Linux Operation Design
- LVM Capacity Management Design
- NFS Operation Design
- Pacemaker High Availability Design

## 対応範囲

- HAクラスタ
- Pacemaker
- Corosync
- フェイルオーバー
- フェイルバック
- STONITH





