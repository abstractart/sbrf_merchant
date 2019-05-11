require 'json/ext'

module SbrfMerchant
  module Utils
    module JSON
      Parser = lambda do |json|
        ::JSON.parse(json, symbolize_names: true)
      end
    end
  end
end
