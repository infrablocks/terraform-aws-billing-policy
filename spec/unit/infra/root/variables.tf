variable "region" {}

variable "deployment_identifier" {}

variable "policy_name" {}
variable "policy_description" {}

variable "allow_account_management" {
  default = null
}
variable "allow_payment_method_management" {
  default = null
}
variable "allow_billing_management" {
  default = null
}
variable "allow_budget_management" {
  default = null
}
variable "allow_cost_and_usage_report_management" {
  default = null
}
