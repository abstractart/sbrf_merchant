# frozen_string_literal: true

RSpec.describe SbrfMerchant::Api::Response::BodyDecorator do
  let(:hash) do
    {
      error_code: '0',
      some_nested_param: {
        param2: 'some_nested_value'
      }
    }
  end

  let(:decorator) { described_class.new(hash) }

  it 'returns value when key exists' do
    expect(decorator.error_code).to eq('0')
  end

  it 'returns decorator when value is a hash' do
    expect(decorator.some_nested_param).is_a? described_class
    expect(decorator.some_nested_param.hash).to eq(hash[:some_nested_param])
  end
end
