module SbrfMerchant
  module Response
    class CreateOrder < Response::Base
      attr_reader :formUrl, :orderId

      def initialize(args = {})
        super(args)
        @formUrl = args[:formUrl]
        @orderId = args[:orderId]
      end

      def success?
        !formUrl.nil? && !orderId.nil?
      end
    end
  end
end
