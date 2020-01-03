# frozen_string_literal: true

require 'json/ext'

module SbrfMerchant
  module Utils
    module JSON
      class ToHashParser
        def call(json)
          ::JSON.parse(json, symbolize_names: true)
        end
      end
    end
  end
end
