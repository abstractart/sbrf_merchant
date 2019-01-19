require 'sbrf_merchant/api/error_code'
require 'plissken'

module SbrfMerchant
  module Response
    class Base
      attr_reader :data

      def initialize(**data)
        @data = data.to_snake_keys
      end

      def success?
        return false unless error_code

        error_code.to_i == SbrfMerchant::Api::ErrorCode::SUCCESS
      end

      def method_missing(method, *args, &block)
        return data[method] if data.key?(method)
        super
      end

      def respond_to_missing?(method, *)
        data.key?(method) || super
      end
    end
  end
end
