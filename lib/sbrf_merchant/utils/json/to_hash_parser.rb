require 'json/ext'

module SbrfMerchant
  module Utils
    module JSON
      ToHashParser = ->(json) { ::JSON.parse(json, symbolize_names: true) }
    end
  end
end
