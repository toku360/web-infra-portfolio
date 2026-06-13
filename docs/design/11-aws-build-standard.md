# AWS Build Standard

## 1. 文書情報

|項目|内容|
|---|---|
|文書名|AWS Build Standard|
|システム名|web-infra-portfolio|
|対象環境|AWS|
|対象リージョン|ap-northeast-1|
|版数|1.0|

---

# 2. 目的

本書はAWS構築標準を定義する。

本ポートフォリオでは以下を対象とする。

- VPC
- Route53
- ALB
- EC2
- Oracle RDS
- CloudWatch
- SNS
- Systems Manager
- S3

すべてTerraformで管理する。

---

# 3. 基本方針

## Infrastructure as Code

AWSコンソールによる手動変更は禁止する。

すべてTerraformで管理する。

---

## 再現性

誰が構築しても同じ結果になること。

---

## 可読性

第三者が理解できるコードとする。

---

## 監査性

Git履歴で変更追跡可能とする。

---

# 4. 環境構成

## dev

検証環境

---

## prod

本番想定環境

---

# 5. リポジトリ構成

```text
terraform/

├ modules
│
├ envs
│   ├ dev
│   └ prod
│
├ backend
│
└ scripts
```

---

# 6. Terraform管理方針

## Version固定

例

```hcl
terraform {
  required_version = "~> 1.8"
}
```

---

## Provider固定

例

```hcl
required_providers {
  aws = {
    source = "hashicorp/aws"
    version = "~> 5.0"
  }
}
```

---

# 7. State管理

## 保存先

S3

---

## Lock

DynamoDB

---

## 理由

複数人作業防止

---

# 8. Secrets管理

禁止

- パスワード直書き
- Access Key直書き

---

利用

- AWS Secrets Manager
- SSM Parameter Store

---

# 9. IAM方針

最小権限

Principle of Least Privilege

---

禁止

AdministratorAccess常用

---

# 10. ネットワーク標準

VPC

10.0.0.0/16

---

Public

10.0.1.0/24

---

Private-App

10.0.2.0/24

---

Private-DB

10.0.3.0/24

---

# 11. Security Group標準

## ALB

443

80

---

## Apache

443

80

---

## WebLogic

7001

ALBのみ許可

---

## Oracle RDS

1521

WebLogicのみ許可

---

# 12. Route53標準

利用

- Alias Record

推奨

- ALB連携

---

# 13. ALB標準

利用

- HTTPS

- Health Check

---

監視

- 5XX
- Target Failure

---

# 14. EC2標準

OS

Rocky Linux 9

---

接続

Systems Manager

---

禁止

踏み台サーバ常用

---

# 15. Oracle RDS標準

Engine

Oracle Enterprise Edition

---

Backup

有効

---

Multi-AZ

有効

---

Monitoring

有効

---

# 16. CloudWatch標準

監視

- CPU
- Memory
- Disk
- ALB
- RDS

---

通知

SNS

---

# 17. S3標準

用途

- Terraform State
- 証跡
- Backup

---

Versioning

有効

---

# 18. Git運用

main

本番想定

---

feature

作業用

---

Pull Request必須

---

# 19. .gitignore標準

除外対象

```text
.terraform/

*.tfstate

*.tfstate.*

*.pem

*.key

.env

*.log
```

---

# 20. 構築手順

1. terraform init

2. terraform fmt

3. terraform validate

4. terraform plan

5. terraform apply

---

# 21. 構築後確認

確認項目

- Route53
- ALB
- EC2
- Oracle RDS
- CloudWatch
- SNS

---

# 22. ロールバック

Terraform利用

```bash
terraform plan

terraform apply
```

前バージョンへ戻す

---

# 23. 証跡取得

取得対象

- terraform plan
- terraform apply
- AWS Console
- CloudWatch

---

保管先

evidence/aws/

---

# 24. セキュリティ

禁止

- 秘密情報コミット
- パスワード保存
- Access Key保存

---

必須

- MFA
- IAM最小権限

---

# 25. 将来拡張

- WAF
- GuardDuty
- Security Hub
- Inspector
- AWS Backup
- CloudTrail統合



