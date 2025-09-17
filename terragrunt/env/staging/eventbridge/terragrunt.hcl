terraform {
  source = "../../../aws//eventbridge"
}

dependencies {
  paths = ["../network", "../iam", "../ecs"]
}

dependency "network" {
  config_path                             = "../network"
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    vpc_private_subnet_ids = [""]
  }
}

dependency "iam" {
  config_path                             = "../iam"
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    ecs_role_arn = ""
  }
}

dependency "ecs" {
  config_path                             = "../ecs"
  mock_outputs_allowed_terraform_commands = ["init", "fmt", "validate", "plan", "show"]
  mock_outputs_merge_with_state           = true
  mock_outputs = {
    cluster_arn                 = ""
    task_definition_arn         = ""
    ecs_tasks_security_group_id = ""
  }
}

inputs = {
  cluster_arn             = dependency.ecs.outputs.cluster_arn
  task_definition_arn     = dependency.ecs.outputs.task_definition_arn
  task_execution_role_arn = dependency.iam.outputs.ecs_role_arn
  task_role_arn           = dependency.iam.outputs.ecs_role_arn
  vpc_private_subnet_ids  = dependency.network.outputs.vpc_private_subnet_ids
  security_group_id       = dependency.ecs.outputs.ecs_tasks_security_group_id
}

include {
  path = find_in_parent_folders("root.hcl")
}