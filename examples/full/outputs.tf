output "policy_arn" {
  value = module.billing_policy.policy_arn
}

output "target_role_arn" {
  value = aws_iam_role.target_role.arn
}
