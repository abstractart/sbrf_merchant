# frozen_string_literal: true

require 'awrence'

module SbrfMerchant
  module Utils
    module Hash
      class ToCamelCaseKeys
        def call(hash)
          hash.to_camelback_keys
        end
      end
    end
  end
end
