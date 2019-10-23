# frozen_string_literal: true

module SbrfMerchant
  module Utils
    module HighOrderFunctions
      Compose = lambda { |*functions|
        lambda { |arg|
          functions.inject(arg) { |acc, function| function.call(acc) }
        }
      }
    end
  end
end
