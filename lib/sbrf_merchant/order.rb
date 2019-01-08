require 'sbrf_merchant/api/client'
require 'sbrf_merchant/api/action'
require 'sbrf_merchant/response/base'
require 'sbrf_merchant/response/create_order'
require 'sbrf_merchant/response/order_status'

module SbrfMerchant
  class Order
    attr_reader :api_client, :orderId, :orderNumber

    def initialize(orderId: nil, orderNumber: nil, api_client: SbrfMerchant.api_client)
      @orderId = orderId
      @orderNumber = orderNumber
      @api_client = api_client
    end

    def register_one_stage(**args)
      register(SbrfMerchant::Api::Action::REGISTER_ORDER, args)
    end

    def register_two_stage(**args)
      register(SbrfMerchant::Api::Action::REGISTER_PRE_AUTH, args)
    end

    def get_info
      Response::OrderStatus.new(
        api_client.process_request(
          SbrfMerchant::Api::Action::ORDER_STATUS,
          default_request_params
        )
      )
    end

    def cancel
      Response::Base.new(
        api_client.process_request(
          SbrfMerchant::Api::Action::CANCEL_ORDER,
          default_request_params
        )
      )
    end

    def refund(amount)
      Response::Base.new(
        api_client.process_request(
          SbrfMerchant::Api::Action::REFUND_ORDER,
          default_request_params.merge(amount: amount)
        )
      )
    end

    def complete(amount)
      Response::Base.new(
        api_client.process_request(
          SbrfMerchant::Api::Action::COMPLETE_ORDER,
          default_request_params.merge(amount: amount)
        )
      )
    end

    private

    def default_request_params
      params = {}

      params[:orderId] = orderId if orderId
      params[:orderNumber] = orderNumber if orderNumber

      params
    end

    def register(path, args)
      response = Response::CreateOrder.new(
        api_client.process_request(
          path,
          args.merge(default_request_params)
        )
      )
      @orderId = response.orderId

      response
    end
  end
end
