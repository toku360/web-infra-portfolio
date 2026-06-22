# Patch Execution Record

実施日

2026-06-XX

---

実施者

toku360

---

開始時刻

XX:XX

---

終了時刻

XX:XX

---

事前確認

* SSM Online
* Disk正常
* Memory正常

```
tokud@LAPTOP-B02HI6LF:~/web-infra-portfolio$ aws ssm list-command-invocations \
  --command-id ba043a2e-7ed3-4421-98d8-f607364dbc0e \
  --details \
  --query "CommandInvocations[*].CommandPlugins[*].[Status,Output]" \
  --output text \
  | tee evidence/patch/before/weblogic_patch_check_$(date +%F).log
Success Last metadata expiration check: 1:21:47 ago on Sat 20 Jun 2026 07:00:00 AM UTC.

NetworkManager.x86_64                  1:1.54.3-3.el9_8                baseos
NetworkManager-libnm.x86_64            1:1.54.3-3.el9_8                baseos
NetworkManager-team.x86_64             1:1.54.3-3.el9_8                baseos
NetworkManager-tui.x86_64              1:1.54.3-3.el9_8                baseos
PackageKit.x86_64                      1.2.6-2.el9_7                   appstream
PackageKit-glib.x86_64                 1.2.6-2.el9_7                   appstream
audit.x86_64                           3.1.5-8.el9                     baseos
audit-libs.x86_64                      3.1.5-8.el9                     baseos
binutils.x86_64                        2.35.2-72.el9                   baseos
binutils-gold.x86_64                   2.35.2-72.el9                   baseos
bzip2-libs.x86_64                      1.0.8-11.el9                    baseos
ca-certificates.noarch                 2025.2.80_v9.0.305-91.el9       baseos
chrony.x86_64                          4.8-1.el9                       baseos
cloud-init.noarch                      24.4-8.el9.rocky.0.1            appstream
cockpit-bridge.noarch                  356.2-1.el9_8.rocky.0.1         baseos
cockpit-system.noarch                  356.2-1.el9_8.rocky.0.1         baseos
cockpit-ws.x86_64                      356.2-1.el9_8.rocky.0.1         baseos
coreutils.x86_64                       8.32-40.el9                     baseos
coreutils-common.x86_64                8.32-40.el9                     baseos
cracklib.x86_64                        2.9.6-28.el9                    baseos
cracklib-dicts.x86_64                  2.9.6-28.el9                    baseos
cronie.x86_64                          1.5.7-16.el9                    baseos
cronie-anacron.x86_64                  1.5.7-16.el9                    baseos
crypto-policies.noarch                 20260224-1.gitea0f072.el9       baseos
crypto-policies-scripts.noarch         20260224-1.gitea0f072.el9       baseos
cryptsetup-libs.x86_64                 2.8.1-3.el9                     baseos
curl.x86_64                            7.76.1-40.el9                   baseos
cyrus-sasl-lib.x86_64                  2.1.27-22.el9_7                 baseos
dbus-broker.x86_64                     28-8.el9                        baseos
device-mapper.x86_64                   9:1.02.2
---Output truncated---


```


---

実施内容

dnf check-update

dnf update -y

---

事後確認

Java確認

SSM確認

OS確認

---

結果

正常終了

---

## 実施例

開始：17:20

終了：17:45

事前確認：
SSM Online

実施内容：
dnf check-update
dnf update -y

結果：
Success

更新内容：
kernel
NetworkManager
audit
cloud-init
crypto-policies
他多数

備考：
Kernel更新を含むため再起動要否確認が必要


## 作業の流れ

### 事前確認

#### 更新候補確認

実施コマンド

```bash
aws ssm send-command \
  --instance-ids i-06949470bc5b8da16 \
  --document-name "AWS-RunShellScript" \
  --comment "Day36 patch check" \
  --parameters 'commands=[
    "sudo dnf check-update || true",
    "sudo dnf updateinfo list security || true"
  ]'
```

確認内容

* 更新候補パッケージ確認
* セキュリティ更新有無確認
* 影響評価材料取得

結果

* 更新候補あり
* NetworkManager
* audit
* crypto-policies
* cloud-init
* その他多数

判定

パッチ適用可能

---

### パッチ適用

実施コマンド

```bash
aws ssm send-command \
  --instance-ids i-06949470bc5b8da16 \
  --document-name "AWS-RunShellScript" \
  --comment "Day36 patch apply" \
  --parameters 'commands=[
    "sudo dnf update -y",
    "sudo dnf history list | head -20",
    "sudo needs-restarting -r || true"
  ]'
```

結果

Success

更新パッケージ数

257

主要更新

* kernel
* glibc
* systemd
* NetworkManager
* audit
* crypto-policies
* cloud-init

---

### パッチ適用後確認

実施コマンド

```bash
aws ssm send-command \
  --instance-ids i-06949470bc5b8da16 \
  --document-name "AWS-RunShellScript" \
  --comment "Day36 kernel and dnf history check" \
  --parameters 'commands=[
    "echo CURRENT_KERNEL=$(uname -r)",
    "rpm -q kernel",
    "dnf history list | head -10",
    "needs-restarting -r || true"
  ]'
```

確認内容

* 現在稼働Kernel確認
* 導入済Kernel確認
* dnf履歴確認
* 再起動要否確認

結果

現在Kernel

5.14.0-570.17.1.el9_6

導入済Kernel

* 5.14.0-570.17.1.el9_6
* 5.14.0-687.15.1.el9_8

判定

新Kernel導入済

再起動が必要

---



