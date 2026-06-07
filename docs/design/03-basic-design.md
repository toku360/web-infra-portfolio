# 基本設計書

---

# 1. 文書情報

| 項目 | 内容 |
|--------|--------|
| 文書名 | 基本設計書 |
| システム名 | Web Infrastructure Portfolio |
| 作成者 | toku360 |
| 作成日 | 2026-06-07 |
| バージョン | 1.0 |

---

# 2. システム概要

## 2.1 目的

本システムは銀行系Webシステムを想定した
運用・設計ポートフォリオである。

以下を学習・整理することを目的とする。

- Linux運用
- Apache運用
- WebLogic運用
- Oracle運用
- AWS基礎運用
- Terraform管理
- 障害対応
- 変更管理
- ロールバック

---

## 2.2 対象範囲

本設計書は以下を対象とする。

- インフラ
- ネットワーク
- Apache
- WebLogic
- Oracle
- AWS

アプリケーション設計は対象外とする。

---

# 3. システム構成

## 3.1 全体構成

```text
Client

↓

Apache

↓

WebLogic

↓

Oracle
```

---

## 3.2 構成概要

### Apache

役割

- HTTPS終端
- Reverse Proxy
- ログ出力

---

### WebLogic

役割

- Javaアプリケーション実行
- DataSource管理
- Connection Pool管理

---

### Oracle

役割

- データ保存
- SQL実行
- バックアップ

---

# 4. ネットワーク設計

## 4.1 通信一覧

| 送信元 | 宛先 | Port | 用途 |
|----------|----------|----------|----------|
| Client | Apache | 443 | HTTPS |
| Apache | WebLogic | 7001 | Proxy |
| WebLogic | Oracle | 1521 | JDBC |

---

## 4.2 セキュリティ方針

最小権限を原則とする。

不要な通信は許可しない。

---

# 5. サーバ設計

## 5.1 サーバ一覧

| サーバ | 役割 |
|----------|----------|
| Apache | Web |
| WebLogic | AP |
| Oracle | DB |

---

## 5.2 OS

Rocky Linux

---

# 6. 環境設計

## dev

目的

- 検証
- 障害演習

---

## prod

目的

- 本番想定
- 設計書作成

---

# 7. 運用設計概要

## 運用時間

24時間365日想定

---

## 監視

対象

- CPU
- Memory
- Disk
- Apache
- WebLogic
- Oracle

---

# 8. 障害対応方針

障害発生時は

1. 検知
2. 切り分け
3. 一次対応
4. 復旧
5. 再発防止

を実施する。

---

# 9. 変更管理方針

変更作業時は

- 手順書
- バックアップ
- ロールバック

を必須とする。

---

# 10. ロールバック方針

変更失敗時は

事前取得したバックアップを利用し
切り戻しを実施する。

---

# 11. バックアップ方針

対象

- Apache設定
- WebLogic設定
- Oracle設定
- Terraformコード

---

# 12. セキュリティ方針

Git管理対象外

- パスワード
- 秘密鍵
- 証明書
- Terraform State

---

# 13. 今後の拡張

将来的に以下を追加予定

- Oracle RAC
- WebLogic Cluster
- AWS構成
- Terraform構成

## AWS構成

VPC

Public Subnet

Private Subnet

Database Subnet

を利用する。




