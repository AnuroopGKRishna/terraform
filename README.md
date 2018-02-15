AWS Infastructure creation wiht  Terraform module
------

# terraform-aws

This project explains creation of vpc,load balancer,auto scaling group,launch configuration ,s3 bucket ,rds instance and an elastic cache running on AWS, using Terraform. .

## Prerequisites

Please install the following components:

1. [Docker](https://docs.docker.com/engine/installation/mac)
0. [Terraform](https://www.terraform.io/intro/getting-started/install.html) - `brew update && brew install terraform`.

You must also have an AWS account. If you don't, this  [AWS Free Tier](https://aws.amazon.com/free/) which only takes ten minutes to sign up with.

 Set up your AWS credentials. The preferred way is to install the AWS CLI and quickly run `aws configure`:

```
$ aws configure
AWS Access Key ID [None]: <Enter Access Key ID>
AWS Secret Access Key [None]: <Enter Secret Key>
Default region name [None]: us-east-1
Default output format [None]:
```

This will keep your AWS credentials in the `$HOME/.aws/credentials` file, which Terraform can use. This and all other options are documented in the [Terraform: AWS Provider](https://www.terraform.io/docs/providers/aws/index.html) documentation.

## Creating the Infastructure

The Infastructure is implemented as a [Terraform Module](https://www.terraform.io/docs/modules/index.html).

Before  we apply the terraform provide the default vaaribles in variables.tf so that it can be used globally
````
variable "game_name"
{
  default="name" #rename the default name to corresponding game
}
variable "aws_access_key" {
  default="key"
}
variable "aws_secret_key" {
  default = "secret"
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
  default = "key_pair"
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
    us-east-1 = "ami-id"
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

````
## Adding the key pair

Create a private key from the aws account and using the private key create a public key by using the commands as given below.(.pem to .pub)

```
ssh-keygen -y -f mykey.pem > mykey.pub

```

Then  run the following commands in the current project directory
```
#initialzing the terraform  for creating
terraform get

#  do a dry run!
terraform plan

# communicate with aws account and creates the Infastructure!
terraform apply
```
## Destroying the Infastructure

Bring everything down with:

```
terraform destroy
```

## Project Structure

The module has the following structure:

```
main.tf                                     # Infastructure definition.
variables.tf                                # Basic config.
vpc_subnets/vpc_subnets.tf                  # Network configuration. Defines the VPC, subnets, access etc.
vpc_subnets/variables.tf                    # Inputs for creating vpc and subnets.
vpc_subnets/vpc_subnets_sg.tf               # Creating vpc and subnets security groups.
launch_configurations/launch_config.tf      # Creation of launch configuration.
launch_configurations/variables.tf          # Inputs for creating launch configurations.
launch_configurations/userdata.sh           # Script for the syncing app data.
load_balancers/load_balancer.tf             # Creation of classic load balancer that can be attached to an autoscaling group.
load_balancers/variables.tf                 # Inputs for creating load balancer.
autoscaling_groups/asg_config.tf            # Creation of an auto scaling group that have min 1 instance and have a load balancer attached to it.
autoscaling_groups/variables.tf             # Inputs for creating  autoscaling group.
s3bucket/s3bucket_config.tf                 # Creates an s3 bucket with an iam user role  and permissions.
s3bucket/variables.tf                       # Inputs for creating   s3bucket.
rds_instance/rds_conf.tf                    # RDS instance is created with corresponding vpc and subnets
rds_instance/variables.tf                   # Inputs for creating rds instance.
memcache/memcache_config.tf                 # Creates a memcache cluster and node inside the vpc(elastic cache) .
memcache/variables.tf                       # Inputs for creating memcache.
dynamodb/dynamo_config.tf                   # Creates a dynamodb table with id as primary key .
dynamodb/variables.tf                       # Inputs for creating dynamodb table.
build_master/build_master_config.tf         # Creates a master server where the repository of the app lies and contains the code to sync to other ec2 instances .
build_master/variables.tf                   # Inputs for creating build_master table.
game/                                       # Here we provide the key pair for the aws account that can be access to login to instances                                             

```

## Troubleshooting

**Trying to `plan` or `apply` gives the error `No valid credential sources found for AWS Provider.`**

This means you've not set up your AWS credentials - check the [Prerequisites](#Prerequisites) section of this guide and try again, or check here: https://www.terraform.io/docs/providers/aws/index.html.



Tested 11/01/18, terraform 0.10.2

License

Apache 2 Licensed. See LICENSE for full details.
