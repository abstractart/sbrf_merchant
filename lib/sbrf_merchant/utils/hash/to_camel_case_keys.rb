require 'awrence'

module SbrfMerchant
  module Utils
    module Hash
      ToCamelCaseKeys = ->(hash) { hash.to_camelback_keys }
    end
  end
end
