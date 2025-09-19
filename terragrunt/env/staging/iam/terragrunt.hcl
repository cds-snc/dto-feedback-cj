terraform {
  source = "../../../aws//iam"
}

dependencies {
  paths = ["../ssm"]
}

dependency "ssm" {
  config_path                             = "../ssm"
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

inputs = {
  docdb_uri_arn                  = dependency.ssm.outputs.docdb_uri_arn
  airtable_api_key_arn           = dependency.ssm.outputs.airtable_api_key_arn
  google_service_account_key_arn = dependency.ssm.outputs.google_service_account_key_arn
  airtable_base_arn              = dependency.ssm.outputs.airtable_base_arn
  health_airtable_base_arn       = dependency.ssm.outputs.health_airtable_base_arn
  cra_airtable_base_arn          = dependency.ssm.outputs.cra_airtable_base_arn
  travel_airtable_base_arn       = dependency.ssm.outputs.travel_airtable_base_arn
  ircc_airtable_base_arn         = dependency.ssm.outputs.ircc_airtable_base_arn
}

include {
  path = find_in_parent_folders("root.hcl")
}