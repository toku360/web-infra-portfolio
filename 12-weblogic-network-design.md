# Network Design

Client
 ↓
ALB
 ↓
Apache
 ↓
WebLogic
 ↓
RDS

## Port一覧

|送信元|送信先|Port|
|---|---|---|
|Internet|ALB|80/443|
|ALB|Apache|80|
|Apache|WebLogic|7001|
|WebLogic|RDS|5432|


