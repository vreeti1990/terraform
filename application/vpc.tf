#Uses terraform-aws-modules/terraform-aws-vpc to provision VPC resources
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "main"
  cidr = "192.168.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["192.168.1.0/24", "192.168.3.0/24", "192.168.5.0/24"]
  private_subnet_tags = {
    Tier = "Private"
  }
  public_subnets  = ["192.168.2.0/24", "192.168.4.0/24", "192.168.6.0/24"]
  public_subnet_tags = {
    Tier = "Public"
  }

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true
  nat_gateway_tags = {
      Name = "main-nat-gw"
      terraform   = "true"
      environment = "dev"
      }
 nat_eip_tags = {
      Name = "main-nat-gw-eip"
      terraform   = "true"
      environment = "dev"
      }

 enable_s3_endpoint = true

  tags = {
    environment = "dev"
    terraform   = "true"
  }
}