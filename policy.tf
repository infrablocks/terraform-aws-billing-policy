locals {
  read_actions = [
    "aws-portal:ViewBilling",
    "aws-portal:ViewAccount",
    "aws-portal:ViewUsage",
    "aws-portal:ViewPaymentMethods",
    "awsbillingconsole:ViewBilling",
    "awsbillingconsole:ViewAccount",
    "awsbillingconsole:ViewUsage",
    "awsbillingconsole:ViewPaymentMethods",
    "budgets:ViewBudget",
    "cur:DescribeReportDefinitions",
    "pricing:DescribeServices",
    "pricing:GetAttributeValues",
    "pricing:GetProducts",
  ]
  account_management_actions = [
    "aws-portal:ModifyAccount",
    "awsbillingconsole:ModifyAccount",
  ]
  payment_method_management_actions = [
    "aws-portal:ModifyPaymentMethods",
    "awsbillingconsole:ModifyPaymentMethods",
  ]
  billing_management_actions = [
    "aws-portal:ModifyBilling",
    "awsbillingconsole:ModifyBilling",
  ]
  budget_management_actions = [
    "budgets:ModifyBudget",
  ]
  cost_and_usage_report_management_actions = [
    "cur:PutReportDefinition",
    "cur:DeleteReportDefinition",
    "cur:ModifyReportDefinition"
  ]
}

data "aws_iam_policy_document" "billing_policy" {
  statement {
    effect  = "Allow"
    actions = concat(
      local.read_actions,
      local.allow_account_management == "yes" ? local.account_management_actions : [],
      local.allow_payment_method_management == "yes" ? local.payment_method_management_actions : [],
      local.allow_billing_management == "yes" ? local.billing_management_actions : [],
      local.allow_budget_management == "yes" ? local.budget_management_actions : [],
      local.allow_cost_and_usage_report_management == "yes" ? local.cost_and_usage_report_management_actions : [],
    )
    resources = ["*"]
  }
}

resource "aws_iam_policy" "billing_policy" {
  name        = var.policy_name
  description = var.policy_description
  policy      = data.aws_iam_policy_document.billing_policy.json
}
