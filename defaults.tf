locals {
  # default for cases when `null` value provided, meaning "use default"
  allow_account_management               = var.allow_account_management == null ? "yes" : var.allow_account_management
  allow_payment_method_management        = var.allow_payment_method_management == null ? "yes" : var.allow_payment_method_management
  allow_billing_management               = var.allow_billing_management == null ? "yes" : var.allow_billing_management
  allow_budget_management                = var.allow_budget_management == null ? "yes" : var.allow_budget_management
  allow_cost_and_usage_report_management = var.allow_cost_and_usage_report_management == null ? "yes" : var.allow_cost_and_usage_report_management
}
