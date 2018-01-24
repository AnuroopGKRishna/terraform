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
variable "availability_zones" {
  # No spaces allowed between az names!
  default =  ["us-east-1a","us-east-1c","us-east-1d","us-east-1e"]
}
variable "asg_min" {
  default = "1"
}
variable "asg_max" {
  default = "1"
}
#
# From other modules
#
variable "game_public_subnet_1" {}
variable "game_public_subnet_2" {}
variable "game_public_subnet_3" {}
variable "game_public_subnet_4" {}
variable "game_lc_id" {}
variable "game_lc_name" {}
variable "game_elb_name" {}
variable "game_name" {}
