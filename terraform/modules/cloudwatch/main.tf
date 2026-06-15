resource "aws_sns_topic" "alarm" {
  name = "wip-dev-alarm-topic"
}


resource "aws_cloudwatch_metric_alarm" "cpu_high" {

  alarm_name = "wip-dev-cpu-high"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 2

  metric_name = "CPUUtilization"

  namespace = "AWS/EC2"

  period = 300

  statistic = "Average"

  threshold = 70

  alarm_actions = [
    aws_sns_topic.alarm.arn
  ]

  dimensions = {
    InstanceId = var.instance_id
  }
}

resource "aws_cloudwatch_metric_alarm" "status_check" {

  alarm_name = "wip-dev-status-check"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1

  metric_name = "StatusCheckFailed"

  namespace = "AWS/EC2"

  period = 60

  statistic = "Maximum"

  threshold = 0

  alarm_actions = [
    aws_sns_topic.alarm.arn
  ]

  dimensions = {
    InstanceId = var.instance_id
  }
}


