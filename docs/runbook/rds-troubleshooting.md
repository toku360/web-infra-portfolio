# RDS Troubleshooting Runbook

## 1. 目的

RDS接続障害時の切り分け手順を記載する。

---

## 2. 症状

- DB接続失敗
- タイムアウト
- 認証失敗

---

## 3. 確認項目

### RDS状態

```bash
aws rds describe-db-instances
```

期待値

```text
available
```

---

### Security Group

確認

5432

許可されているか

---

### Endpoint

確認

```bash
aws rds describe-db-instances
```

---

### DB接続数

CloudWatch

DatabaseConnections

確認

---

## 4. よくある原因

### SG未設定

Apache → RDS

拒否

---

### Endpoint誤り

接続先ミス

---

### Password誤り

認証失敗

---

## 5. 復旧

修正後

再接続確認

---

## 6. 完了条件

接続成功

アプリ正常稼働



