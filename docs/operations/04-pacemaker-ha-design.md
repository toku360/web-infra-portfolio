# Pacemaker High Availability Design

## 1. 文書情報

| 項目    | 内容                                 |
| ----- | ---------------------------------- |
| 文書名   | Pacemaker High Availability Design |
| システム名 | web-infra-portfolio                |
| 版数    | 1.0                                |
| 対象OS  | Rocky Linux 9 / RHEL 9             |

---

# 2. 目的

本書はPacemakerを利用した高可用性(HA)クラスタ構成の設計方針を定義する。

本システムではApache、WebLogic、Oracleなどのサービスを対象とし、サーバ障害時にサービス停止時間を最小化することを目的とする。

---

# 3. HAクラスタ概要

## 高可用性とは

高可用性とはシステム停止時間を最小化する設計である。

例

```text
サーバ障害

↓

待機系へ切替

↓

サービス継続
```

---

## Pacemakerとは

Linuxクラスタ管理ソフトウェア。

役割

* 障害検知
* フェイルオーバー
* リソース管理
* クラスタ制御

---

## Corosyncとは

ノード間通信を担当する。

役割

* Heartbeat
* クラスタ状態同期
* ノード死活監視

---

# 4. 想定構成

## 構成図

```text
Node1 (Active)
      |
      | Heartbeat
      |
Node2 (Standby)

       |
 Virtual IP
       |
     Apache
```

---

# 5. サーバ構成

| サーバ   | 役割      |
| ----- | ------- |
| Node1 | Active  |
| Node2 | Standby |

---

# 6. リソース設計

## Virtual IP

例

```text
10.0.1.100
```

利用者はVirtual IPへ接続する。

---

## Apache

監視対象

```text
httpd.service
```

---

## NFS

共有領域

```text
/nfs/share
```

---

# 7. フェイルオーバー設計

## 通常

```text
Node1

Apache起動

Node2

待機
```

---

## 障害発生

```text
Node1停止
```

---

## 自動切替

```text
VIP移動

↓

Apache起動

↓

Node2昇格
```

---

# 8. フェイルバック設計

## 自動フェイルバック

利用しない。

---

## 手動フェイルバック

採用

理由

* 誤検知防止
* 安全性向上
* 業務影響低減

---

# 9. ネットワーク設計

## Heartbeat

専用通信

推奨

---

## サービス通信

利用者向け

---

## VIP通信

フェイルオーバー対象

---

# 10. 監視設計

## ノード監視

確認

```bash
pcs status
```

---

## クラスタ状態

確認

```bash
pcs cluster status
```

---

## リソース状態

確認

```bash
pcs resource status
```

---

# 11. 障害シナリオ

## Node障害

症状

```text
Node停止
```

対応

```text
自動フェイルオーバー
```

---

## Apache障害

症状

```text
httpd停止
```

対応

```text
再起動

↓

失敗

↓

切替
```

---

## 通信断

症状

```text
Heartbeat断
```

対応

```text
Split Brain確認
```

---

# 12. Split Brain対策

## 概要

両ノードがActiveになる状態。

重大障害。

---

## 対策

STONITH採用

---

## STONITHとは

障害ノード強制停止機能。

---

# 13. セキュリティ設計

## SSH

限定アクセス

---

## 管理ユーザー

最小権限

---

## Firewall

必要通信のみ許可

---

# 14. バックアップ設計

対象

* Pacemaker設定
* Corosync設定
* Apache設定

---

# 15. 変更管理

変更前

* クラスタ状態取得
* リソース状態取得
* 設定バックアップ

---

変更後

* フェイルオーバーテスト
* サービス確認

---

# 16. ロールバック

## 条件

* クラスタ異常
* リソース起動失敗
* フェイルオーバー失敗

---

## 手順

設定復元

サービス確認

クラスタ再起動

---

# 17. 証跡取得

取得コマンド

```bash
pcs status

pcs cluster status

pcs resource status
```

---

保管先

```text
evidence/linux/
```

---

# 18. 運用設計

## 日次

* クラスタ状態確認

---

## 週次

* フェイルオーバー確認

---

## 月次

* DR訓練
* 手順見直し

---

# 19. AWSとの関係

AWSではALBにより負荷分散するため、Pacemakerを利用しないケースも多い。

ただし以下では採用される。

* オンプレ環境
* レガシー環境
* Oracle環境
* ファイル共有環境

---

# 20. 将来拡張

今後以下を追加予定。

* DR設計
* Oracle Data Guard設計
* WebLogic Cluster設計
* AWS Multi-AZ設計
* Aurora高可用性設計



