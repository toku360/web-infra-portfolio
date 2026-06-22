# Restore Runbook

## 障害シナリオ

### パターン1

Day36パッチ適用後

OS起動不可

---

### パターン2

Kernel更新後

WebLogic起動不可

---

### パターン3

Terraform誤更新

---

## 復旧判断

確認コマンド

```bash
aws ssm describe-instance-information
```

確認項目

* SSM Online
* PingStatus

---

## Snapshot確認

```bash
aws ec2 describe-snapshots
```

---

## Volume復元

```bash
aws ec2 create-volume \
  --snapshot-id snap-xxxxxxxx
```

---

## 復旧確認

- EC2復旧
- EC2停止
- Volume切り離し
- 復元Volume接続
- 起動

```bash
uname -r

java -version

systemctl status amazon-ssm-agent
```

---

## 完了条件

* SSM Online
* Java正常
* OS正常
* WebLogic正常


