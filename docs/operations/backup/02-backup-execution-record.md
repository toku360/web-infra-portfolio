# Backup Execution Record

## 実施概要

Day36パッチ適用後の保護を目的としてSnapshot取得を実施した。

---

## 実施日時

2026-06-XX

---

## 対象

WebLogic EC2

Instance ID

i-06949470bc5b8da16

---

## Volume確認

実施コマンド

```bash
aws ec2 describe-instances \
  --instance-ids i-06949470bc5b8da16 \
  --query "Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId" \
  --output table
```

結果

Volume ID

vol-xxxxxxxx

---

## Snapshot取得

実施コマンド

```bash
aws ec2 create-snapshot \
  --volume-id vol-xxxxxxxx \
  --description "Day37 weblogic before reboot snapshot"
```

結果

Snapshot ID

snap-xxxxxxxx

状態

completed

---

## Snapshot確認

実施コマンド

```bash
aws ec2 describe-snapshots \
  --snapshot-ids snap-xxxxxxxx \
  --query "Snapshots[*].[SnapshotId,State,StartTime]" \
  --output table
```

結果

正常取得確認



