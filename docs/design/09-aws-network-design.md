# AWSネットワーク設計

# VPC

10.0.0.0/16

---

# Public Subnet

10.0.1.0/24

Apache配置

---

# Private Subnet

10.0.2.0/24

WebLogic配置

---

# Database Subnet

10.0.3.0/24

Oracle配置

---

# Security Group

Apache

443

80

22

---

WebLogic

7001

Apacheのみ許可

---

Oracle

1521

WebLogicのみ許可



