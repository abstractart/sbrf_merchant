# frozen_string_literal: true

require 'sbrf_merchant/utils/string/to_camel_case'

module SbrfMerchant
  module Api
    module Response
      # Проблема - API сбербанка возвращает ответ в формате camelCase,
      # что не очень красиво выглядит в руби коде

      # Решение - декоратор для хэша на котором будут вызываться методы в snake_case,
      class BodyDecorator
        attr_reader :hash, :to_camel_case

        def initialize(hash, to_camel_case = ::SBRF::Utils::String::ToCamelCase.new)
          @hash = hash
          @to_camel_case = to_camel_case
        end

        def method_missing(meth, *args)
          value = hash[key(meth)]

          # Если значение не найдено то поведение по умолчанию
          return super if value.nil?

          # Если значение - хэш то возвращаем его, предварительно обернув в декоратор
          return self.class.new(value) if value.is_a?(Hash)

          # В остальных случаях возвращаем самое значение
          value
        end

        def respond_to?(meth)
          hash.key?(key(meth))
        end

        def respond_to_missing?(meth)
          hash.key?(key(meth))
        end

        private

        def key(meth)
          to_camel_case.call(meth.to_s)
        end
      end
    end
  end
end
