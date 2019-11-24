# frozen_string_literal: true

require 'sbrf_merchant/api/response/body_postprocessor'
require 'sbrf_merchant/api/request/body_preprocessor'
require 'sbrf_merchant/api/request/uri_builder'
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
                  :request_body_preprocessor

      def initialize(
        user_name:,
        password:,
        host:,
        response_body_postprocessor: SbrfMerchant::Api::Response::BodyPostProcessor.new,
        request_body_preprocessor: SbrfMerchant::Api::Request::BodyPreProcessor.new,
        http_client: SbrfMerchant::Utils::Http::Client.new,
        uri_builder: SbrfMerchant::Api::Request::UriBuilder.new
      )
        @user_name = user_name
        @password = password
        @host = host
        @response_body_postprocessor = response_body_postprocessor
        @http_client = http_client
        @uri_builder = uri_builder
        @request_body_preprocessor = request_body_preprocessor
      end

      def call(method_name, **params)
        prepared_params = request_body_preprocessor.call(auth_params.merge(params))
        uri = uri_builder.call(host, method_name)

        response = http_client.call(uri, prepared_params)
        response_body_postprocessor.call(response.body)
      end

      private

      def auth_params
        { user_name: user_name, password: password }
      end
    end
  end
end
