# Patch Rollback Runbook

## 1. 目的

パッチ適用失敗時の復旧手順を記載する。

---

## 2. 判断基準

以下の場合

ロールバック実施

- サービス停止
- ALB unhealthy
- Apache起動失敗

---

## 3. EBS Snapshot復元

対象Volume確認

```bash
aws ec2 describe-volumes
```

---

Snapshot確認

```bash
aws ec2 describe-snapshots
```

---

新Volume作成

```bash
aws ec2 create-volume
```

---

EC2停止

```bash
aws ec2 stop-instances
```

---

Volume差し替え

実施

---

EC2起動

```bash
aws ec2 start-instances
```

---

## 4. 動作確認

Apache

```bash
systemctl status httpd
```

---

ALB

```bash
curl http://ALB-DNS
```

---

## 5. 完了条件

Target Health

```text
healthy
```

ALB疎通

```text
正常
```



