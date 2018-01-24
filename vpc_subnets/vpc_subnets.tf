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
resource "aws_vpc" "game_vpc" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
      Name = "${var.game_name}_vpc"
  }
}
resource "aws_internet_gateway" "game_igw" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  tags {
      Name = "${var.game_name}_igw"
  }
}
output "vpc_id" {
  value = "${aws_vpc.game_vpc.id}"
}

#
# Public Subnets corresponding to 4 subnets
#
resource "aws_subnet" "game_public_subnet_1" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  cidr_block = "${var.public_subnet_1_cidr}"
  availability_zone = "${element(var.availability_zones, 1)}"
  map_public_ip_on_launch = true
depends_on              = ["aws_internet_gateway.game_igw"]
  tags {
      Name = "${var.game_name}_public_subnet_1"
  }
}
output "game_public_subnet_1_cidr" {
  value = "${aws_subnet.game_public_subnet_1.id}"
}
resource "aws_subnet" "game_public_subnet_2" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  cidr_block = "${var.public_subnet_2_cidr}"
  availability_zone = "${element(var.availability_zones, 2)}"
  map_public_ip_on_launch = true
depends_on              = ["aws_internet_gateway.game_igw"]
  tags {
      Name = "${var.game_name}_public_subnet_2"
  }
}
output "game_public_subnet_2_cidr" {
  value = "${aws_subnet.game_public_subnet_2.id}"
}
resource "aws_subnet" "game_public_subnet_3" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  cidr_block = "${var.public_subnet_3_cidr}"
  availability_zone = "${element(var.availability_zones, 3)}"
  map_public_ip_on_launch = true
depends_on              = ["aws_internet_gateway.game_igw"]
  tags {
      Name = "${var.game_name}_public_subnet_3"
  }
}
output "game_public_subnet_3_cidr" {
  value = "${aws_subnet.game_public_subnet_3.id}"
}
resource "aws_subnet" "game_public_subnet_4" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  cidr_block = "${var.public_subnet_4_cidr}"
  availability_zone = "${element(var.availability_zones, 0)}"
  map_public_ip_on_launch = true
depends_on              = ["aws_internet_gateway.game_igw"]
  tags {
      Name = "${var.game_name}_public_subnet_4"
  }
}
output "game_public_subnet_4_cidr" {
  value = "${aws_subnet.game_public_subnet_4.id}"
}

resource "aws_route_table" "game_route_table" {
  vpc_id = "${aws_vpc.game_vpc.id}"
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.game_igw.id}"
  }
  tags {
      Name = "${var.game_name}_subnet_route_table"
  }
}

resource "aws_route_table_association" "game_public_subnet_1" {
  subnet_id = "${aws_subnet.game_public_subnet_1.id}"
  route_table_id = "${aws_route_table.game_route_table.id}"
}
resource "aws_route_table_association" "game_public_subnet_2" {
  subnet_id = "${aws_subnet.game_public_subnet_2.id}"
  route_table_id = "${aws_route_table.game_route_table.id}"
}
resource "aws_route_table_association" "game_public_subnet_3" {
  subnet_id = "${aws_subnet.game_public_subnet_3.id}"
  route_table_id = "${aws_route_table.game_route_table.id}"
}
resource "aws_route_table_association" "game_public_subnet_4" {
  subnet_id = "${aws_subnet.game_public_subnet_4.id}"
  route_table_id = "${aws_route_table.game_route_table.id}"
}
resource "aws_main_route_table_association" "game_route_table" {
	vpc_id = "${aws_vpc.game_vpc.id}"
	route_table_id = "${aws_route_table.game_route_table.id}"
}
