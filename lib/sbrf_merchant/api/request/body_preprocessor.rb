# frozen_string_literal: true

require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/hash/to_camel_case_keys'

module SbrfMerchant
  module Api
    module Request
      BodyPreProcessor = SbrfMerchant::Utils::HighOrderFunctions::Compose.call(
        SbrfMerchant::Utils::Hash::ToCamelCaseKeys
      )
    end
  end
end
