require 'plissken'

module SbrfMerchant
  module Utils
    module Hash
      ToSnakeCaseKeys = ->(hash) { hash.to_snake_keys }
    end
  end
end
