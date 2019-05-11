require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/json/to_hash_parser'
require 'sbrf_merchant/utils/hash/to_snake_case_keys'
require 'sbrf_merchant/api/response/build_result_object'

module SbrfMerchant
  module Api
    module Response
      BodyPostProcessor = SbrfMerchant::Utils::HighOrderFunctions::Compose.call(
        SbrfMerchant::Utils::JSON::ToHashParser,
        SbrfMerchant::Utils::Hash::ToSnakeCaseKeys,
        SbrfMerchant::Api::Response::BuildResultObject
      )
    end
  end
end
