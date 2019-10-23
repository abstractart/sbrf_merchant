# frozen_string_literal: true

RSpec.describe SbrfMerchant::Api::Client do
  let(:user_name) { 'user_name' }
  let(:password) { 'password' }
  let(:host) { 'http://localhost:3000' }

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

  let(:http_response_hash_with_snake_keys) do
    {
      error_code: '0',
      error_message: '',
      some_param: 'some_value',
      some_nested_param: {
        param2: 'some_nested_value'
      }
    }
  end

  context '#call' do
    let(:api_client) do
      described_class.new(
        user_name: user_name,
        password: password,
        host: host,
        http_client: http_client
      )
    end
    let(:method) { 'path' }

    let(:snake_case_params) { { my_param1: '1', my_param2: '2' } }
    let(:snake_case_params_with_auth) do
      snake_case_params.merge(
        user_name: user_name,
        password: password
      )
    end

    let(:camel_case_params) { { myParam1: '1', myParam2: '2' } }
    let(:camel_case_params_with_auth) do
      camel_case_params.merge(
        userName: user_name,
        password: password
      )
    end

    it 'returns success openstruct' do
      response = api_client.call(method, snake_case_params)

      expect(response).to be_success
      expect(response.some_param).to eq('some_value')
      expect(response.some_nested_param.param2).to eq('some_nested_value')
    end

    context 'request_body_preprocessor' do
      it do
        expect(api_client.request_body_preprocessor).to(
          receive(:call).with(snake_case_params_with_auth).and_return(
            camel_case_params_with_auth
          )
        )

        api_client.call(method, snake_case_params)
      end
    end

    context 'http_client' do
      it do
        expect(api_client.http_client).to(
          receive(:call).with(
            URI('http://localhost:3000/payment/rest/path.do'),
            camel_case_params_with_auth
          ).and_return(http_response)
        )

        api_client.call(method, snake_case_params)
      end
    end

    context 'response_body_postprocessor' do
      it do
        expect(api_client.response_body_postprocessor).to(
          receive(:call).with(http_response.body).and_return(
            http_response_hash_with_snake_keys
          )
        )

        api_client.call(method, snake_case_params)
      end
    end
  end
end
