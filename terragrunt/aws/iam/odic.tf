locals {
  feedback_cronjob_plan = "feedback-cronjob-plan"
}

module "github_workflow_roles" {
  source            = "github.com/cds-snc/terraform-modules//gh_oidc_role?ref=v10.4.1"
  billing_tag_value = var.billing_code

  roles = [
    {
      name      = local.feedback_cronjob_plan
      repo_name = "dto-feedback-cj"
      claim     = "*"
    }
  ]
}

resource "aws_iam_role_policy_attachment" "feedback_cronjob_plan" {
  role       = local.feedback_cronjob_plan
  policy_arn = data.aws_iam_policy.admin.arn
  depends_on = [
    module.github_workflow_roles
  ]
}

data "aws_iam_policy" "admin" {
  # checkov:skip=CKV_AWS_275:This policy is required for the Terraform apply
  name = "AdministratorAccess"
}
