module SbrfMerchant
  module Response
    class CreateOrder < Base
      def success?
        !raw_data[:form_url].nil? && !raw_data[:order_id].nil?
      end
    end
  end
end
