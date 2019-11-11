# frozen_string_literal: true

require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    module Response
      class BodyDecorator
        attr_reader :hash, :to_camel_case

        def initialize(hash, to_camel_case = ::SBRF::Utils::String::ToCamelCase)
          @hash = hash
          @to_camel_case = to_camel_case
        end

        def method_missing(meth, *args)
          value = hash[to_camel_case.call(meth.to_s)]

          return super if value.nil?
          return self.class.new(value) if value.is_a?(Hash)

          value
        end

        def respond_to?(meth)
          hash.key?(to_camel_case.call(meth.to_s))
        end

        def respond_to_missing?(meth)
          hash.key?(to_camel_case.call(meth.to_s))
        end
      end
    end
  end
end
