# frozen_string_literal: true

require 'uri'
require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    module Request
      UriBuilderConstructor = lambda do |method_name_converter|
        lambda do |host, method_name|
          URI.join(
            host,
            '/payment/rest/',
            method_name_converter.call(method_name.to_s) + '.do'
          )
        end
      end

      UriBuilder = UriBuilderConstructor.call(SbrfMerchant::Utils::String::ToCamelCase)
    end
  end
end
