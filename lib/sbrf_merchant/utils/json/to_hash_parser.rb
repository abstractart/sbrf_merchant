# frozen_string_literal: true

require 'json/ext'

module SbrfMerchant
  module Utils
    module JSON
      ToHashParser = ->(json) { ::JSON.parse(json) }
    end
  end
end
