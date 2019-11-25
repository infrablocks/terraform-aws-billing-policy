require 'spec_helper'

describe 'billing policy' do
  let(:policy_name) { vars.policy_name }
  let(:policy_description) { vars.policy_description }
  let(:policy_arn) { output_for(:harness, 'policy_arn') }

  let(:target_role_arn) { output_for(:harness, 'target_role_arn') }

  subject {
    iam_policy(policy_name)
  }

  it { should exist }
  its(:arn) { should eq(policy_arn) }

  let(:target_role) {
    iam_role(target_role_arn)
  }

  it 'allows all read billing actions' do
    [
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
    ].each do |action|
      expect(target_role)
          .to(be_allowed_action(action))
    end
  end

  context 'when account management is allowed' do
    before(:all) do
      reprovision(allow_account_management: 'yes')
    end

    it 'allows all account management actions' do
      [
          "aws-portal:ModifyAccount",
          "awsbillingconsole:ModifyAccount",
      ].each do |action|
        expect(target_role)
            .to(be_allowed_action(action))
      end
    end
  end

  context 'when account management is not allowed' do
    before(:all) do
      reprovision(allow_account_management: 'no')
    end

    it 'disallows all account management actions' do
      [
          "aws-portal:ModifyAccount",
          "awsbillingconsole:ModifyAccount",
      ].each do |action|
        expect(target_role)
            .not_to(be_allowed_action(action))
      end
    end
  end

  context 'when payment method management is allowed' do
    before(:all) do
      reprovision(allow_payment_method_management: 'yes')
    end

    it 'allows all payment method management actions' do
      [
          "aws-portal:ModifyPaymentMethods",
          "awsbillingconsole:ModifyPaymentMethods",
      ].each do |action|
        expect(target_role)
            .to(be_allowed_action(action))
      end
    end
  end

  context 'when payment method management is not allowed' do
    before(:all) do
      reprovision(allow_payment_method_management: 'no')
    end

    it 'disallows all payment method management actions' do
      [
          "aws-portal:ModifyPaymentMethods",
          "awsbillingconsole:ModifyPaymentMethods",
      ].each do |action|
        expect(target_role)
            .not_to(be_allowed_action(action))
      end
    end
  end

  context 'when billing management is allowed' do
    before(:all) do
      reprovision(allow_billing_management: 'yes')
    end

    it 'allows all billing management actions' do
      [
          "aws-portal:ModifyBilling",
          "awsbillingconsole:ModifyBilling",
      ].each do |action|
        expect(target_role)
            .to(be_allowed_action(action))
      end
    end
  end

  context 'when billing management is not allowed' do
    before(:all) do
      reprovision(allow_billing_management: 'no')
    end

    it 'disallows all billing management actions' do
      [
          "aws-portal:ModifyBilling",
          "awsbillingconsole:ModifyBilling",
      ].each do |action|
        expect(target_role)
            .not_to(be_allowed_action(action))
      end
    end
  end

  context 'when budget management is allowed' do
    before(:all) do
      reprovision(allow_budget_management: 'yes')
    end

    it 'allows all budget management actions' do
      expect(target_role)
          .to(be_allowed_action("budgets:ModifyBudget"))
    end
  end

  context 'when budget management is not allowed' do
    before(:all) do
      reprovision(allow_budget_management: 'no')
    end

    it 'disallows all budget management actions' do
      expect(target_role)
          .not_to(be_allowed_action("budgets:ModifyBudget"))
    end
  end

  context 'when cost and usage report management is allowed' do
    before(:all) do
      reprovision(allow_cost_and_usage_report_management: 'yes')
    end

    it 'allows all cost and usage report management actions' do
      [
          "cur:PutReportDefinition",
          "cur:DeleteReportDefinition",
          "cur:ModifyReportDefinition"
      ].each do |action|
        expect(target_role)
            .to(be_allowed_action(action))
      end
    end
  end

  context 'when cost and usage report management is not allowed' do
    before(:all) do
      reprovision(allow_cost_and_usage_report_management: 'no')
    end

    it 'disallows all cost and usage report management actions' do
      [
          "cur:PutReportDefinition",
          "cur:DeleteReportDefinition",
          "cur:ModifyReportDefinition"
      ].each do |action|
        expect(target_role)
            .not_to(be_allowed_action(action))
      end
    end
  end
end
