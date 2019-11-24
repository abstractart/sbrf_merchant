# frozen_string_literal: true

module SbrfMerchant
  module Utils
    module HighOrderFunctions
      # Обьединяем несколько callable сущностей в одну
      class Compose
        attr_reader :functions

        def initialize(*functions)
          @functions = functions
        end

        def call(arg)
          functions.inject(arg) { |acc, func| func.call(acc) }
        end
      end
    end
  end
end
