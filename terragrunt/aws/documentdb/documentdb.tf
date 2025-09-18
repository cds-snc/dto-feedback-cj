resource "aws_docdb_cluster" "main" {
  cluster_identifier      = "${var.product_name}-${var.env}-documentdb-cluster"
  engine                  = "docdb"
  master_username         = var.docdb_master_username
  master_password         = var.docdb_master_password
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_docdb_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.docdb_sg.id]
  apply_immediately       = true
}

resource "aws_docdb_cluster_instance" "main" {
  count              = var.docdb_instance_count
  identifier         = "${var.product_name}-${var.env}-documentdb-instance-${count.index}"
  cluster_identifier = aws_docdb_cluster.main.id
  instance_class     = var.docdb_instance_class
  engine             = "docdb"
  apply_immediately  = true
}

resource "aws_docdb_subnet_group" "main" {
  name       = "${var.product_name}-${var.env}-docdb-subnet-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name        = "${var.product_name}-${var.env}-docdb-subnet-group"
    Environment = var.env
  }
}

resource "aws_security_group" "docdb_sg" {
  name        = "${var.product_name}-${var.env}-docdb-sg"
  description = "Allow access to DocumentDB from ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [var.ecs_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.product_name}-${var.env}-docdb-sg"
    Environment = var.env
  }
}