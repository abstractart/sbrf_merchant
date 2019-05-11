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

  let(:http_client) do
    ->(_uri, _params) { OpenStruct.new(body: JSON.dump(response_hash.to_camel_keys)) }
  end

  let(:response_hash) do
    {
      error_code: '0',
      error_message: ''
    }
  end

  let(:method) { 'path' }
  let(:params) { { param_1: '1', param_2: '2' } }

  context '#call' do
    let(:api_client) { described_class.new(config: config, http_client: http_client) }

    it 'returns hash when process_request called' do
      expect(api_client.call(method, app: nil)).to eq(response_hash)
    end
  end
end
