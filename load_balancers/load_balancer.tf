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
resource "aws_elb" "game_prod_lb" {
  name = "${var.game_name}-prod-lb"
  //subnets = ["${var.game_public_subnet_1}"]
  #availability_zones =["us-east-1a","us-east-1c","us-east-1d","us-east-1e"]
  #subnets = ["${split(",", "${var.game_public_subnet_1},${var.game_public_subnet_2},${var.game_public_subnet_3},${var.game_public_subnet_4}")}"]
  //availability_zones =["${var.game_public_subnet_1}","${var.game_public_subnet_2}","${var.game_public_subnet_3}","${var.game_public_subnet_4}"]
  subnets = ["${var.game_public_subnet_1}","${var.game_public_subnet_2}","${var.game_public_subnet_3}","${var.game_public_subnet_4}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 4
    unhealthy_threshold = 10
    timeout = 5
    target = "HTTP:80/ping.html"
    interval = 40
  }
  security_groups = ["${var.game_http_inbound_sg_id}"]
  tags {
      Name = "${var.game_name}-prod-lb"
  }
}
output "game_elb_name" {
  value = "${aws_elb.game_prod_lb.name}"
}
