# 01. リポジトリ設計書

## 1. 目的

本書は、web-infra-portfolio リポジトリの構成方針を定義するものです。

本リポジトリは、銀行系Webシステムを想定し、設計・構築・運用・変更管理・ロールバックまでを体系的に整理することを目的とします。

## 2. 基本方針

本リポジトリでは、学習メモではなく実務成果物として評価されることを重視します。

そのため、以下の方針で管理します。

| 方針 | 内容 |
|---|---|
| 再現性 | 手順に従えば同じ構成を再現できる |
| 説明性 | なぜその設計にしたか説明できる |
| 安全性 | 秘密情報をGit管理しない |
| 運用性 | 障害対応・変更管理を含める |
| 証跡性 | 作業結果をマスク済みで残す |

## 3. ディレクトリ構成

```text
web-infra-portfolio/
├ docs/
├ runbooks/
├ evidence/
├ diagrams/
├ maintenance/
└ terraform/
```

## 4. docs

設計書・運用設計・障害対応方針を格納します。

| ディレクトリ | 内容 |
|---|---|
| docs/design | 基本設計、詳細設計、環境設計 |
| docs/operations | 運用設計、監視設計、変更管理 |
| docs/security | セキュリティ方針 |
| docs/troubleshooting | 障害切り分け |

## 5. runbooks

日々の運用手順を格納します。

| ディレクトリ | 内容 |
|---|---|
| runbooks/linux | Linux運用 |
| runbooks/apache | Apache運用 |
| runbooks/weblogic | WebLogic運用 |
| runbooks/oracle | Oracle運用 |
| runbooks/aws | AWS運用 |

## 6. evidence

作業証跡を格納します。

証跡は必ずマスク済みとします。

格納例：

```text
evidence/apache/restart-2026-xx-xx.md
evidence/oracle/listener-check-2026-xx-xx.md
```

## 7. diagrams

構成図を格納します。

| ディレクトリ | 内容 |
|---|---|
| logical | 論理構成図 |
| physical | 物理構成図 |
| network | ネットワーク構成図 |

## 8. maintenance

パッチ適用やバージョンアップ手順を格納します。

| ディレクトリ | 内容 |
|---|---|
| os-patch | OSパッチ |
| apache-update | Apache更新 |
| jdk-update | JDK更新 |
| weblogic-patch | WebLogicパッチ |
| oracle-patch | Oracleパッチ |

## 9. terraform

AWS環境をコード管理します。

| ディレクトリ | 内容 |
|---|---|
| modules | 再利用可能なTerraform module |
| envs/dev | dev環境 |
| envs/prod | prod環境 |

## 10. 命名規則

Markdownファイルは以下の命名規則とします。

```text
番号-内容.md
```

例：

```text
01-basic-design.md
02-detail-design.md
03-operation-design.md
```

Runbookは以下の命名規則とします。

```text
対象-runbook.md
```

例：

```text
apache-runbook.md
oracle-runbook.md
```

## 11. Git管理方針

mainブランチを安定版とします。

作業時は以下のブランチ名を使用します。

```text
feature/add-linux-runbook
feature/add-apache-design
feature/add-oracle-runbook
```

## 12. 除外対象

以下はGit管理対象外です。

- 秘密鍵
- パスワード
- 証明書
- Terraform State
- 生ログ
- DBデータ
- 実案件情報



