module SbrfMerchant
  module Utils
    module HighOrderFunctions
      Compose = lambda { |*functions|
        lambda { |arg|
          functions.inject(arg) do |acc, function|
            function.call(acc)
          end
        }
      }
    end
  end
end
