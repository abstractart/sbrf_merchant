require 'sbrf_merchant/api/error_code'
require 'plissken'
require 'json/ext'

module SbrfMerchant
  module Response
    class Base
      attr_reader :raw_data, :data

      def initialize(**raw_data)
        @raw_data = raw_data.to_snake_keys
        @data = JSON.parse(JSON.dump(@raw_data), object_class: OpenStruct)
      end

      def success?
        return false unless raw_data[:error_code]

        raw_data[:error_code].to_i == SbrfMerchant::Api::ErrorCode::SUCCESS
      end

      def method_missing(method, *args, &block)
        return data.public_send(method) if data.respond_to?(method)

        super
      end

      def respond_to_missing?(method, *)
        data.respond_to?(method) || super
      end
    end
  end
end
