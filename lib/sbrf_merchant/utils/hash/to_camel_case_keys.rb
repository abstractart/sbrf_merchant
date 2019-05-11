require 'awrence'

module SbrfMerchant
  module Utils
    module Hash
      ToCamelCaseKeys = lambda do |hash|
        hash.to_camelback_keys
      end
    end
  end
end
