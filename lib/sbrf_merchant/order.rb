require 'sbrf_merchant/api/client'
require 'sbrf_merchant/api/action'
require 'sbrf_merchant/response/base'
require 'sbrf_merchant/response/create_order'
require 'sbrf_merchant/response/order_status'
require 'sbrf_merchant/utils/string'
require 'awrence'

module SbrfMerchant
  class Order
    attr_reader :api_client, :order_id, :order_number

    def initialize(order_id: nil, order_number: nil, api_client: Sberbank.api_client)
      @order_id = order_id
      @order_number = order_number
      @api_client = api_client
    end

    AVAILABLE_METHODS = {
      get_order_status_extended: Response::OrderStatus,
      register: Response::CreateOrder,
      register_pre_auth: Response::CreateOrder,
      deposit: Response::Base,
      refund: Response::Base,
      reverse: Response::Base
    }.freeze

    AVAILABLE_METHODS.each do |method_name, response_class|
      define_method(method_name) do |**args|
        response = response_class.new(
          api_client.process_request(
            Sberbank::Api::Action.convert_method_name_to_action(method_name.to_s),
            args.merge(default_request_params).to_camelback_keys
          )
        )

        if %i[register_pre_auth register].include?(method_name) && response.success?
          @order_id = response.order_id
        end

        response
      end
    end

    private

    def default_request_params
      params = {}

      params[:order_id] = order_id if order_id
      params[:order_number] = order_number if order_number

      params
    end
  end
end
