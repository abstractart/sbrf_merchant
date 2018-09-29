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
        status_equals?(OrderStatus::NOT_PAID)
      end

      def preauthorized?
        status_equals?(OrderStatus::PREAUTHORIZED_AMOUNT_HOLD)
      end

      def completed?
        status_equals?(OrderStatus::COMPLETED)
      end

      def cancelled?
        status_equals?(OrderStatus::CANCEL)
      end

      def refunded?
        status_equals?(OrderStatus::REFUND)
      end

      def auth_on_bank_issuer_side?
        status_equals?(OrderStatus::AUTH_ON_BANK_ISSUER_SIDE)
      end

      def rejected?
        status_equals?(OrderStatus::REJECTED)
      end

      private

      def status_equals?(status)
        orderStatus == status
      end
    end
  end
end
