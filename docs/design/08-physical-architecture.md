# 物理構成設計書

# サーバ一覧

| サーバ | 役割 |
|----------|----------|
| Apache | Web |
| WebLogic | AP |
| Oracle | DB |

# AWSサービス一覧

| サービス | 用途 |
|----------|----------|
| Route53 | DNS |
| ALB | 負荷分散 |
| EC2 | Web/AP |
| Aurora | DB |
| CloudWatch | 監視 |
| SNS | 通知 |
| SSM | 運用 |
| S3 | 保管 |
| Backup | バックアップ |

---

# OS

Rocky Linux

---

# 想定CPU

Apache

2vCPU

---

WebLogic

2vCPU

---

Oracle

2vCPU

---

# 想定メモリ

Apache

4GB

---

WebLogic

8GB

---

Oracle

8GB


