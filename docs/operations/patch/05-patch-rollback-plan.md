# Patch Rollback Plan

## ロールバック条件

* OS起動失敗
* Java起動失敗
* WebLogic起動失敗
* SSM接続不可

---

## 手順1

EBS Snapshot復元

---

## 手順2

AMI再作成

---

## 手順3

Terraform再作成

terraform apply -replace='module.ec2_weblogic.aws_instance.weblogic'

---

## 手順4

dnf history undo

利用は限定的

---


## パッチ適用後確認項目

### Kernel確認

```bash
uname -r
rpm -q kernel
```

目的

* 稼働Kernel確認
* 導入済Kernel確認

---

### dnf履歴確認

```bash
dnf history list
```

目的

* 適用履歴確認
* ロールバック対象確認

---

### 再起動要否確認

```bash
needs-restarting -r
```

目的

* Kernel更新確認
* systemd更新確認
* glibc更新確認

判定

Reboot is required

の場合は再起動を実施する。

---

### ロールバック手順

限定的なロールバック

```bash
dnf history list
dnf history undo <ID>
```

大規模障害時

* EBS Snapshot復元
* AMI復元
* Terraform再作成





