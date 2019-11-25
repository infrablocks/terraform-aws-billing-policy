require 'spec_helper'

describe 'assumable roles policy' do
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
end
