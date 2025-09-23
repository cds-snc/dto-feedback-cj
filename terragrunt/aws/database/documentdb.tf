# Terraform code to create an Amazon DocumentDB cluster for feedback-cronjob

# Retrieve the username and password from the SSM parameter store
data "aws_ssm_parameter" "docdb_username" {
  name = var.docdb_username_name
}

data "aws_ssm_parameter" "docdb_password" {
  name = var.docdb_password_name
}

# Create a security group for the DocumentDB cluster
resource "aws_security_group" "feedback_cronjob_docdb_sg" {
  name        = "${var.product_name}-docdb-sg"
  description = "Security group for DocumentDB for the ${var.product_name} app"
  vpc_id      = var.vpc_id

  # Inbound rules (ingress): Allow traffic on the DocDB port (27017) from your VPC CIDR
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Outbound rules (egress): Allow all traffic outbound but only to destinations within the cidr block. 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

# DocumentDB Subnet Group
resource "aws_docdb_subnet_group" "feedback_cronjob_docdb_subnet_group" {
  name        = "${var.product_name}-docdb-subnet-group"
  description = "Subnet group for DocumentDB for the ${var.product_name} ${var.env} app"
  subnet_ids  = var.vpc_private_subnet_ids

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

# DocumentDB Cluster Parameter Group
resource "aws_docdb_cluster_parameter_group" "feedback_cronjob_docdb_cluster_parameter_group" {
  name        = "${var.product_name}-docdb-cluster-parameter-group"
  family      = "docdb5.0" # Latest engine version
  description = "Parameter group for ${var.product_name} ${var.env} DocumentDB"

  # Parameter overrides. Enabled TLS encryption.
  parameter {
    name  = "tls"
    value = "enabled"
  }

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

# DocumentDB Cluster
resource "aws_docdb_cluster" "feedback_cronjob_docdb_cluster" {
  cluster_identifier              = "${var.product_name}-docdb-cluster"
  engine                          = "docdb"
  engine_version                  = "5.0.0" # DocDB engine version
  master_username                 = data.aws_ssm_parameter.docdb_username.value
  master_password                 = data.aws_ssm_parameter.docdb_password.value
  db_subnet_group_name            = aws_docdb_subnet_group.feedback_cronjob_docdb_subnet_group.name
  vpc_security_group_ids          = [aws_security_group.feedback_cronjob_docdb_sg.id] # SG for the DocumentDB cluster
  storage_encrypted               = true
  apply_immediately               = true
  skip_final_snapshot             = true
  port                            = 27017
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.feedback_cronjob_docdb_cluster_parameter_group.name

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

# DocumentDB Cluster Instance
resource "aws_docdb_cluster_instance" "feedback_cronjob_docdb_instance" {
  count              = var.docdb_instance_count
  identifier         = "${var.product_name}-docdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.feedback_cronjob_docdb_cluster.id
  instance_class     = var.docdb_instance_class
  engine             = "docdb"
  apply_immediately  = true

  tags = {
    CostCentre = var.billing_code
    Terraform  = true
  }
}

# Create an SSM parameter to store the docdb uri
resource "aws_ssm_parameter" "docdb_uri" {
  name       = "/${var.product_name}/${var.env}/docdb-uri"
  type       = "SecureString"
  value      = "mongodb://${data.aws_ssm_parameter.docdb_username.value}:${data.aws_ssm_parameter.docdb_password.value}@${aws_docdb_cluster.feedback_cronjob_docdb_cluster.endpoint}:27017/pagesuccess?tls=true&replicaSet=rs0&readPreference=secondaryPreferred&retryWrites=false"
  depends_on = [aws_docdb_cluster_instance.feedback_cronjob_docdb_instance]
}
