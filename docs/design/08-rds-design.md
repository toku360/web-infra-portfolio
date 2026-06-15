# Oracle RDS Design

## 1. 目的

Oracle RDSを利用したデータベース基盤を構築する。

---

## 2. 構成

ALB

↓

Apache

↓

Oracle RDS

---

## 3. 採用理由

RDSを利用する理由

- バックアップ自動化
- CloudWatch統合
- パッチ管理
- 可用性向上

---

## 4. バックアップ

保持期間

7日

方式

Automated Backup

---

## 5. セキュリティ

Public Access

無効

接続元

Apache SGのみ

---

## 6. 可用性

本番

Multi-AZ

開発

Single-AZ

---

## 7. 監視

CPU

Storage

Connections

FreeMemory



