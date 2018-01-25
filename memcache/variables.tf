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
variable "project" {
  default = "game"
}

variable "environment" {
  default = "production"
}

variable "vpc_id" {}

/*variable "cache_identifier" {
  default="memcahe"
}*/

variable "parameter_group" {
  default = "default.memcached1.4"
}

variable "subnet_group" {
  default="cache-subnet"
}

/*variable "maintenance_window" {
  default="sun:05:00-sun:09:00"
}*/

variable "desired_clusters" {
  default = "1"
}

variable "instance_type" {
  default = "cache.t2.micro"
}

variable "engine_version" {
  default = "1.4.34"
}

//variable "notification_topic_arn" {}

variable "alarm_cpu_threshold_percent" {
  default = "75"
}

variable "alarm_memory_threshold_bytes" {
  # 10MB
  default = "10000000"
}

/*variable "alarm_actions" {
  type = "list"
}*/
variable "game_public_subnet_1" {}
variable "game_public_subnet_2" {}
variable "game_public_subnet_3" {}
variable "game_public_subnet_4" {}
variable "game_name" {}
