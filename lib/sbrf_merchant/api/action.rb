module SbrfMerchant
  module Api
    module Action
      REST = '/payment/rest/'.freeze
      module OneStage
        REFUND_ORDER = "#{REST}refund.do".freeze
        REGISTER_ORDER = "#{REST}register.do".freeze
        ORDER_STATUS = "#{REST}getOrderStatusExtended.do".freeze
        CANCEL_ORDER = "#{REST}reverse.do".freeze
      end
    end
  end
end
