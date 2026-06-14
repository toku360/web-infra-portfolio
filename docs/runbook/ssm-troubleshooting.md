# SSM Troubleshooting Runbook

## 1. 目的

EC2へSSM接続できない場合の切り分け手順を記載する。

---

## 2. 症状

AWSコンソール

Session Manager

```text
Not Connected
```

---

## 3. 確認項目

### IAM Role

確認

```bash
aws ec2 describe-instances
```

確認内容

- IAM Role
- Instance Profile

---

### SSM Agent

確認

```bash
aws ssm describe-instance-information
```

期待値

```text
Online
```

---

### Network

確認

- Internet Gateway
- Route Table
- Outbound通信

HTTPS 443が利用可能か

---

### Agent起動

Linux

```bash
systemctl status amazon-ssm-agent
```

---

## 4. よくある原因

### IAM Role未設定

症状

```text
Not Connected
```

---

### Agent未導入

症状

```text
describe-instance-information

空
```

---

### UserData失敗

症状

```text
ApacheもSSMも起動しない
```

---

## 5. ロールバック

SSM導入変更前のAMIへ戻す。

TerraformでEC2再作成する。


