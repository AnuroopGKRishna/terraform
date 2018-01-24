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
variable "region" {
  default = "us-east-1"
}
variable "key_name" {}
variable "instance_type" {
  default = "t2.micro"
}
# Amazon Linux AMI
# Most recent as of 2015-12-02
variable "amis" {
  default = {
     us-east-1 = "ami-2b2b1a51"
  #  us-east-1 = "ami-60b6c60a"
  #  us-west-2 = "ami-f0091d91"
  }
}
#
# From other modules
#
variable "game_http_inbound_sg_id" {}
variable "game_ssh_inbound_sg_id" {}
variable "game_outbound_sg_id" {}
variable "game_name" {}
variable "game_custom_udp_inbound_sg_id" {}
variable "game_custom_jenkins_inbound_sg_id" {}
variable "game_jenkins_inbound_sg_id" {}
variable "game_custom_inbound_sg_id" {}
variable "game_memcache_inbound_sg_id" {}
variable  "game_https_inbound_sg_id" {}
variable  "game_http_ipv6_inbound_sg_id" {}
