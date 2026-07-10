inputs = {
  account_id       = "992382783569"
  env              = "staging"
  cost_center_code = "feedback-cronjob-staging"
  region           = "ca-central-1"
  product_name     = "feedback-cronjob"

  # Security group ID from feedback-viewer repo (for cross-repo DocumentDB access)
  # TODO: Set this when feedback-viewer is re-enabled. Get the new SG ID by running:
  # aws ec2 describe-security-groups --filters "Name=group-name,Values=feedback-viewer-security-group" --query "SecurityGroups[0].GroupId" --output text
  # Left empty intentionally — old SG (sg-067eafbbfa8bef47c) was deleted. Rule is skipped while empty.
  feedback_viewer_security_group_id = ""
}