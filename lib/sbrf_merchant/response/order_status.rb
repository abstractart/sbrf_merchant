require 'sbrf_merchant/api/order_status'

module SbrfMerchant
  module Response
    class OrderStatus < Base
      def not_paid?
        status_equals?(Sberbank::Api::OrderStatus::NOT_PAID)
      end

      def preauthorized?
        status_equals?(Sberbank::Api::OrderStatus::PREAUTHORIZED_AMOUNT_HOLD)
      end

      def completed?
        status_equals?(Sberbank::Api::OrderStatus::COMPLETED)
      end

      def cancelled?
        status_equals?(Sberbank::Api::OrderStatus::CANCEL)
      end

      def refunded?
        status_equals?(Sberbank::Api::OrderStatus::REFUND)
      end

      def auth_on_bank_issuer_side?
        status_equals?(Sberbank::Api::OrderStatus::AUTH_ON_BANK_ISSUER_SIDE)
      end

      def rejected?
        status_equals?(Sberbank::Api::OrderStatus::REJECTED)
      end

      private

      def status_equals?(status)
        order_status == status
      end
    end
  end
end
