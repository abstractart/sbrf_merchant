# frozen_string_literal: true

require 'plissken'

module SbrfMerchant
  module Utils
    module Hash
      class ToSnakeCaseKeys
        def call(hash)
          hash.to_snake_keys
        end
      end
    end
  end
end
