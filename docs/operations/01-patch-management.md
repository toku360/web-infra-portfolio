# Patch Management Design

## 1. 目的

本書は web-infra-portfolio におけるパッチ適用運用を定義する。

対象

- Rocky Linux
- Apache
- AWS EC2

---

## 2. 基本方針

パッチ適用は

- 計画
- 事前確認
- バックアップ
- 適用
- 動作確認
- ロールバック

の順で実施する。

---

## 3. 変更管理フロー

変更申請

↓

レビュー

↓

承認

↓

バックアップ取得

↓

パッチ適用

↓

動作確認

↓

完了報告

---

## 4. 事前確認

確認項目

|項目|内容|
|---|---|
|EC2状態|running|
|ALB|healthy|
|CPU|正常|
|Disk|空き容量確認|
|Apache|起動中|

---

## 5. バックアップ

実施内容

### EBS Snapshot

対象

- Root Volume

取得タイミング

- 適用前

---

## 6. パッチ適用

### OS

```bash
dnf check-update
dnf update -y
```

### Apache

```bash
dnf update httpd -y
```

---

## 7. 動作確認

確認

```bash
systemctl status httpd
```

---

ALB確認

```bash
curl http://ALB-DNS
```

期待値

```text
web-infra-portfolio dev apache
```

---

## 8. 障害時対応

症状

- Apache起動失敗
- Health Check失敗
- HTTP500

対応

ロールバック実施

---

## 9. ロールバック条件

以下の場合

ロールバックを実施する

- Apache起動不可
- ALB unhealthy
- 業務影響発生

---

## 10. 証跡

取得

- dnf update結果
- Apacheバージョン
- ALB疎通結果
- CloudWatch確認



