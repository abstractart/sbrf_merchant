require 'plissken'

module SbrfMerchant
  module Utils
    module Hash
      ToSnakeCaseKeys = lambda do |hash|
        hash.to_snake_keys
      end
    end
  end
end
