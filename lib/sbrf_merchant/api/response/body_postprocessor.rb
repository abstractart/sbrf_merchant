# frozen_string_literal: true

require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/json/to_hash_parser'
require 'sbrf_merchant/api/response/append_success_flag_to_hash'
require 'sbrf_merchant/api/response/body_decorator'

module SbrfMerchant
  module Api
    module Response
      class BodyPostProcessor
        def call(body)
          ::SbrfMerchant::Utils::HighOrderFunctions::Compose.new(
            ::SbrfMerchant::Utils::JSON::ToHashParser.new,
            ::SbrfMerchant::Api::Response::AppendSuccessFlagToHash.new,
            ->(hash) { ::SbrfMerchant::Api::Response::BodyDecorator.new(hash) }
          ).call(body)
        end
      end
    end
  end
end
