RSpec.describe SbrfMerchant::Api::Client do
  let(:api_client) { described_class.new(user_name: user_name, password: password, host: host) }
  let(:user_name) { 'user_name' }
  let(:password) { 'password' }
  let(:host) { 'http://localhost:3000' }
  let(:path) { '/path' }
  let(:params) { { param_1: '1', param_2: '2' } }

  context '#process_request' do
    let(:response_hash) do
      {
        errorCode: '0',
        errorMessage: ''
      }
    end

    before do
      http = double
      allow(Net::HTTP).to receive(:start).and_yield http
      allow(http).to \
        receive(:request).with(an_instance_of(Net::HTTP::Post))
                         .and_return(Net::HTTPResponse)

      allow(Net::HTTPResponse).to receive(:body).and_return(JSON.dump(response_hash))
    end

    it 'returns hash when process_request called' do
      expect(api_client.process_request(path, params)).to eq(response_hash)
    end

    after do
      allow(Net::HTTP).to receive(:start).and_call_original
      allow(Net::HTTPResponse).to receive(:body).and_call_original
    end
  end

  context '#build_net_http_request_object' do
    let(:request_object) do
      api_client.send(:build_net_http_request_object, URI.join(host, path), params)
    end

    let(:parsed_request_body) do
      CGI.parse(request_object.body)
    end

    let(:expected_parsed_request_body) do
      {
      "param_1" => ["1"],
      "param_2" => ["2"],
      "password" => [password],
      "userName" => [user_name]
      }
    end

    it 'appends to params user_name & password' do
      expect(parsed_request_body).to eq(expected_parsed_request_body)
    end
  end

  context '#new' do
    it 'assigns user_name, password & host' do
      expect(api_client.user_name).to eq(user_name)
      expect(api_client.host).to eq(host)
      expect(api_client.password).to eq(password)
    end
  end
end
