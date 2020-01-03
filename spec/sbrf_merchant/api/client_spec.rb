# frozen_string_literal: true

RSpec.describe SbrfMerchant::Api::Client do
  let(:user_name) { 'user_name' }
  let(:password) { 'password' }
  let(:host) { 'http://localhost:3000' }
  let(:method) { 'method' }
  let(:uri) { URI.join(host, 'payment/rest/', "#{method}.do") }
  let(:snake_case_params) { { my_param1: '1', my_param2: '2' } }

  let(:http_client) { ->(_uri, _params) { http_response } }
  let(:http_response) { OpenStruct.new(body: JSON.dump(http_response_hash)) }
  let(:http_response_hash) do
    {
      errorCode: '0',
      errorMessage: '',
      someParam: 'some_value',
      someNestedParam: {
        param2: 'some_nested_value'
      }
    }
  end
  let(:api_client) do
    described_class.new(
      user_name: user_name,
      password: password,
      host: host,
      http_client: http_client
    )
  end
  context '#call' do
    it 'returns success response' do
      response = api_client.call(method, snake_case_params)

      expect(response).to be_success
      expect(response.some_param).to eq('some_value')
      expect(response.some_nested_param.param2).to eq('some_nested_value')
    end
  end
end
