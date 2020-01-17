# frozen_string_literal: true

RSpec.describe SbrfMerchant::Api::Response::BodyPostProcessor do
  let(:camel_case_response) do
    {
      errorCode: '0',
      someNestedParam: {
        param2: 'some_nested_value'
      }
    }
  end

  let(:snake_case_response) do
    {
      error_code: '0',
      some_nested_param: {
        param2: 'some_nested_value'
      }
    }
  end

  let(:snake_case_response_with_success_flag) { snake_case_response.merge(success?: true) }
  let(:decorator) { decorator_class.new(camel_case_response_with_success_flag) }
  let(:decorator_class) { SBRF::Api::Response::BodyDecorator }
  let(:result) { described_class.new.call(camel_case_response) }

  it 'appends flag and return decorator' do
    expect(result).to be_success
    expect(result).is_a? decorator_class
    expect(result.hash).to eq(snake_case_response_with_success_flag)
  end
end
