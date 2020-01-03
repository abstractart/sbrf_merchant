# frozen_string_literal: true

require 'sbrf_merchant/api/response/append_success_flag_to_hash'
require 'sbrf_merchant/api/response/body_decorator'
require 'sbrf_merchant/utils/hash/to_snake_case_keys'

module SbrfMerchant
  module Api
    module Response
      class BodyPostProcessor
        def call(hash)
          result = ::SbrfMerchant::Utils::Hash::ToSnakeCaseKeys.new.call(hash)
          result = ::SbrfMerchant::Api::Response::AppendSuccessFlagToHash.new.call(result)
          result = ::SbrfMerchant::Api::Response::BodyDecorator.new(result)

          result
        end
      end
    end
  end
end
