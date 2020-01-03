# frozen_string_literal: true

RSpec.describe SbrfMerchant::Api::Request::BodyPreProcessor do
  let(:snake_case_params) { { my_param1: '1', my_param2: '2' } }
  let(:camel_case_params) { { myParam1: '1', myParam2: '2' } }

  it 'converts snake_case hash to camelCase hash' do
    expect(described_class.new.call(snake_case_params)).to eq(camel_case_params)
  end
end
