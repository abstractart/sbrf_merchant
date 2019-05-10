require 'json/ext'
require 'uri'
require 'net/http'

module SbrfMerchant
  module Api
    class Client
      attr_reader :config

      def initialize(config: SbrfMerchant.configuration)
        @config = config
      end

      def process_request(path, params)
        parse_response_body(http_request(path, params))
      end

      private

      def parse_response_body(response)
        JSON.parse(response.body, symbolize_names: true)
      end

      def http_request(path, params)
        uri = URI.join(config.host, path)

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(build_net_http_request_object(uri, params))
        end
      end

      def build_net_http_request_object(uri, params)
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(
          params.merge(userName: config.user_name, password: config.password)
        )
        request
      end
    end
  end
end
