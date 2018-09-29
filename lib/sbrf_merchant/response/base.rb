require 'sbrf_merchant/api/error_code'
module SbrfMerchant
  module Response
    class Base
      attr_reader :errorCode, :errorMessage

      def initialize(args = {})
        @errorCode = args[:errorCode]
        @errorMessage = args[:errorMessage]
      end

      def success?
        errorCode == SbrfMerchant::Api::ErrorCode::SUCCESS
      end
    end
  end
end