#!/bin/bash
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
rm /var/www/html/ping.html
echo $PATH > /home/ubuntu/initialPath
export PATH=$PATH:/usr/local/bin
echo $PATH > /home/ubuntu/finalPath
date > /home/ubuntu/startTime
#aws s3 sync --exclude ".svn/*"  --delete s3://aws.game_s3_folder /var/www/html/game_name  > /home/ubuntu/syncLog 2>&1;
echo "OK" > /var/www/html/ping.html
date > /home/ubuntu/endTime
chown ubuntu:www-data /var/www/html/ping.html
#chown -R ubuntu:www-data /var/www/html/game_name
service ntp stop
ntpd -gq
service ntp start
