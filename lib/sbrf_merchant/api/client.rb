# frozen_string_literal: true

require 'sbrf_merchant/api/response/body_postprocessor'
require 'sbrf_merchant/api/request/body_preprocessor'
require 'sbrf_merchant/api/request/uri_builder'
require 'sbrf_merchant/utils/json/to_hash_parser'
require 'sbrf_merchant/utils/http/client'

module SbrfMerchant
  module Api
    class Client
      attr_reader :user_name,
                  :password,
                  :host,
                  :response_body_postprocessor,
                  :http_client,
                  :uri_builder,
                  :request_body_preprocessor,
                  :json_parser

      def initialize(
        user_name:,
        password:,
        host:,
        response_body_postprocessor: SBRF::Api::Response::BodyPostProcessor.new,
        request_body_preprocessor: SBRF::Api::Request::BodyPreProcessor.new,
        http_client: SBRF::Utils::Http::Client.new,
        uri_builder: SBRF::Api::Request::UriBuilder.new,
        json_parser: SBRF::Utils::JSON::ToHashParser.new
      )
        @user_name = user_name
        @password = password
        @host = host
        @response_body_postprocessor = response_body_postprocessor
        @http_client = http_client
        @uri_builder = uri_builder
        @request_body_preprocessor = request_body_preprocessor
        @json_parser = json_parser
      end

      def call(method_name, **params)
        prepared_params = request_body_preprocessor.call(auth_params.merge(params))
        uri = uri_builder.call(host, method_name)
        response = http_client.call(uri, prepared_params)
        parsed_body = json_parser.call(response.body)

        response_body_postprocessor.call(parsed_body)
      end

      private

      def auth_params
        { user_name: user_name, password: password }
      end
    end
  end
end
