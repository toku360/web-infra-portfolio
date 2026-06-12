# NFS Operation Design

## 1. 文書情報

| 項目    | 内容                     |
| ----- | ---------------------- |
| 文書名   | NFS Operation Design   |
| システム名 | web-infra-portfolio    |
| 版数    | 1.0                    |
| 対象OS  | Rocky Linux 9 / RHEL 9 |

---

# 2. 目的

本書はNFS(Network File System)の設計方針および運用方針を定義する。

本システムでは複数サーバ間で設定ファイルや共有データを利用することを想定し、共有ストレージ基盤としてNFSを採用する。

---

# 3. NFS概要

NFSはLinux/UNIX系OSで広く利用される共有ファイルシステムである。

利用目的

* ログ共有
* 設定ファイル共有
* バックアップ保存
* アプリケーション共有領域

---

# 4. 想定利用シナリオ

## Apache

共有コンテンツ領域

```text
/nfs/web-content
```

---

## WebLogic

共有デプロイ領域

```text
/nfs/weblogic-share
```

---

## Oracle

バックアップ保管

```text
/nfs/oracle-backup
```

---

# 5. 構成設計

## NFS Server

役割

* 共有領域提供

---

## NFS Client

役割

* 共有領域利用

---

## 論理構成

```text
Apache
   \
    \
WebLogic ---- NFS Server
    /
   /
Oracle
```

---

# 6. ネットワーク設計

## 使用ポート

| Port | 用途      |
| ---- | ------- |
| 111  | rpcbind |
| 2049 | NFS     |

---

## 通信方針

NFS通信はPrivate Networkのみ許可する。

インターネット経由利用は禁止する。

---

# 7. マウント設計

## マウントポイント

```text
/mnt/nfs
```

---

## 永続化

/etc/fstab

利用

例

```text
10.0.0.10:/share
/mnt/nfs
nfs defaults 0 0
```

---

# 8. 容量管理

## 管理対象

* NFS容量
* inode
* マウント状態

---

## 閾値

| 状態 | 使用率   |
| -- | ----- |
| 正常 | 70%未満 |
| 警告 | 80%以上 |
| 重大 | 90%以上 |
| 緊急 | 95%以上 |

---

# 9. 監視設計

## マウント確認

```bash
mount
```

---

## ディスク確認

```bash
df -h
```

---

## inode確認

```bash
df -i
```

---

## プロセス確認

```bash
systemctl status nfs-server
```

---

# 10. バックアップ設計

## 対象

* 共有ファイル
* 設定ファイル
* バックアップデータ

---

## 保管先

* S3
* バックアップサーバ

---

# 11. 障害シナリオ

## マウント解除

症状

```text
アクセス不可
```

---

## 容量枯渇

症状

```text
書き込み不可
```

---

## NFS停止

症状

```text
タイムアウト
```

---

# 12. 障害対応

## NFS状態確認

```bash
systemctl status nfs-server
```

---

## Export確認

```bash
exportfs -v
```

---

## マウント確認

```bash
showmount -e
```

---

## ネットワーク確認

```bash
ping

ss -lntp
```

---

# 13. セキュリティ設計

## 許可ホスト制限

例

```text
10.0.0.0/24
```

---

## Root Squash

有効化

理由

```text
権限昇格防止
```

---

## Public公開禁止

Private Networkのみ

---

# 14. 変更管理

変更前

* export設定取得
* マウント確認
* 容量確認

---

変更後

* 接続確認
* 読み書き確認

---

# 15. ロールバック

## 条件

* マウント失敗
* アクセス不可
* 設定誤り

---

## 手順

### 設定復元

```bash
cp exports.bak exports
```

---

### 再読込

```bash
exportfs -ra
```

---

### 接続確認

```bash
showmount -e
```

---

# 16. 証跡取得

取得コマンド

```bash
mount

df -h

df -i

exportfs -v

showmount -e
```

---

保管先

```text
evidence/linux/
```

---

# 17. 運用設計

## 日次

* マウント状態確認

---

## 週次

* 容量確認

---

## 月次

* 利用状況確認
* 不要データ削除

---

# 18. Pacemakerとの関係

将来的にPacemaker導入時は共有領域として利用可能。

---

# 19. WebLogic Clusterとの関係

共有デプロイ領域として利用可能。

---

# 20. 将来拡張

今後以下を追加予定。

* Pacemaker設計
* DR設計
* HAクラスタ設計
* AWS EFS設計



