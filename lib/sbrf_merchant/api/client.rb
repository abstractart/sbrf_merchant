require 'json/ext'
require 'uri'
require 'net/http'

module SbrfMerchant
  module Api
    class Client
      attr_accessor :host, :user_name, :password

      def initialize(host:, user_name:, password:)
        @host = host
        @user_name = user_name
        @password = password
      end

      def process_request(path, params)
        parse_response_body(http_request(path, params))
      end

      private

      def parse_response_body(response)
        JSON.parse(response.body, symbolize_names: true)
      end

      def http_request(path, params)
        uri = URI.join(host, path)

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(build_net_http_request_object(uri, params))
        end
      end

      def build_net_http_request_object(uri, params)
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(
          params.merge(userName: user_name, password: password)
        )
        request
      end
    end
  end
end
