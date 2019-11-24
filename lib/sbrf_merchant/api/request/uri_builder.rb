# frozen_string_literal: true

require 'uri'
require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    module Request
      class UriBuilder
        attr_reader :method_name_converter
        def initialize(method_name_converter: SbrfMerchant::Utils::String::ToCamelCase.new)
          @method_name_converter = method_name_converter
        end

        def call(host, method_name)
          URI.join(
            host,
            '/payment/rest/',
            method_name_converter.call(method_name.to_s) + '.do'
          )
        end
      end
    end
  end
end
