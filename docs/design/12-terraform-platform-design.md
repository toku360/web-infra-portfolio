# Terraform Platform Design

## 1. 文書情報

|項目|内容|
|---|---|
|文書名|Terraform Platform Design|
|システム名|web-infra-portfolio|
|版数|1.0|
|対象環境|AWS|

---

# 2. 目的

本書はTerraform実行基盤の設計を定義する。

本ポートフォリオではAWS環境をTerraformで管理し、Infrastructure as Codeを実現する。

---

# 3. Terraform採用理由

Terraformを採用する理由は以下である。

- 構成管理のコード化
- 再現性確保
- Git管理
- レビュー容易化
- ロールバック容易化

---

# 4. 管理対象

本ポートフォリオでは以下をTerraform管理する。

- VPC
- Route53
- ALB
- EC2
- Oracle RDS
- CloudWatch
- SNS
- S3
- IAM
- Systems Manager

---

# 5. ディレクトリ構成

terraform/

├ modules/
│
├ envs/
│ ├ dev/
│ └ prod/
│
├ backend/
│
└ scripts/

---

# 6. 環境設計

## dev

目的

検証環境

---

特徴

- コスト優先
- 単一AZ

---

## prod

目的

本番想定

---

特徴

- 可用性重視
- Multi-AZ
- 冗長構成

---

# 7. Backend設計

Terraform StateはS3へ保存する。

---

## Bucket名

例

web-infra-portfolio-tfstate

---

## Versioning

有効

---

## Encryption

有効

---

# 8. Lock設計

Terraform同時実行防止のためDynamoDBを利用する。

---

## Table名

terraform-lock

---

# 9. State管理方針

禁止

- local state管理
- stateファイルGit管理

---

必須

- S3管理
- Lock管理

---

# 10. Provider設計

リージョン

ap-northeast-1

---

Provider Version

固定

---

# 11. Secrets管理

禁止

- Access Keyコミット
- Passwordコミット

---

利用

- AWS Secrets Manager
- SSM Parameter Store

---

# 12. Git管理

main

本番想定

---

feature

開発

---

Pull Request必須

---

# 13. .gitignore設計

対象

.terraform/

*.tfstate

*.tfstate.*

*.pem

*.key

.env

*.log

---

# 14. ロールバック

Git Tag利用

---

Terraformコード復元

---

terraform plan

terraform apply

実施

---

# 15. 監査

対象

- Git
- Pull Request
- CloudTrail
- Terraform State

---

# 16. 今後構築予定

Day17

Terraform実行環境構築

---

Day18

Backend構築

---

Day19

VPC構築

---

Day20

Subnet構築

---

Day21

ALB構築

---

Day22

EC2構築

---

Day23

Oracle RDS構築

---

Day24

CloudWatch構築

---

Day25

SNS構築



