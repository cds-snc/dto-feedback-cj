terraform {
  source = "../../../aws//ecs"
}

dependencies {
  paths = ["../iam", "../network", "../ecr", "../ssm", "../database"]
}

dependency "iam" {
  config_path = "../iam"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    ecs_role_arn  = ""
    ecs_role_name = ""
  }
}

dependency "network" {
  config_path                             = "../network"
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    vpc_id                 = ""
    vpc_private_subnet_ids = [""]
  }
}

dependency "ecr" {
  config_path = "../ecr"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    ecr_repository_arn = ""
    ecr_repository_url = ""
  }
}

dependency "ssm" {
  config_path = "../ssm"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    docdb_uri_arn                  = ""
    airtable_api_key_arn           = ""
    google_service_account_key_arn = ""
    airtable_base_arn              = ""
    health_airtable_base_arn       = ""
    cra_airtable_base_arn          = ""
    travel_airtable_base_arn       = ""
    ircc_airtable_base_arn         = ""
  }
}

dependency "database" {
  config_path = "../database"

  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    aws_docdb_security_group_id = ""
    docdb_uri_arn               = ""
  }
}

inputs = {
  task_execution_role_arn        = dependency.iam.outputs.ecs_role_arn
  task_role_arn                  = dependency.iam.outputs.ecs_role_arn
  vpc_private_subnet_ids         = dependency.network.outputs.vpc_private_subnet_ids
  vpc_id                         = dependency.network.outputs.vpc_id
  ecr_repository_url             = dependency.ecr.outputs.ecr_repository_url
  ecr_repository_arn             = dependency.ecr.outputs.ecr_repository_arn
  docdb_uri_arn                  = dependency.database.outputs.docdb_uri_arn
  airtable_api_key_arn           = dependency.ssm.outputs.airtable_api_key_arn
  google_service_account_key_arn = dependency.ssm.outputs.google_service_account_key_arn
  airtable_base_arn              = dependency.ssm.outputs.airtable_base_arn
  health_airtable_base_arn       = dependency.ssm.outputs.health_airtable_base_arn
  cra_airtable_base_arn          = dependency.ssm.outputs.cra_airtable_base_arn
  travel_airtable_base_arn       = dependency.ssm.outputs.travel_airtable_base_arn
  ircc_airtable_base_arn         = dependency.ssm.outputs.ircc_airtable_base_arn
  aws_docdb_security_group_id    = dependency.database.outputs.aws_docdb_security_group_id
}

include {
  path = find_in_parent_folders("root.hcl")
}