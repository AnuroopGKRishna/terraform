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

/*resource "aws_key_pair" "build_master_key" {
  key_name = "${var.key_name}"
  public_key = "${file("./game/buid-master-key.pub")}"
}*/
resource "aws_instance" "game_buid_master" {
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "${var.instance_type}"
  tags = {
    Name = "build_master"
  }
  subnet_id = "${var.public_subnet_id}"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${var.build_master_ssh_sg_id}"]
key_name = "${var.key_name}"
}