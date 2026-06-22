
# Patch Operation Design

## 1. 目的

Rocky Linux / RHEL サーバに対するパッチ運用手順を標準化する。

対象システム：

* Apache EC2
* WebLogic EC2

---

## 2. パッチ適用方針

優先順位

1. Critical
2. High
3. Medium

---

## 3. 適用サイクル

| 区分       | 頻度  |
| -------- | --- |
| Critical | 緊急  |
| High     | 月次  |
| Medium   | 四半期 |

---

## 4. 作業フロー

事前証跡取得

↓

変更承認

↓

適用

↓

再起動確認

↓

事後証跡取得

↓

報告

---

## 5. 監査証跡

保存先

evidence/patch/

保存期間

1年以上



