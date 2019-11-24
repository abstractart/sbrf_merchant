# frozen_string_literal: true

require 'sbrf_merchant/utils/high_order_functions/compose'
require 'sbrf_merchant/utils/hash/to_camel_case_keys'

module SbrfMerchant
  module Api
    module Request
      class BodyPreProcessor
        def call(body)
          SbrfMerchant::Utils::Hash::ToCamelCaseKeys.new.call(body)
        end
      end
    end
  end
end
