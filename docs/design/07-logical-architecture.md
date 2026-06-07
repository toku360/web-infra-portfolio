# 論理構成設計書

# 1. 目的

本システムの論理構成を定義する。

---

# 2. 論理構成

Client

↓

Apache

↓

WebLogic

↓

Oracle

---

# 3. 各コンポーネント

## Apache

役割

- HTTPS終端
- Reverse Proxy

---

## WebLogic

役割

- Javaアプリ実行

---

## Oracle

役割

- DB管理

---

# 4. 通信

Client → Apache

Apache → WebLogic

WebLogic → Oracle


