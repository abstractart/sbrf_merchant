RSpec.describe SbrfMerchant::Api::Client do
  let(:user_name) { 'user_name' }
  let(:password) { 'password' }
  let(:host) { 'http://localhost:3000' }

  let(:config) do
    SbrfMerchant::Configuration.new(
      user_name: user_name,
      password: password,
      host: host
    )
  end

  let(:http_client) { ->(_uri, _params) { http_response } }
  let(:http_response) { OpenStruct.new(body: http_response_body) }
  let(:http_response_body) do
    JSON.dump(
      {
        errorCode: '0',
        errorMessage: '',
        someParam: 'some_value'
      }
    )
  end

  context '#call' do
    let(:api_client) { described_class.new(config: config, http_client: http_client) }
    let(:method) { 'path' }
    let(:params) { { param_1: '1', param_2: '2' } }
    let(:response) { api_client.call(method, params) }

    it 'returns success openstruct' do
      expect(response).to be_success
      expect(response.some_param).to eq('some_value')
    end
  end
end
