# 詳細設計書

---

# 1. 文書情報

| 項目 | 内容 |
|--------|--------|
| 文書名 | 詳細設計書 |
| システム名 | Web Infrastructure Portfolio |
| バージョン | 1.0 |

---

# 2. システム構成

## 2.1 構成図

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

# 3. サーバ設計

## 3.1 Apache

### 役割

- HTTPS終端
- Reverse Proxy
- Access Log
- Error Log

### 想定Port

| Port | 用途 |
|--------|--------|
| 80 | HTTP |
| 443 | HTTPS |

### ログ

| ログ | パス |
|--------|--------|
| access_log | /var/log/httpd/access_log |
| error_log | /var/log/httpd/error_log |

---

## 3.2 WebLogic

### 役割

- Java実行基盤
- DataSource管理
- Connection Pool管理

### Port

| Port | 用途 |
|--------|--------|
| 7001 | HTTP |
| 7002 | HTTPS |

### ログ

```text
/u01/app/weblogic/logs
```

---

## 3.3 Oracle

### 役割

- データ管理
- SQL実行

### Port

| Port | 用途 |
|--------|--------|
| 1521 | Listener |

### ログ

```text
alert.log
listener.log
```

---

# 4. ネットワーク設計

## 通信一覧

| From | To | Port |
|--------|--------|--------|
| Client | Apache | 443 |
| Apache | WebLogic | 7001 |
| WebLogic | Oracle | 1521 |

---

# 5. ディレクトリ設計

## Apache

```text
/etc/httpd/

/var/www/

/var/log/httpd/
```

---

## WebLogic

```text
/u01/app/weblogic
```

---

## Oracle

```text
/u01/app/oracle
```

---

# 6. バックアップ設計

対象

- Apache設定
- WebLogic設定
- Oracle設定
- Terraformコード

---

# 7. 監視設計

監視対象

- CPU
- Memory
- Disk
- Apache
- WebLogic
- Oracle

---

# 8. ロールバック方針

変更前に

- 設定退避
- ログ取得
- サービス状態取得

を行う。

---

# 9. 障害切り分け方針

順番

1. Apache
2. WebLogic
3. Oracle

の順で確認する。

---

# 10. 今後追加予定

- WebLogic Cluster
- Oracle RAC
- AWS構成
- Route53
- AutoScaling



