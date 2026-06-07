# Evidence Management

## 1. 目的

このディレクトリは、作業証跡を管理するためのものです。

証跡は、設計・構築・運用作業を実施したことを示す重要な成果物です。

## 2. 証跡として残すもの

| 種類 | 例 |
|---|---|
| コマンド結果 | systemctl status, curl, ss |
| 設定確認 | httpd -t, listener状態 |
| ログ | error_log, alert log |
| バージョン | httpd -v, java -version |
| 変更前後 | diff, backup |

## 3. 禁止事項

以下は登録禁止です。

- 実IP
- 顧客名
- 実ホスト名
- パスワード
- 秘密鍵
- 証明書
- 生ログ

## 4. ファイル命名

```text
YYYYMMDD-対象-作業内容.md
```

例：

```text
20260607-apache-config-test.md
20260607-oracle-listener-check.md
```

## 5. 証跡テンプレート

```markdown
# 作業証跡

## 作業日

YYYY-MM-DD

## 対象

Apache / WebLogic / Oracle / Linux / AWS

## 作業内容

## 作業前確認

## 実施コマンド

## 作業後確認

## 結果

## 備考
```



