require 'faraday'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'

module SbrfMerchant
  module Api
    class Client
      attr_accessor :host, :userName, :password

      def initialize(host:, userName:, password:)
        @host = host
        @userName = userName
        @password = password
      end

      def process_request(path, params)
        JSON.parse(http_client.post(path, params).body).with_indifferent_access
      end

      private

      def http_client
        @client ||= Faraday.new(
          url: host,
          params: {
            userName: userName,
            password: password
          }
        )
      end
    end
  end
end
