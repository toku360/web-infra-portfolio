# Database Connectivity Design

## 1. 通信

WebLogic

↓

RDS PostgreSQL

Port

5432

---

## 2. Security Group

送信元

WebLogic SG

送信先

RDS SG

---

## 3. 名前解決

RDS Endpoint利用

---

## 4. 監視

接続数

CPU

Storage

---

## 5. バックアップ

RDS自動バックアップ

保持期間

7日



