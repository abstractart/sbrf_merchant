module SbrfMerchant
  module Response
    class CreateOrder < Base
      def success?
        !form_url.nil? && !order_id.nil?
      end
    end
  end
end
