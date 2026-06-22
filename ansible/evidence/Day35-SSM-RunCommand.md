## SSM Run Command 実行結果

WebLogic EC2に対して、SSM Run Commandでヘルスチェックを実行した。

確認項目：

- hostname
- uptime
- df -h
- java -version
- id oracle
- /u01/app/oracle 配下確認

結果：

- Status: Success
- Java: OpenJDK 17.0.19
- oracleユーザー: 存在
- WebLogic用ディレクトリ: 存在
- Disk使用率: root 17%

SSHを使用せず、SSM経由で運用確認を実施できることを確認した。

```cmd
tokud@LAPTOP-B02HI6LF:~/web-infra-portfolio/ansible$ aws ssm send-command \
  --instance-ids i-06949470bc5b8da16 \
  --document-name "AWS-RunShellScript" \
  --comment "Day35 WebLogic health check" \
  --parameters 'commands=["hostname","uptime","df -h","java -version 2>&1","id oracle","ls -ld /u01/app/oracle/*"]' \
  --output table
---------------------------------------------------------------------
|                            SendCommand                            |
+-------------------------------------------------------------------+
||                             Command                             ||
|+------------------------+----------------------------------------+|
||  CommandId             |  62aa56bf-fdc0-44a9-a52a-03c4a5fd4b53  ||
||  Comment               |  Day35 WebLogic health check           ||
||  CompletedCount        |  0                                     ||
||  DeliveryTimedOutCount |  0                                     ||
||  DocumentName          |  AWS-RunShellScript                    ||
||  DocumentVersion       |  $DEFAULT                              ||
||  ErrorCount            |  0                                     ||
||  ExpiresAfter          |  2026-06-20T18:27:12.193000+09:00      ||
||  MaxConcurrency        |  50                                    ||
||  MaxErrors             |  0                                     ||
||  OutputS3BucketName    |                                        ||
||  OutputS3KeyPrefix     |                                        ||
||  OutputS3Region        |  ap-northeast-1                        ||
||  RequestedDateTime     |  2026-06-20T16:27:12.193000+09:00      ||
||  ServiceRole           |                                        ||
||  Status                |  Pending                               ||
||  StatusDetails         |  Pending                               ||
||  TargetCount           |  1                                     ||
||  TimeoutSeconds        |  3600                                  ||
|+------------------------+----------------------------------------+|
|||                      AlarmConfiguration                       |||
||+----------------------------------------------+----------------+||
|||  IgnorePollAlarmFailure                      |  False         |||
||+----------------------------------------------+----------------+||
|||                    CloudWatchOutputConfig                     |||
||+-----------------------------------------------+---------------+||
|||  CloudWatchLogGroupName                       |               |||
|||  CloudWatchOutputEnabled                      |  False        |||
||+-----------------------------------------------+---------------+||
|||                          InstanceIds                          |||
||+---------------------------------------------------------------+||
|||  i-06949470bc5b8da16                                          |||
||+---------------------------------------------------------------+||
|||                      NotificationConfig                       |||
||+----------------------------------------------------+----------+||
|||  NotificationArn                                   |          |||
|||  NotificationType                                  |          |||
||+----------------------------------------------------+----------+||
|||                          Parameters                           |||
||+---------------------------------------------------------------+||
||||                          commands                           ||||
|||+-------------------------------------------------------------+|||
||||  hostname                                                   ||||
||||  uptime                                                     ||||
||||  df -h                                                      ||||
||||  java -version 2>&1                                         ||||
||||  id oracle                                                  ||||
||||  ls -ld /u01/app/oracle/*                                   ||||
|||+-------------------------------------------------------------+|||
tokud@LAPTOP-B02HI6LF:~/web-infra-portfolio/ansible$ aws ssm list-command-invocations \
  --command-id 62aa56bf-fdc0-44a9-a52a-03c4a5fd4b53 \
  --details \
  --query "CommandInvocations[*].CommandPlugins[*].[Status,Output]" \
  --output text
Success ip-10-0-1-219.ap-northeast-1.compute.internal
 07:27:12 up  1:01,  0 users,  load average: 0.00, 0.00, 0.00
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        4.0M     0  4.0M   0% /dev
tmpfs           860M     0  860M   0% /dev/shm
tmpfs           344M  508K  344M   1% /run
efivarfs        128K  3.1K  120K   3% /sys/firmware/efi/efivars
/dev/nvme0n1p4  8.9G  1.5G  7.5G  17% /
/dev/nvme0n1p3  936M  262M  675M  28% /boot
/dev/nvme0n1p2  100M   11M   90M  11% /boot/efi
openjdk version "17.0.19" 2026-04-21 LTS
OpenJDK Runtime Environment (Red_Hat-17.0.19.0.10-1) (build 17.0.19+10-LTS)
OpenJDK 64-Bit Server VM (Red_Hat-17.0.19.0.10-1) (build 17.0.19+10-LTS, mixed mode, sharing)
uid=1001(oracle) gid=1001(oracle) groups=1001(oracle)
drwxr-xr-x. 2 oracle oracle  6 Jun 20 06:26 /u01/app/oracle/config
drwxr-xr-x. 2 oracle oracle 30 Jun 20 06:26 /u01/app/oracle/logs
drwxr-xr-x. 2 oracle oracle  6 Jun 20 06:26 /u01/app/oracle/product
drwxr-xr-x. 2 oracle oracle  6 Jun 20 06:26 /u01/app/oracle/scripts


```
