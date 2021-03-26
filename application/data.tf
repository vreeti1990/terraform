data "template_file" "user_data" {
  template = file("user_data.sh")
}

data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Tier = "Private"
  }
  depends_on = [module.vpc]
}

data "aws_subnet_ids" "public" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Tier = "Public"
  }
  depends_on = [module.vpc]
}


