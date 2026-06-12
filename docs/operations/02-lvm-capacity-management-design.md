# LVM Capacity Management Design

## 1. 文書情報

| 項目    | 内容                             |
| ----- | ------------------------------ |
| 文書名   | LVM Capacity Management Design |
| システム名 | web-infra-portfolio            |
| 版数    | 1.0                            |
| 対象OS  | Rocky Linux 9 / RHEL 9         |

---

# 2. 目的

本書はLinuxサーバにおけるLVM（Logical Volume Manager）の設計方針および容量管理方針を定義する。

本システムではApache、WebLogic、Oracleを稼働させることを想定しており、ログ増加やデータ増加による容量不足を防止するため、論理ボリューム管理を採用する。

---

# 3. LVM概要

LVMは物理ディスクを論理的に管理する仕組みである。

従来のパーティション管理と比較して以下の利点がある。

* オンライン容量拡張
* 柔軟なディスク管理
* ボリューム統合
* 将来拡張への対応

---

# 4. LVM構成要素

## Physical Volume (PV)

物理ディスク。

例

```text
/dev/sdb
/dev/sdc
```

---

## Volume Group (VG)

複数PVをまとめた論理領域。

例

```text
vg_app
```

---

## Logical Volume (LV)

実際にOSから利用する領域。

例

```text
lv_app
lv_log
lv_backup
```

---

# 5. 想定構成

## Apache

| 領域      | 用途     |
| ------- | ------ |
| lv_root | OS     |
| lv_app  | Apache |
| lv_log  | ログ     |

---

## WebLogic

| 領域      | 用途       |
| ------- | -------- |
| lv_root | OS       |
| lv_app  | WebLogic |
| lv_log  | ログ       |

---

## Oracle

| 領域         | 用途          |
| ---------- | ----------- |
| lv_root    | OS          |
| lv_data    | DBデータ       |
| lv_archive | Archive Log |
| lv_backup  | Backup      |

---

# 6. 容量管理方針

## 監視対象

* Filesystem
* Volume Group
* Logical Volume
* inode

---

## 閾値

| 状態 | 使用率   |
| -- | ----- |
| 正常 | 70%未満 |
| 警告 | 80%以上 |
| 重大 | 90%以上 |
| 緊急 | 95%以上 |

---

# 7. 容量確認手順

## Filesystem確認

```bash
df -h
```

---

## inode確認

```bash
df -i
```

---

## VG確認

```bash
vgs
```

---

## LV確認

```bash
lvs
```

---

## PV確認

```bash
pvs
```

---

# 8. 容量不足時の対応

## 80%以上

* 原因調査
* ログ肥大化確認

---

## 90%以上

* 不要ファイル削除
* 圧縮実施

---

## 95%以上

* 緊急対応
* 容量拡張判断

---

# 9. 容量拡張手順

## 事前確認

```bash
df -h
vgs
lvs
```

---

## ディスク追加

例

```text
/dev/sdb
```

追加

---

## PV作成

```bash
pvcreate /dev/sdb
```

---

## VG拡張

```bash
vgextend vg_app /dev/sdb
```

---

## LV拡張

```bash
lvextend -L +10G /dev/vg_app/lv_log
```

---

## Filesystem拡張

XFS

```bash
xfs_growfs
```

EXT4

```bash
resize2fs
```

---

# 10. ロールバック方針

## 変更前

取得

```bash
pvs
vgs
lvs
df -h
```

---

## 障害発生時

原因調査

ログ確認

サービス影響確認

---

## 復旧

バックアップ利用

設定復元

---

# 11. 障害シナリオ

## ログ肥大化

対象

```text
/var/log/httpd
```

---

## Archive Log肥大化

対象

```text
Oracle Archive Log
```

---

## バックアップ肥大化

対象

```text
Backup領域
```

---

# 12. 運用設計

## 日次

* df -h確認

---

## 週次

* 容量推移確認

---

## 月次

* 容量レポート作成

---

# 13. 証跡取得

取得コマンド

```bash
df -h
df -i
pvs
vgs
lvs
```

保管先

```text
evidence/linux/
```

---

# 14. 将来拡張

今後以下を追加予定。

* NFS設計
* Pacemaker設計
* DR設計
* HA構成設計




