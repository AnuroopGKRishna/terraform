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
#specifiy the game name
variable "game_name"
{
  default="vacationbingo" #rename the default name to corresponding game
}
variable "aws_access_key" {
  default="AKIAIV4YQ3V6GK7FMFFQ"
}
variable "aws_secret_key" {
  default = "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"
}
#specifies default region
variable "region" {
  default ="us-east-1"
}
#specifies the ip range to be included in the vpc
variable "ip_range" {
  default="0.0.0.0/0"
}
#specifies the avialablity zone according to the user account settings
variable "availability_zones" {
 default=["us-east-1a","us-east-1c","us-east-1d","us-east-1e"]
}
#specifies the which instance type need to be added to the asg group
variable "instance_type" {
  default = "t2.micro"
}
#specifies the  private key to connect via ssh to different instances
variable "key_name" {
  default = "root-devops-key-pair"
}
#specifies the  auto scaling group min no of instace to be attached
variable "asg_min" {
  default = "1"
}
#specifies the max instances upto which the auto caling can be done
variable "asg_max" {
  default = "1"
}
#spefies the desired no of instace for the auto scaling group
variable "asg_desired" {
  default = "1"
}
# Amazon Linux AMI
# ami-with the initial game structure
variable "amis" {
  default = {
    us-east-1 = "ami-60b6c60a"
  }
}
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default = "172.33.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "CIDR for the Public  Subnet"
  default = "172.33.16.0/20"
}
variable "public_subnet_2_cidr" {
  description = "CIDR for the Public Subnet"
  default = "172.33.32.0/20"
}
variable "public_subnet_3_cidr" {
  description = "CIDR for the Public Subnet"
  default = "172.33.64.0/20"
}
variable "public_subnet_4_cidr" {
  description = "CIDR for the Public Subnet"
  default = "172.33.0.0/20"
}
