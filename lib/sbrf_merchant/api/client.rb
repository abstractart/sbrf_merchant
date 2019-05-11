require 'sbrf_merchant/api/response/body_postprocessor'
require 'sbrf_merchant/api/request/body_preprocessor'
require 'sbrf_merchant/utils/http/client'
require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    class Client
      attr_reader :config,
                  :response_body_processor,
                  :http_client,
                  :method_name_converter,
                  :request_body_preprocessor

      def initialize(
        config: SbrfMerchant.configuration,
        response_body_processor: SbrfMerchant::Api::Response::BodyPostProcessor,
        request_body_preprocessor: SbrfMerchant::Api::Request::BodyPreProcessor,
        http_client: SbrfMerchant::Utils::Http::Client,
        method_name_converter: SbrfMerchant::Utils::String::ToCamelCase
      )
        @config = config
        @response_body_processor = response_body_processor
        @http_client = http_client
        @method_name_converter = method_name_converter
        @request_body_preprocessor = request_body_preprocessor
      end

      def call(method, **params)
        prepared_params = request_body_preprocessor.call(auth_params.merge(params))
        response = http_client.call(uri(method), prepared_params)

        response_body_processor.call(response.body)
      end

      private

      def auth_params
        { user_name: config.user_name, password: config.password }
      end

      def uri(method)
        URI.join(
          config.host,
          '/payment/rest/',
          method_name_converter.call(method.to_s) + '.do'
        )
      end
    end
  end
end
