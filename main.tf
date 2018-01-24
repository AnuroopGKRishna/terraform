
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
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}
module "vpc_subnets" {
  source = "./vpc_subnets"
  key_name = "${var.key_name}"
  ip_range = "${var.ip_range}"
  game_name="${var.game_name}"
}
module "launch_configurations" {
  source = "./launch_configurations"
  game_http_inbound_sg_id = "${module.vpc_subnets.game_http_inbound_sg_id}"
  game_ssh_inbound_sg_id = "${module.vpc_subnets.game_ssh_inbound_sg_id}"
  game_outbound_sg_id = "${module.vpc_subnets.game_outbound_sg_id}"
  game_http_ipv6_inbound_sg_id = "${module.vpc_subnets.game_http_ipv6_inbound_sg_id}"
  game_custom_udp_inbound_sg_id = "${module.vpc_subnets.game_custom_udp_inbound_sg_id}"
  game_custom_jenkins_inbound_sg_id = "${module.vpc_subnets.game_custom_jenkins_inbound_sg_id}"
  game_jenkins_inbound_sg_id = "${module.vpc_subnets.game_jenkins_inbound_sg_id}"
  game_custom_inbound_sg_id = "${module.vpc_subnets.game_custom_inbound_sg_id}"
  game_memcache_inbound_sg_id = "${module.vpc_subnets.game_memcache_inbound_sg_id}"
  game_https_inbound_sg_id = "${module.vpc_subnets.game_https_inbound_sg_id}"
  key_name = "${var.key_name}"
  game_name="${var.game_name}"
}
module "load_balancers" {
  source = "./load_balancers"
  game_public_subnet_1 ="${module.vpc_subnets.game_public_subnet_1_cidr}"
  game_public_subnet_2 ="${module.vpc_subnets.game_public_subnet_2_cidr}"
  game_public_subnet_3= "${module.vpc_subnets.game_public_subnet_3_cidr}"
  game_public_subnet_4= "${module.vpc_subnets.game_public_subnet_4_cidr}"
  game_http_inbound_sg_id = "${module.vpc_subnets.game_http_inbound_sg_id}"
  game_name="${var.game_name}"
}
module "autoscaling_groups" {
  source = "./autoscaling_groups"
  game_public_subnet_1 ="${module.vpc_subnets.game_public_subnet_1_cidr}"
  game_public_subnet_2 ="${module.vpc_subnets.game_public_subnet_2_cidr}"
  game_public_subnet_3= "${module.vpc_subnets.game_public_subnet_3_cidr}"
  game_public_subnet_4= "${module.vpc_subnets.game_public_subnet_4_cidr}"
  game_lc_id = "${module.launch_configurations.game_lc_id}"
  game_lc_name = "${module.launch_configurations.game_lc_name}"
  game_elb_name = "${module.load_balancers.game_elb_name}"
  game_name="${var.game_name}"

  }

/*
module "s3bucket" {
source = "./s3bucket"
game_name="${var.game_name}"
}

module "dynamodb" {
source = "./dynamodb"
game_name="${var.game_name}"
}



  module "build_master" {
    source = "./build_master"
    public_subnet_id = "${module.vpc_subnets.game_public_subnet_1_cidr}"
    build_master_ssh_sg_id = "${module.vpc_subnets.game_ssh_inbound_sg_id}"
    game_http_ipv6_inbound_sg_id = "${module.vpc_subnets.game_http_ipv6_inbound_sg_id}"
    game_custom_udp_inbound_sg_id = "${module.vpc_subnets.game_custom_udp_inbound_sg_id}"
    game_custom_jenkins_inbound_sg_id = "${module.vpc_subnets.game_custom_jenkins_inbound_sg_id}"
    game_jenkins_inbound_sg_id = "${module.vpc_subnets.game_jenkins_inbound_sg_id}"
    game_custom_inbound_sg_id = "${module.vpc_subnets.game_custom_inbound_sg_id}"
    game_memcache_inbound_sg_id = "${module.vpc_subnets.game_memcache_inbound_sg_id}"
    game_https_inbound_sg_id = "${module.vpc_subnets.game_https_inbound_sg_id}"
    key_name = "${var.key_name}"
  }
*/
