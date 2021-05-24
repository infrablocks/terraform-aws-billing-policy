data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "billing_policy" {
  # This makes absolutely no sense. I think there's a bug in terraform.
  source = "./../../../../../../../"

  policy_name = var.policy_name
  policy_description = var.policy_description

  allow_account_management = var.allow_account_management
  allow_payment_method_management = var.allow_payment_method_management
  allow_billing_management = var.allow_billing_management
  allow_budget_management = var.allow_budget_management
  allow_cost_and_usage_report_management = var.allow_cost_and_usage_report_management
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    principals {
      identifiers = [
        data.aws_caller_identity.current.arn
      ]
      type = "AWS"
    }

    actions = [
      "sts:AssumeRole"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_role" "target_role" {
  name = "target-role-${var.deployment_identifier}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "target_role" {
  role = aws_iam_role.target_role.name
  policy_arn = module.billing_policy.policy_arn
}
