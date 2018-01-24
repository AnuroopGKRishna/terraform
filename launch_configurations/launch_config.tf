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
resource "aws_launch_configuration" "game_lc_prod" {
  lifecycle { create_before_destroy = true }
  image_id = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  security_groups = [
    "${var.game_http_inbound_sg_id}",
    "${var.game_ssh_inbound_sg_id}",
    "${var.game_outbound_sg_id}",
    "${var.game_custom_udp_inbound_sg_id}",
    "${var.game_custom_jenkins_inbound_sg_id}",
    "${var.game_jenkins_inbound_sg_id}",
    "${var.game_custom_inbound_sg_id}",
    "${var.game_memcache_inbound_sg_id}",
    "${var.game_https_inbound_sg_id}",
    "${var.game_http_ipv6_inbound_sg_id}"    
  ]
  user_data = "${file("./launch_configurations/userdata.sh")}"
 key_name = "${var.key_name}"
  #key_name = "${aws_key_pair.build_master_key.key_name}"
  associate_public_ip_address = true
  name = "${var.game_name}-lc-prod"
}
output "game_lc_id" {
  value = "${aws_launch_configuration.game_lc_prod.id}"
}
output "game_lc_name" {
  value = "${aws_launch_configuration.game_lc_prod.name}"
}
/*resource "aws_key_pair" "build_master_key" {
  key_name = "${var.key_name}"
  public_key = "${file("./game/root-devops-key-pair.pub")}"
}*/
