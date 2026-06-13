# Incident Response Standard

## 1. 目的

本書は障害対応標準を定義する。

---

# 2. 基本方針

障害対応は以下の流れで行う。

1. 検知
2. 影響調査
3. 切り分け
4. 復旧
5. 報告
6. 再発防止

---

# 3. 初動対応

確認事項

- 利用者影響
- 発生時刻
- 対象システム
- エラーメッセージ

---

# 4. 切り分け

優先順位

1. ALB
2. Apache
3. WebLogic
4. Oracle

---

# 5. Apache障害

確認

systemctl status httpd

journalctl -u httpd

---

# 6. WebLogic障害

確認

Managed Server

Datasource

JVM

---

# 7. Oracle障害

確認

RDS Event

CloudWatch

接続状態

---

# 8. AWS障害

確認

CloudWatch Alarm

ALB HealthCheck

Security Group

Route Table

---

# 9. 報告

最低記載事項

- 発生時刻
- 原因
- 影響範囲
- 復旧時刻
- 再発防止

---

# 10. エスカレーション

重大障害

15分以内

上位担当へ連絡

---

# 11. 証跡

取得対象

- ログ
- アラート
- 設定値
- コマンド結果

---

# 12. 再発防止

原因分析

恒久対応

手順書更新




