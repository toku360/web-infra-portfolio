# Patch Change Plan

変更番号

CHG-2026-001

---
例)

対象

WebLogic EC2

確認結果：
更新候補 12件

内訳：
- kernel 1件
- openssl 2件
- glibc 3件
- その他 6件

再起動：
必要（kernel更新あり）

---

作業日時

2026-06-XX

---

リスク

* Java影響
* WebLogic起動失敗
* SSM切断

---

影響

WebLogic停止

最大30分

---

Go条件

* Snapshot取得済
* SSM Online
* 事前証跡取得済

---

No-Go条件

* SSM異常
* Snapshot未取得
* Critical障害発生中

---


## 実装例

### パッチ確認結果

SSM Run Command により `dnf check-update` を実行した。

結果、NetworkManager、audit、curl、crypto-policies、cloud-init など複数パッケージの更新候補を確認した。

CLI出力は一部 `Output truncated` となったため、更新候補の詳細確認は追加コマンドまたはdnf履歴で補完する。

### Go / No-Go 判定

判定：条件付きGo

理由：

- WebLogic本体は未導入のため、アプリケーション影響は限定的
- SSM接続はOnline
- Java導入済み
- WebLogic用ディレクトリ作成済み

条件：

- 事前証跡取得
- 事後証跡取得
- 異常時はTerraform再作成で復旧





