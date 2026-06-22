# Patch Result Report

## 概要

WebLogic EC2へパッチ適用を実施した。

---

## 対象

i-06949470bc5b8da16

---

## 結果

成功

---

## 適用件数

XX件

---

## 障害

なし

---

## 顧客影響

なし

---

## 次回対応

翌月定例パッチ

---


## 実施例

結果：成功

更新件数：
多数

重大更新：
kernel

顧客影響：
なし

障害：
なし

推奨：
再起動後の確認実施


## 技術評価

### パッチ適用結果

Status

Success

更新件数

257

更新区分

* Kernel
* OS Core
* Security
* Network
* Management Agent

---

### Kernel評価

確認コマンド

```bash
rpm -q kernel
uname -r
```

結果

稼働中Kernel

5.14.0-570.17.1.el9_6

導入済Kernel

5.14.0-687.15.1.el9_8

評価

パッチ適用は成功している。

ただしOS再起動を実施していないため、新Kernelは未適用状態である。

---

### 再起動要否評価

確認コマンド

```bash
needs-restarting -r
```

結果

```text
Core libraries or services have been updated since boot-up:

dbus-broker
glibc
kernel
microcode_ctl
systemd

Reboot is required
```

評価

再起動必須

理由

以下コンポーネントが更新されたため。

* kernel
* glibc
* systemd

これらはOS中核コンポーネントであり、再起動を実施しなければ更新内容は完全に有効化されない。




