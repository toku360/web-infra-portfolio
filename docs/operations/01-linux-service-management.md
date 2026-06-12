# Linux Service Management Design

---

# 1. 文書情報

| 項目    | 内容                              |
| ----- | ------------------------------- |
| 文書名   | Linux Service Management Design |
| システム名 | web-infra-portfolio             |
| 作成者   | toku360                         |
| バージョン | 1.0                             |
| 対象OS  | Rocky Linux 9 / RHEL 9          |

---

# 2. 目的

本書は Linux サーバにおけるサービス管理方式を定義する。

銀行系システムでは Apache、WebLogic、Oracle 等のミドルウェアが常時稼働している。

サービス障害発生時に迅速な切り分けと復旧を行うため、サービス管理・ログ確認・障害対応・ロールバックの標準手順を定義する。

---

# 3. 適用範囲

本書は以下を対象とする。

* Rocky Linux
* RHEL
* Apache
* WebLogic
* Oracle
* AWS EC2

---

# 4. systemd概要

## 4.1 systemdとは

systemdはLinuxのサービス管理フレームワークである。

従来のSysV initに代わり採用されている。

主な役割は以下の通り。

* サービス起動
* サービス停止
* 自動起動管理
* 依存関係管理
* ログ管理

---

## 4.2 採用理由

### 起動速度向上

並列起動が可能。

### 依存関係管理

サービス間の依存を管理可能。

例

Network起動後にApache起動。

### ログ統合

journalctlによる一元管理。

---

# 5. Unit設計

## 5.1 Service Unit

例

httpd.service

mysqld.service

---

## 5.2 Target Unit

ランレベル相当。

例

multi-user.target

graphical.target

---

## 5.3 Timer Unit

cron代替。

---

## 5.4 Socket Unit

Socket Activation対応。

---

# 6. サービス運用設計

## 6.1 Apache

### 起動

systemctl start httpd

### 停止

systemctl stop httpd

### 再起動

systemctl restart httpd

### 状態確認

systemctl status httpd

---

## 6.2 WebLogic

本番環境ではsystemd連携を推奨。

### 起動確認

systemctl status weblogic

---

## 6.3 Oracle

Oracle Listener確認。

systemctl status oracle-listener

---

# 7. ログ設計

## 7.1 journalctl

確認

journalctl -u httpd

---

## 7.2 直近ログ

journalctl -u httpd -n 100

---

## 7.3 エラーログ

journalctl -p err

---

## 7.4 起動失敗確認

journalctl -xe

---

# 8. 障害対応設計

## 8.1 サービス起動失敗

確認順序

1. status確認
2. journal確認
3. Port確認
4. 設定確認

---

### 確認コマンド

systemctl status httpd

journalctl -u httpd

---

## 8.2 Port競合

### 確認

ss -lntp

---

### 原因例

* 重複起動
* 別サービス利用

---

## 8.3 ディスクフル

確認

df -h

---

### 想定影響

* ログ出力停止
* サービス停止

---

## 8.4 権限不備

確認

ls -l

getenforce

---

# 9. 監視設計

## 監視項目

| 項目       | 閾値   |
| -------- | ---- |
| CPU      | 80%  |
| Memory   | 80%  |
| Disk     | 80%  |
| Apache   | 停止検知 |
| WebLogic | 停止検知 |
| Oracle   | 停止検知 |

---

# 10. メンテナンス手順

## 事前確認

* バージョン確認
* サービス状態確認
* ログ確認

---

## 実施

設定変更

再起動

---

## 事後確認

* サービス起動
* ログ確認
* 接続確認

---

# 11. ロールバック設計

## 実施条件

以下の場合にロールバックする。

* 起動失敗
* エラー増加
* 接続不可

---

## 手順

### 変更前退避

cp -p config config.bak

---

### 設定復元

cp -p config.bak config

---

### サービス再起動

systemctl restart

---

# 12. 証跡取得

## 作業前

systemctl status

---

## 作業後

systemctl status

journalctl

---

## 保管場所

evidence/linux/

---

# 13. エスカレーション

以下の場合は上位担当へ連絡する。

* サービス復旧不可
* Oracle障害
* WebLogic JVM障害
* OS障害

---

# 14. 参考情報

* RHEL Documentation
* Rocky Linux Documentation
* systemd Documentation
* Apache Documentation

---

# 15. 今後の拡張

* Pacemaker連携
* HA構成
* Cluster構成
* AWS Systems Manager連携



