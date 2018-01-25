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
# Defines a user that should be able to write to production  bucket
resource "aws_iam_user" "aws_s3_user" {
    name = "${var.game_name}-s3-bucket-user"
}

resource "aws_iam_access_key" "aws_s3_user" {
    user = "${aws_iam_user.aws_s3_user.name}"
}

resource "aws_iam_user_policy" "aws_s3_user_role" {
    name = "${var.game_name}-s3-bucket-user-policy"
    user = "${aws_iam_user.aws_s3_user.name}"
    policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.game_name}-assets",
                "arn:aws:s3:::${var.game_name}-assets/*",
                "arn:aws:s3:::${var.game_name}",
                "arn:aws:s3:::${var.game_name}/*"
            ]
        }
   ]
}
EOF
}

resource "aws_s3_bucket" "s3_bucket_assets" {
    bucket = "${var.game_name}-assets"
    acl = "private"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST","GET","DELETE"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.game_name}-assets/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.aws_s3_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.game_name}-assets",
                "arn:aws:s3:::${var.game_name}-assets/*"
            ]
        }
    ]
}
EOF
}

resource "aws_s3_bucket" "prod_bucket" {
    bucket = "${var.game_name}"
    acl = "private"

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["PUT","POST","GET","DELETE"]
        allowed_origins = ["*"]
        expose_headers = ["ETag"]
        max_age_seconds = 3000
    }

    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.game_name}/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.aws_s3_user.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${var.game_name}",
                "arn:aws:s3:::${var.game_name}/*"
            ]
        }
    ]
}
EOF
}
