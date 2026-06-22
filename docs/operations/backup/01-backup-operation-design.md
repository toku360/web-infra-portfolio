# Backup Operation Design

## 1. 目的

本書はAWS上で稼働するWebLogicサーバおよびRDSに対するバックアップ運用方針を定義する。

対象：

* WebLogic EC2
* Apache EC2
* RDS

---

## 2. バックアップ方針

### EC2

取得方式

EBS Snapshot

取得タイミング

* パッチ適用前
* WebLogic変更前
* Terraform変更前
* Java更新前

目的

* OS破損時復旧
* パッチ失敗時復旧
* 構成変更失敗時復旧

---

### RDS

取得方式

AWS Managed Backup

確認コマンド

```bash
aws rds describe-db-instances
```

確認項目

* BackupRetentionPeriod
* Engine
* MultiAZ
* DBInstanceStatus

````

---

## 3. Snapshot取得手順

### 対象Volume確認

```bash
aws ec2 describe-instances \
  --instance-ids i-06949470bc5b8da16 \
  --query "Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId" \
  --output table
````

目的

* 対象EBS特定
* Snapshot取得対象確認

---

### Snapshot取得

```bash
aws ec2 create-snapshot \
  --volume-id <VolumeId> \
  --description "Day37 weblogic before reboot snapshot"
```

目的

* OS保護
* パッチ失敗時復旧

---

### Snapshot確認

```bash
aws ec2 describe-snapshots \
  --snapshot-ids <SnapshotId> \
  --query "Snapshots[*].[SnapshotId,State,StartTime]" \
  --output table
```

確認項目

* completed
* SnapshotId
* 作成日時


### 保存期間

検証

7日

本番

35日以上

### リスク

Snapshot未取得状態でのパッチ適用は禁止


