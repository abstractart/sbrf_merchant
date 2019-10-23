# frozen_string_literal: true

require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/json/to_hash_parser'
require 'sbrf_merchant/utils/json/to_object_parser'
require 'sbrf_merchant/utils/hash/to_snake_case_keys'
require 'sbrf_merchant/api/response/append_success_flag_to_hash'
require 'json/ext'

module SbrfMerchant
  module Api
    module Response
      BodyPostProcessor = SbrfMerchant::Utils::HighOrderFunctions::Compose.call(
        SbrfMerchant::Utils::JSON::ToHashParser,
        SbrfMerchant::Utils::Hash::ToSnakeCaseKeys,
        SbrfMerchant::Api::Response::AppendSuccessFlagToHash,
        ->(hash) { JSON.dump(hash) },
        SbrfMerchant::Utils::JSON::ToObjectParser.call(OpenStruct)
      )
    end
  end
end
