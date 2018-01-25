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
resource "aws_security_group" "memcached_sg" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name        = "sgMemCacheCluster"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

#
# ElastiCache resources
#
resource "aws_elasticache_cluster" "memcached_cluster" {

  lifecycle {
    create_before_destroy = true
  }

  cluster_id             = "${format("%.16s-%.4s", lower(var.game_name), md5(var.instance_type))}"
  engine                 = "memcached"
  engine_version         = "${var.engine_version}"
  node_type              = "${var.instance_type}"
  num_cache_nodes        = "${var.desired_clusters}"
  az_mode                = "${var.desired_clusters == 1 ? "single-az" : "cross-az"}"
  parameter_group_name   = "${var.parameter_group}"
  subnet_group_name      = "${var.subnet_group}"
  security_group_ids     = ["${aws_security_group.memcached_sg.id}"]
  //maintenance_window     = "${var.maintenance_window}"
  //notification_topic_arn = "${var.notification_topic_arn}"
  port                   = "11211"

  tags {
    Name        = "MemCacheCluster"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }
}

resource "aws_elasticache_subnet_group" "subnet_group_elastic_cache" {
  name       = "${var.subnet_group}"
  subnet_ids =["${var.game_public_subnet_1}","${var.game_public_subnet_2}","${var.game_public_subnet_3}","${var.game_public_subnet_4}"]
}

#
# CloudWatch resources
#
/*resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
  alarm_name          = "alarm${var.environment}MemcachedCacheClusterCPUUtilization"
  alarm_description   = "Memcached cluster CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"

  threshold = "${var.alarm_cpu_threshold_percent}"

  dimensions {
    CacheClusterId = "${aws_elasticache_cluster.memcached.id}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}*/

/*resource "aws_cloudwatch_metric_alarm" "cache_memory" {
  alarm_name          = "alarm${var.environment}MemcachedCacheClusterFreeableMemory"
  alarm_description   = "Memcached cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "60"
  statistic           = "Average"

  threshold = "${var.alarm_memory_threshold_bytes}"

  dimensions {
    CacheClusterId = "${aws_elasticache_cluster.memcached.id}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}*/
