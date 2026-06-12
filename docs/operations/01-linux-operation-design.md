# Linux Operation Design

## 1. 文書情報

| 項目     | 内容                         |
| ------ | -------------------------- |
| 文書名    | Linux Operation Design     |
| システム名  | web-infra-portfolio        |
| 対象環境   | Rocky Linux 9 / RHEL 9     |
| 対象システム | Apache / WebLogic / Oracle |
| 作成者    | toku360                    |
| 版数     | 1.0                        |

---

# 2. 目的

本書は Linux サーバの運用管理方針を定義する。

本ポートフォリオでは銀行系システムを想定し、Apache・WebLogic・Oracle を稼働させる Linux サーバに対する運用設計を行う。

本書の目的は以下とする。

* 安定運用
* 障害の早期発見
* 障害時の迅速な復旧
* 変更管理の標準化
* ロールバック手順の標準化
* 運用証跡の管理

---

# 3. 対象範囲

対象

* Rocky Linux
* RHEL
* Apacheサーバ
* WebLogicサーバ
* Oracleサーバ
* AWS EC2

対象外

* アプリケーション開発
* Oracle SQLチューニング詳細
* WebLogicアプリケーション開発

---

# 4. 運用方針

## 4.1 基本方針

本システムは24時間365日稼働を前提とする。

変更作業は原則として事前承認を取得する。

すべての作業は証跡を取得する。

---

## 4.2 運用サイクル

### 日次

* サービス状態確認
* CPU確認
* Memory確認
* Disk確認
* エラーログ確認

### 週次

* パッチ適用状況確認
* 容量推移確認
* 障害履歴確認

### 月次

* アカウント棚卸
* 容量レポート
* バックアップ確認

---

# 5. サービス管理設計

## 対象サービス

| サービス            | 役割       |
| --------------- | -------- |
| sshd            | SSH接続    |
| httpd           | Apache   |
| weblogic        | WebLogic |
| oracle-listener | Oracle接続 |
| chronyd         | 時刻同期     |

---

## 状態確認

```bash
systemctl status httpd
systemctl status sshd
```

---

## 起動

```bash
systemctl start httpd
```

---

## 停止

```bash
systemctl stop httpd
```

---

## 再起動

```bash
systemctl restart httpd
```

---

# 6. 監視設計

## CPU監視

| 状態 | 閾値    |
| -- | ----- |
| 正常 | 70%未満 |
| 警告 | 80%以上 |
| 重大 | 90%以上 |

確認

```bash
top
vmstat 1
```

---

## Memory監視

| 状態 | 閾値    |
| -- | ----- |
| 正常 | 70%未満 |
| 警告 | 80%以上 |
| 重大 | 90%以上 |

確認

```bash
free -m
```

---

## Disk監視

| 状態 | 閾値    |
| -- | ----- |
| 正常 | 70%未満 |
| 警告 | 80%以上 |
| 重大 | 90%以上 |

確認

```bash
df -h
```

---

## inode監視

確認

```bash
df -i
```

---

## Load Average監視

確認

```bash
uptime
```

---

# 7. ログ管理設計

## 対象ログ

| ログ         | 用途     |
| ---------- | ------ |
| messages   | OSログ   |
| secure     | 認証ログ   |
| cron       | ジョブログ  |
| access_log | アクセスログ |
| error_log  | エラーログ  |

---

## 保管期間

| 種別   | 期間  |
| ---- | --- |
| 通常ログ | 90日 |
| 障害ログ | 1年  |
| 監査ログ | 1年  |

---

## ローテーション

logrotateを使用する。

確認

```bash
cat /etc/logrotate.conf
```

---

# 8. 容量管理設計

## 対象

* Root領域
* Application領域
* Log領域

---

## 判定基準

| 使用率 | 対応       |
| --- | -------- |
| 80% | 調査       |
| 90% | 不要ファイル整理 |
| 95% | 緊急対応     |

---

## 容量確認

```bash
df -h
du -sh *
```

---

# 9. ユーザー管理設計

## 基本方針

root直接利用を禁止する。

sudoを利用する。

---

## アカウント管理

* 不要アカウント削除
* 退職者アカウント削除
* 定期棚卸

---

## sudo管理

最小権限とする。

---

# 10. セキュリティ設計

## SSH

PermitRootLogin no

---

## パスワード

* 12文字以上
* 英大文字
* 英小文字
* 数字
* 記号

---

## Firewall

必要通信のみ許可

---

## SELinux

Enforcing推奨

確認

```bash
getenforce
```

---

# 11. バックアップ設計

## 対象

* Apache設定
* WebLogic設定
* Oracle設定
* Terraformコード

---

## バックアップ取得例

```bash
tar czf backup.tar.gz /etc/httpd
```

---

## 保管先

* S3
* バックアップサーバ

---

# 12. 障害対応設計

## 初動

### 1

障害検知

### 2

影響範囲確認

### 3

サービス状態確認

### 4

ログ確認

---

## 確認コマンド

```bash
systemctl status
journalctl -xe
```

---

# 13. 障害切り分け

## CPU高騰

確認

```bash
top
ps aux --sort=-%cpu
```

---

## Memory不足

確認

```bash
free -m
```

---

## Disk Full

確認

```bash
df -h
```

---

## Port競合

確認

```bash
ss -lntp
```

---

## サービス停止

確認

```bash
systemctl status
journalctl -u
```

---

# 14. 変更管理

## 実施前

* 影響調査
* 承認取得
* バックアップ取得

---

## 実施後

* サービス確認
* ログ確認
* 利用者確認

---

# 15. ロールバック設計

## ロールバック条件

* サービス起動不可
* 接続不可
* エラーログ増加
* 性能劣化

---

## 手順

### 設定退避

```bash
cp -p httpd.conf httpd.conf.bak
```

### 設定復元

```bash
cp -p httpd.conf.bak httpd.conf
```

### 再起動

```bash
systemctl restart httpd
```

---

# 16. 証跡管理

## 保管場所

```text
evidence/linux/
```

---

## 証跡対象

* 作業前状態
* 実施内容
* 作業後状態
* ログ
* 結果

---

# 17. エスカレーション

以下の場合は上位担当へ連絡する。

* OS起動不可
* ファイルシステム破損
* Oracle障害
* WebLogic JVM障害
* セキュリティインシデント

---

# 18. 将来拡張

本ポートフォリオでは今後以下を追加する。

* LVM設計
* NFS設計
* Pacemaker設計
* HAクラスタ設計
* Systems Manager運用
* パッチ管理運用



