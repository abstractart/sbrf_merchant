require 'sbrf_merchant/api/order_status'

module SbrfMerchant
  module Response
    class OrderStatus < Response::Base
      AVAILABLE_FIELDS = %i[
        orderNumber
        orderStatus
        actionCode
        actionCodeDescription
        amount
        currency
        date
        ip
        merchantOrderParams
        attributes
        cardAuthInfo
        authDateTime
        terminalId
        authRefnum
        paymentAmountInfo
        bankInfo
      ].freeze

      attr_reader(*AVAILABLE_FIELDS)

      def initialize(args = {})
        super(args)

        AVAILABLE_FIELDS.each do |field|
          instance_variable_set("@#{field}", args[field]) unless args[field].nil?
        end
      end

      def not_paid?
        status_equals?(SbrfMerchant::Api::OrderStatus::NOT_PAID)
      end

      def preauthorized?
        status_equals?(SbrfMerchant::Api::OrderStatus::PREAUTHORIZED_AMOUNT_HOLD)
      end

      def completed?
        status_equals?(SbrfMerchant::Api::OrderStatus::COMPLETED)
      end

      def cancelled?
        status_equals?(SbrfMerchant::Api::OrderStatus::CANCEL)
      end

      def refunded?
        status_equals?(SbrfMerchant::Api::OrderStatus::REFUND)
      end

      def auth_on_bank_issuer_side?
        status_equals?(SbrfMerchant::Api::OrderStatus::AUTH_ON_BANK_ISSUER_SIDE)
      end

      def rejected?
        status_equals?(SbrfMerchant::Api::OrderStatus::REJECTED)
      end

      private

      def status_equals?(status)
        orderStatus == status
      end
    end
  end
end
