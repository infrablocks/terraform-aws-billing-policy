# frozen_string_literal: true

require 'spec_helper'

describe 'billing policy' do
  let(:policy_name) do
    var(role: :root, name: 'policy_name')
  end
  let(:policy_description) do
    var(role: :root, name: 'policy_description')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates an IAM policy' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .once)
    end

    it 'uses the provided policy name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(:name, policy_name))
    end

    it 'uses the provided policy description' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(:description, policy_description))
    end

    it 'allows all account read actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ViewBilling',
                    'aws-portal:ViewAccount',
                    'aws-portal:ViewUsage',
                    'aws-portal:ViewPaymentMethods',
                    'awsbillingconsole:ViewBilling',
                    'awsbillingconsole:ViewAccount',
                    'awsbillingconsole:ViewUsage',
                    'awsbillingconsole:ViewPaymentMethods',
                    'budgets:ViewBudget',
                    'cur:DescribeReportDefinitions',
                    'pricing:DescribeServices',
                    'pricing:GetAttributeValues',
                    'pricing:GetProducts'
                  )
                )
              ))
    end

    it 'allows all account management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyAccount',
                    'awsbillingconsole:ModifyAccount'
                  )
                )
              ))
    end

    it 'allows all payment method management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyPaymentMethods',
                    'awsbillingconsole:ModifyPaymentMethods'
                  )
                )
              ))
    end

    it 'allows all billing management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyBilling',
                    'awsbillingconsole:ModifyBilling'
                  )
                )
              ))
    end

    it 'allows all budget management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'budgets:ModifyBudget'
                  )
                )
              ))
    end

    it 'allows all cost and usage report management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'cur:PutReportDefinition',
                    'cur:DeleteReportDefinition',
                    'cur:ModifyReportDefinition'
                  )
                )
              ))
    end

    it 'outputs the policy ARN' do
      expect(@plan)
        .to(include_output_creation(name: 'policy_arn'))
    end
  end

  describe 'when allow_account_management is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_account_management = 'no'
      end
    end

    it 'does not allow account management actions' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_iam_policy')
                  .with_attribute_value(
                    :policy,
                    a_policy_with_statement(
                      Effect: 'Allow',
                      Resource: '*',
                      Action: a_collection_including(
                        'aws-portal:ModifyAccount',
                        'awsbillingconsole:ModifyAccount'
                      )
                    )
                  ))
    end
  end

  describe 'when allow_account_management is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_account_management = 'yes'
      end
    end

    it 'allows account management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyAccount',
                    'awsbillingconsole:ModifyAccount'
                  )
                )
              ))
    end
  end

  describe 'when allow_payment_method_management is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_payment_method_management = 'no'
      end
    end

    it 'does not allow payment method management actions' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_iam_policy')
                  .with_attribute_value(
                    :policy,
                    a_policy_with_statement(
                      Effect: 'Allow',
                      Resource: '*',
                      Action: a_collection_including(
                        'aws-portal:ModifyPaymentMethods',
                        'awsbillingconsole:ModifyPaymentMethods'
                      )
                    )
                  ))
    end
  end

  describe 'when allow_payment_method_management is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_payment_method_management = 'yes'
      end
    end

    it 'allows payment method management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyPaymentMethods',
                    'awsbillingconsole:ModifyPaymentMethods'
                  )
                )
              ))
    end
  end

  describe 'when allow_billing_management is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_billing_management = 'no'
      end
    end

    it 'does not allow billing management actions' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyBilling',
                    'awsbillingconsole:ModifyBilling'
                  )
                )
              ))
    end
  end

  describe 'when allow_billing_management is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_billing_management = 'yes'
      end
    end

    it 'allows billing management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'aws-portal:ModifyBilling',
                    'awsbillingconsole:ModifyBilling'
                  )
                )
              ))
    end
  end

  describe 'when allow_budget_management is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_budget_management = 'no'
      end
    end

    it 'does not allow budget management actions' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'budgets:ModifyBudget'
                  )
                )
              ))
    end
  end

  describe 'when allow_budget_management is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_budget_management = 'yes'
      end
    end

    it 'allows budget management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'budgets:ModifyBudget'
                  )
                )
              ))
    end
  end

  describe 'when allow_cost_and_usage_report_management is "no"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_cost_and_usage_report_management = 'no'
      end
    end

    it 'does not allow cost and usage report management actions' do
      expect(@plan)
        .not_to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'cur:PutReportDefinition',
                    'cur:DeleteReportDefinition',
                    'cur:ModifyReportDefinition'
                  )
                )
              ))
    end
  end

  describe 'when allow_cost_and_usage_report_management is "yes"' do
    before(:context) do
      @plan = plan(role: :root) do |vars|
        vars.allow_cost_and_usage_report_management = 'yes'
      end
    end

    it 'allows cost and usage report management actions' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_iam_policy')
              .with_attribute_value(
                :policy,
                a_policy_with_statement(
                  Effect: 'Allow',
                  Resource: '*',
                  Action: a_collection_including(
                    'cur:PutReportDefinition',
                    'cur:DeleteReportDefinition',
                    'cur:ModifyReportDefinition'
                  )
                )
              ))
    end
  end
end
