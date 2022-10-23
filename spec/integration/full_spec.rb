# frozen_string_literal: true

require 'spec_helper'

describe 'full example' do
  subject { iam_policy(policy_name) }

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(role: :full)
  end

  let(:policy_name) do
    var(role: :full, name: 'policy_name')
  end
  let(:policy_description) do
    var(role: :full, name: 'policy_description')
  end

  let(:policy_arn) do
    output(role: :full, name: 'policy_arn')
  end
  let(:target_role_arn) do
    output(role: :full, name: 'target_role_arn')
  end

  let(:target_role) do
    iam_role(target_role_arn)
  end

  it { is_expected.to exist }
  its(:arn) { is_expected.to eq(policy_arn) }

  it 'allows all read billing actions' do
    %w[
      aws-portal:ViewBilling
      aws-portal:ViewAccount
      aws-portal:ViewUsage
      aws-portal:ViewPaymentMethods
      awsbillingconsole:ViewBilling
      awsbillingconsole:ViewAccount
      awsbillingconsole:ViewUsage
      awsbillingconsole:ViewPaymentMethods
      budgets:ViewBudget
      cur:DescribeReportDefinitions
      pricing:DescribeServices
      pricing:GetAttributeValues
      pricing:GetProducts
    ].each do |action|
      expect(target_role)
        .to(be_allowed_action(action))
    end
  end

  it 'allows all account management actions' do
    %w[
        aws-portal:ModifyAccount
        awsbillingconsole:ModifyAccount
      ].each do |action|
      expect(target_role)
        .to(be_allowed_action(action))
    end
  end

  it 'allows all payment method management actions' do
    %w[
        aws-portal:ModifyPaymentMethods
        awsbillingconsole:ModifyPaymentMethods
      ].each do |action|
      expect(target_role)
        .to(be_allowed_action(action))
    end
  end

  it 'allows all billing management actions' do
    %w[
        aws-portal:ModifyBilling
        awsbillingconsole:ModifyBilling
      ].each do |action|
      expect(target_role)
        .to(be_allowed_action(action))
    end
  end

  it 'allows all budget management actions' do
    expect(target_role)
      .to(be_allowed_action('budgets:ModifyBudget'))
  end

  it 'allows all cost and usage report management actions' do
    %w[
        cur:PutReportDefinition
        cur:DeleteReportDefinition
        cur:ModifyReportDefinition
      ].each do |action|
      expect(target_role)
        .to(be_allowed_action(action))
    end
  end
end
