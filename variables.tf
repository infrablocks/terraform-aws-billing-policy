variable "policy_name" {
  type = string
  description = "The name of the policy to create."
}

variable "policy_description" {
  type = string
  description = "The description of the policy to create."
}

variable "allow_account_management" {
  type = string
  default = "yes"
  description = "Whether the policy should allow modification of account settings. Defaults to 'yes'."
}

variable "allow_payment_method_management" {
  type = string
  default = "yes"
  description = "Whether the policy should allow modification of payment methods. Defaults to 'yes'."
}

variable "allow_billing_management" {
  type = string
  default = "yes"
  description = "Whether the policy should allow modification of billing settings. Defaults to 'yes'."
}

variable "allow_budget_management" {
  type = string
  default = "yes"
  description = "Whether the policy should allow modification of budgets. Defaults to 'yes'."
}

variable "allow_cost_and_usage_report_management" {
  type = string
  default = "yes"
  description = "Whether the policy should allow modification of cost and usage reports. Defaults to 'yes'."
}
