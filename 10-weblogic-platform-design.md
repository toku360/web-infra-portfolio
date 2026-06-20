# WebLogic Platform Design

## 1. 背景

現行構成は

Internet
↓
ALB
↓
Apache
↓
RDS

である。

業務処理層が存在しないため、
WebLogicを追加する。

---

## 2. 目的

Javaアプリケーション実行基盤を構築する。

---

## 3. システム構成

Internet
↓
ALB
↓
Apache
↓
WebLogic
↓
RDS

---

## 4. WebLogic採用理由

- Java EE実行基盤
- DataSource管理
- Connection Pool
- Transaction管理

---

## 5. 可用性方針

検証環境

Single構成

本番想定

Cluster構成

---


