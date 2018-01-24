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
resource "aws_security_group" "game_http_inbound" {
  name = "${var.game_name}_http_inbound"
  description = "Allow HTTP from Anywhere"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_http_inbound"
  }
}
output "game_http_inbound_sg_id" {
  value = "${aws_security_group.game_http_inbound.id}"
}

resource "aws_security_group" "game_http_ipv6_inbound" {
  name = "${var.game_name}_http_ipv6_inbound"
  description = "Allow HTTP for ipv6 from Anywhere"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["::/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["::/0"]
  }
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_http_ipv6_inbound"
  }
}
output "game_http_ipv6_inbound_sg_id" {
  value = "${aws_security_group.game_http_ipv6_inbound.id}"
}

resource "aws_security_group" "game_ssh_inbound_sg" {
  name = "${var.game_name}_ssh_inbound"
  description = "Allow SSH from certain ranges"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_ssh_inbound"
  }
}
output "game_ssh_inbound_sg_id" {
  value = "${aws_security_group.game_ssh_inbound_sg.id}"
}

resource "aws_security_group" "game_outbound_sg" {
  name = "${var.game_name}_outbound"
  description = "Allow outbound connections"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_outbound"
  }
}
output "game_outbound_sg_id" {
  value = "${aws_security_group.game_outbound_sg.id}"
}
#https inbound  for the ipv4
resource "aws_security_group" "game_https_inbound" {
  name = "${var.game_name}_https_inbound"
  description = "Allow HTTPS from Anywhere"
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_https_inbound"
  }
}
output "game_https_inbound_sg_id" {
  value = "${aws_security_group.game_https_inbound.id}"
}
#custom tcp rule for the memcahe connections
resource "aws_security_group" "game_memcache_inbound" {
  name = "${var.game_name}_memcache_inbound"
  description = "Allow memcache  from Anywhere"
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_memcache_inbound"
  }
}
output "game_memcache_inbound_sg_id" {
  value = "${aws_security_group.game_memcache_inbound.id}"
}
#cutom tcp rule for the port 20
resource "aws_security_group" "game_custom_inbound" {
  name = "${var.game_name}_custom_inbound"
  description = "Allow cutom port 20  from Anywhere"
  ingress {
    from_port = 20
    to_port = 20
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_custom_inbound"
  }
}
output "game_custom_inbound_sg_id" {
  value = "${aws_security_group.game_custom_inbound.id}"
}
#cutom tcp rule for the port 8080
resource "aws_security_group" "game_jenkins_inbound" {
  name = "${var.game_name}_jenkins_inbound"
  description = "Allow cutom port 8080  from Anywhere"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_jenkins_inbound"
  }
}
output "game_jenkins_inbound_sg_id" {
  value = "${aws_security_group.game_jenkins_inbound.id}"
}
#cutom tcp rule for the port 8888
resource "aws_security_group" "game_custom_jenkins_inbound" {
  name = "${var.game_name}_custom_jenkins_inbound"
  description = "Allow cutom port 8888  from Anywhere"
  ingress {
    from_port = 8888
    to_port = 8888
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_custom_jenkins_inbound"
  }
}
output "game_custom_jenkins_inbound_sg_id" {
  value = "${aws_security_group.game_custom_jenkins_inbound.id}"
}
#cutom udp rule for the port 11211
resource "aws_security_group" "game_custom_udp_inbound" {
  name = "${var.game_name}_custom_udp_inbound"
  description = "Allow cutom udp port 11211  from Anywhere"
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_custom_udp_inbound"
  }
}
output "game_custom_udp_inbound_sg_id" {
  value = "${aws_security_group.game_custom_udp_inbound.id}"
}
