module SberbankMerchantApi
  class SberbankAPI
    def initialize(configuration)
      @configuration = configuration
    end
  
    def start_session(orderNumber:, amount:, returnUrl:, currency: 643)
      params = {
        orderNumber: orderNumber,
        amount: amount,
        currency: currency,
        returnUrl: returnUrl
      }

      response = connection.post(REGISTER_ORDER, params)
      JSON.parse(response.body)
    end
  
    def get_order_status(orderId:, orderNumber:)
      params = {
        orderNumber: orderNumber,
        orderId: orderId
      }
  
      response = connection.get(ORDER_STATUS, params)
      JSON.parse(response.body)
    end
  
    def refund(orderId:, amount:)
      params = {
        orderId: orderId,
        amount: amount
      }
  
      response = connection.post(REFUND, params)
      JSON.parse(response.body)
    end
  
    private
  
    def connection
      Faraday.new(
        url: configuration.api_host,
        params: {
            userName: configuration.login,
            password: configuration.password
        }
      )
    end

    attr_reader :configuration

    REST = '/payment/rest'
    REFUND = "#{REST}/refund.do"
    REGISTER_ORDER = "#{REST}/register.do"
    ORDER_STATUS = "#{REST}/getOrderStatusExtended.do"
  end
end
  module Sberbank
    module OrderStatus
      NOT_PAID = 0
      PREAUTHORIZED_AMOUNT_HOLD = 1
      COMPLETED = 2
      CANCEL = 3
      REFUND = 4
      AUTH_ON_BANK_ISSUER_SIDE = 5
      REJECTED = 6
    end
  
    module ActionCode
      SUCCESS = 0
      NO_PAYMENT_YET = -100
    end
  end
