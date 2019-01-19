module SbrfMerchant
  module Response
    class CreateOrder < Base
      def success?
        !data[:form_url].nil? && !data[:order_id].nil?
      end
    end
  end
end
