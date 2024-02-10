locals {
  name     = "rent-a-crowd-mssql"
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.name

  engine               = "sqlserver-ex"
  engine_version       = "16.00"
  family               = "sqlserver-ex-16.0" # DB parameter group
  major_engine_version = "16.00"             # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 30

  # Encryption at rest is not available for DB instances running SQL Server Express Edition
  storage_encrypted = false

  username = "bbdRentACrowd"
  port     = 1433

  multi_az = false

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
  # enabled_cloudwatch_logs_exports = ["error"]
  # create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  create_db_parameter_group = false
  timezone                  = "GMT Standard Time"
  character_set_name        = "Latin1_General_CI_AS"

  create_db_option_group = false
}
