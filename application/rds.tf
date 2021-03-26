resource "aws_db_instance" "mysql-database" {
    engine                          = var.engine
    engine_version                  = var.engine_version
    identifier                      = var.identifier
    instance_class                  = var.instance_class
    name                            = var.name
    username                        = var.username
    password                        = data.aws_ssm_parameter.db-password.value
    multi_az                        = true
    allocated_storage               = var.allocated_storage
    max_allocated_storage           = var.max_allocated_storage
    storage_encrypted               = true
    storage_type                    = var.storage_type
    performance_insights_enabled    = false
    backup_retention_period         = var.backup_retention_period
    final_snapshot_identifier       = var.final_snapshot_identifier
    vpc_security_group_ids          = [aws_security_group.allow-mysql-only.id]
    db_subnet_group_name            = aws_db_subnet_group.api_subnet_group.name
    publicly_accessible             = false
    
    
    tags = {
        Name                        = "vreeti-api-db"
        environment                 = var.env_type
        terraform                   = "true"
    }
  
}

resource "aws_db_subnet_group" "api_subnet_group" {
    name                            = "api-db-subnet-group"
    subnet_ids                      = data.aws_subnet_ids.private.ids

    tags = {
        terraform = "true"
    }
}

data "aws_ssm_parameter" "db-password" {
  name                              = "/dev/vreeti-api-db/vreeti-api-db-password"
}

resource "aws_security_group" "allow-mysql-only" {
    name = var.mysql-api-sg
    description = "Allow mysql inbound traffic"
    vpc_id = module.vpc.vpc_id
    #SSH access
    ingress {
        from_port = var.ingress_from_port-3306
        to_port = var.ingress_to_port-3306
        protocol = var.ingress_protocol-3306
        cidr_blocks = [var.aws_ingress_cidr_block-3306]
    }

    #outbound internet access
    egress {
        from_port = var.egress_from_port-3306
        to_port = var.egress_to_port-3306
        protocol = var.egress_protocol-3306
        cidr_blocks = [var.aws_egress_cidr_block-3306]
    }      
}
