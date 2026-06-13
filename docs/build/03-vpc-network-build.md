# VPC Network Build

## 1. 文書情報

| 項目 | 内容 |
|---|---|
| 文書名 | VPC Network Build |
| システム名 | web-infra-portfolio |
| 対象環境 | AWS dev |
| 対象リージョン | ap-northeast-1 |
| 版数 | 1.0 |

---

## 2. 目的

本書は web-infra-portfolio のAWS dev環境におけるネットワーク基盤構築手順と構築結果を記録する。

本作業ではTerraformを利用して以下を構築する。

- VPC
- Public Subnet
- Private App Subnet
- Private DB Subnet
- Internet Gateway
- Public Route Table
- Private Route Table

このネットワーク基盤は、後続フェーズで構築する ALB、Apache EC2、WebLogic EC2、Oracle RDS の土台となる。

---

## 3. 構築方針

### 3.1 dev環境の位置付け

dev環境は検証用環境である。

本番想定の考え方を取り入れつつ、コストを抑えた最小構成とする。

### 3.2 Subnet分離方針

| Subnet | 用途 |
|---|---|
| Public Subnet | ALB / 公開系 |
| Private App Subnet | Apache / WebLogic |
| Private DB Subnet | Oracle RDS |

Public、App、DBを分離することで、公開範囲と通信経路を明確化する。

### 3.3 Route Table方針

Public SubnetはInternet Gatewayへのルートを持つ。

Private App SubnetおよびPrivate DB Subnetは、Day19時点ではインターネット向けルートを持たない。

NAT Gatewayはコストを考慮し、後続フェーズで必要に応じて追加する。

---

## 4. 構成

```text
VPC 10.0.0.0/16
├ Public Subnet      10.0.1.0/24
├ Private App Subnet 10.0.2.0/24
└ Private DB Subnet  10.0.3.0/24
```


