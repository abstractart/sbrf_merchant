require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/json/parser'
require 'sbrf_merchant/utils/hash/to_snake_case_keys'

module SbrfMerchant
  module Api
    module Response
      BodyPostProcessor = SbrfMerchant::Utils::HighOrderFunctions::Compose.call(
        SbrfMerchant::Utils::JSON::Parser,
        SbrfMerchant::Utils::Hash::ToSnakeCaseKeys
      )
    end
  end
end
