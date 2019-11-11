# frozen_string_literal: true

require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/json/to_hash_parser'
require 'sbrf_merchant/api/response/append_success_flag_to_hash'
require 'sbrf_merchant/api/response/body_decorator'

module SbrfMerchant
  module Api
    module Response
      BodyPostProcessor = SbrfMerchant::Utils::HighOrderFunctions::Compose.call(
        SbrfMerchant::Utils::JSON::ToHashParser,
        SbrfMerchant::Api::Response::AppendSuccessFlagToHash,
        ->(hash) { BodyDecorator.new(hash) }
      )
    end
  end
end
