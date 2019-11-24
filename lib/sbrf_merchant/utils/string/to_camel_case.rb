# frozen_string_literal: true

module SbrfMerchant
  module Utils
    module String
      class ToCamelCase
        def call(str)
          str.split('_').inject('') do |buffer, e|
            buffer + (buffer.empty? ? e : e.capitalize)
          end
        end
      end
    end
  end
end
