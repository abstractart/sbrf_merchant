module SbrfMerchant
  module Api
    module Action
      REST = '/payment/rest/'.freeze
      REFUND_ORDER = "#{REST}refund.do".freeze
      REGISTER_ORDER = "#{REST}register.do".freeze
      ORDER_STATUS = "#{REST}getOrderStatusExtended.do".freeze
      CANCEL_ORDER = "#{REST}reverse.do".freeze
      REGISTER_PRE_AUTH = "#{REST}registerPreAuth.do".freeze
      COMPLETE_ORDER = "#{REST}deposit.do".freeze
    end
  end
end
