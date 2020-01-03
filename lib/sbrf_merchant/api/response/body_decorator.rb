# frozen_string_literal: true

require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    module Response
      class BodyDecorator
        attr_reader :hash

        def initialize(hash)
          @hash = hash
        end

        def method_missing(meth, *args)
          # Если ключ отсутствует то поведение по умолчанию
          return super unless hash.key?(meth)

          value = hash[meth]
          # Если значение - хэш то возвращаем его, предварительно обернув в декоратор
          return self.class.new(value) if value.is_a?(Hash)

          # В остальных случаях возвращаем самое значение
          value
        end

        def respond_to?(meth)
          hash.key?(meth)
        end

        def respond_to_missing?(meth)
          hash.key?(meth)
        end
      end
    end
  end
end
