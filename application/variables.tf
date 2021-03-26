variable "aws_region" {
    default     = "us-west-2"
}
variable "profile" {
  default = "devops"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "asg_max" {
  default = "5"
}

variable "asg_min" {
  default = "1"
}

variable "asg_desired" {
  default = "1"
}

variable "env_type" {
  default = "dev"
}

variable "env_name" {
  default = "api-asg"
}

variable "ami_id" {
  default = "ami-05b622b5fa0269787"
}

variable "key_name" {
  default = "testing-key"
}

variable "volume_type" {
  default = "gp2"
}

variable "disk_size" {
  default = "100"
}

#alb variables
variable "alb_name" {
  default = "vreeti-api-alb"
}

variable "lb_type" {
  default = "application"
}

variable "lb_idle_timeout" {
  default = "3600"
}

variable "tg_alb_target_group" {
  default = "vreeti-api-tg"
}

variable "security_group_name" {
  default = "alb-api-sg"
}

variable "instance-api-sg" {
  default = "api-sg"
}

variable "api_profile" {
  default = "api-instance-profile"
}

variable "api_instance_role" {
  default = "api_instance_role"
}

variable "ingress_from_port" {
    default = "22"
}

variable "ingress_to_port" {
    default = "22"
}

variable "ingress_protocol" {
    default = "tcp"
}

variable "egress_from_port" {
    default = "0"
}

variable "egress_to_port" {
    default = "0"
}

variable "egress_protocol" {
    default = "-1"
}

variable "aws_ingress_cidr_block" {
    description = "cidr blocks inbound traffic for ssh access"
    default = "192.168.0.0/16"
}

variable "aws_egress_cidr_block" {
    description = "cidr blocks outbound traffic for ssh access"
    default = "0.0.0.0/0"
}

variable "ingress_from_port-80" {
    default = "80"
}

variable "ingress_to_port-80" {
    default = "80"
}

variable "ingress_protocol-80" {
    default = "tcp"
}

variable "aws_ingress_cidr_block-80" {
    description = "cidr blocks inbound traffic for ssh access"
    default = "0.0.0.0/0"
}

variable "aws_ingress_cidr_block-instance-80" {
    description = "cidr blocks inbound traffic for ssh access"
    default = "192.168.0.0/16"
}

#s3 bucket variables
variable "bucket_name" {
  description = "bucket name"
  default     = "vreeti-static-website"
}

variable "cors_headers" {
  default = ["Authorization", "Content-Length", "Cache-Control"]
}

variable "cors_methods" {
  default = ["GET"]
}

variable "cors_origins" {
  default = ["*"]
}

variable "cors_exp_headers" {
  default = []
}

variable "cors_max_seconds" {
  default = "3000"
}


variable "ingress_from_port-3306" {
    default = "3306"
}

variable "ingress_to_port-3306" {
    default = "3306"
}

variable "ingress_protocol-3306" {
    default = "tcp"
}

variable "egress_from_port-3306" {
    default = "0"
}

variable "egress_to_port-3306" {
    default = "0"
}

variable "egress_protocol-3306" {
    default = "-1"
}

variable "aws_ingress_cidr_block-3306" {
    description = "cidr blocks inbound traffic for ssh access"
    default = "192.168.0.0/16"
}

variable "aws_egress_cidr_block-3306" {
    description = "cidr blocks outbound traffic for ssh access"
    default = "0.0.0.0/0"
}

variable "mysql-api-sg" {
    default = "mysql-api-sg"
}

variable "final_snapshot_identifier" {
  description = "snapshot"
  default = "vreeti-api-db-final-snapshot"
}

variable "backup_retention_period" {
  description = "backup retention"
  default = "10"
}

variable "storage_type" {
  description = "storage type"
  default = "gp2"
}

variable "allocated_storage" {
  description = "storge"
  default = "20"
}
variable "engine" {
  description = "db engine"
  default = "mysql"
}

variable "engine_version" {
  description = "version"
  default = "8.0.20"
}

variable "max_allocated_storage" {
  description = "max storage"
  default = "150"
}

variable "name" {
  description = "db name"
  default = "vreetidb"
}

variable "username" {
  description = "db username"
  default = "dbadmin"
}

variable "instance_class" {
  description = "instance type"
  default = "db.m5.large"
}

variable "identifier" {
  description = "name"
  default = "vreeti-api-db"
}









