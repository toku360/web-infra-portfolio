# Terraform Remote Backend

## 1. 文書情報

| 項目 | 内容 |
|---|---|
| 文書名 | Terraform Remote Backend |
| システム名 | web-infra-portfolio |
| 対象環境 | AWS |
| 対象リージョン | ap-northeast-1 |
| 版数 | 1.0 |

---

## 2. 目的

本書は Terraform State をローカル管理から Remote Backend 管理へ移行する手順と運用方針を定義する。

Terraform State には、AWSリソースID、構成情報、依存関係などが含まれるため、ローカル端末のみで管理すると以下のリスクがある。

- 端末故障による State 消失
- 複数人作業時の State 不整合
- GitHub への誤コミット
- ロールバック不能
- 構成管理の属人化

そのため、本ポートフォリオでは S3 と DynamoDB を利用して State を安全に管理する。

---

## 3. 対象

本書の対象は以下とする。

- Terraform Backend
- S3 Bucket
- DynamoDB Lock Table
- `.gitignore`
- State移行手順
- GitHub反映手順

---

## 4. Backend構成

| 項目 | 内容 |
|---|---|
| State保存先 | Amazon S3 |
| Lock管理 | Amazon DynamoDB |
| リージョン | ap-northeast-1 |
| 暗号化 | 有効 |
| Versioning | 有効 |
| Git管理 | Stateファイルは除外 |

---

## 5. 採用理由

### 5.1 S3を採用する理由

S3は高耐久性のオブジェクトストレージであり、Terraform State の保管先として適している。

採用理由は以下の通り。

- Stateをローカル端末に依存させない
- Versioningにより過去世代を保持できる
- 暗号化により安全性を高められる
- AWS標準サービスで運用しやすい

### 5.2 DynamoDBを採用する理由

DynamoDBはTerraform実行時のLock管理に利用する。

採用理由は以下の通り。

- 複数人作業時の同時applyを防止できる
- State破損リスクを下げられる
- Terraform Backendと組み合わせやすい
- 運用負荷が低い

---

## 6. backend.tf

```hcl
terraform {
  backend "s3" {
    bucket         = "web-infra-portfolio-tfstate-<ACCOUNT_ID>"
    key            = "backend/terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```





