# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file
# except in compliance with the License. A copy of the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is distributed on an "AS IS"
# BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under the License.
resource "aws_autoscaling_group" "game_asg" {
  lifecycle { create_before_destroy = true }
  vpc_zone_identifier = ["${var.game_public_subnet_1}","${var.game_public_subnet_2}","${var.game_public_subnet_3}","${var.game_public_subnet_4}"]
  name = "asg-${var.game_name}-lc-micro}"
  max_size = "${var.asg_max}"
  min_size = "${var.asg_min}"
  wait_for_elb_capacity = false
  force_delete = true
  launch_configuration = "${var.game_lc_id}"
  load_balancers = ["${var.game_elb_name}"]
  tag {
    key = "Name"
    value = "${var.game_name}-asg"
    propagate_at_launch = "true"
  }
}

#
# Scale Up Policy and Alarm
#
resource "aws_autoscaling_policy" "game_scale_up" {
  name = "${var.game_name}_asg_scale_up"
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
  cooldown = 300
  autoscaling_group_name = "${aws_autoscaling_group.game_asg.name}"
}
/*resource "aws_cloudwatch_metric_alarm" "game_scale_up_alarm" {
  alarm_name = "${var.game_name}-high-asg-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "80"
  insufficient_data_actions = []
  dimensions {
      AutoScalingGroupName = "${aws_autoscaling_group.game_asg.name}"
  }
  alarm_description = "EC2 HIGH CPU Utilization"
  alarm_actions = ["${aws_autoscaling_policy.game_scale_up.arn}"]
}*/

#
# Scale Down Policy and Alarm
#
resource "aws_autoscaling_policy" "game_scale_down" {
  name = "${var.game_name}_asg_scale_down"
  scaling_adjustment = -1
  adjustment_type = "ChangeInCapacity"
  cooldown = 600
  autoscaling_group_name = "${aws_autoscaling_group.game_asg.name}"
}

/*resource "aws_cloudwatch_metric_alarm" "game_scale_down_alarm" {
  alarm_name = "${var.game_name}-low-asg-cpu"
  comparison_operator = "LessThanThreshold"
  evaluation_periods = "5"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"
  insufficient_data_actions = []
  dimensions {
      AutoScalingGroupName = "${aws_autoscaling_group.game_asg.name}"
  }
  alarm_description = "EC2 CPU Low Utilization"
  alarm_actions = ["${aws_autoscaling_policy.game_scale_down.arn}"]
}*/
output "asg_id" {
  value = "${aws_autoscaling_group.game_asg.id}"
}
