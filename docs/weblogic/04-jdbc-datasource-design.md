# JDBC DataSource Design

## 1. 目的

WebLogicからRDSへ接続するためのDataSourceを構成する。

---

## 2. DataSource名

AppDS

---

## 3. JNDI

jdbc/AppDS

---

## 4. Database

PostgreSQL

---

## 5. 接続先

RDS Endpoint

Port 5432

---

## 6. Connection Pool

Initial Capacity : 5

Minimum Capacity : 5

Maximum Capacity : 20

---

## 7. Test Query

SELECT 1

---

## 8. 障害時

Connection Pool枯渇

↓

利用状況確認

↓

不要接続解放

↓

Pool再起動



