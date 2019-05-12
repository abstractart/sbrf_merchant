require 'json/ext'

module SbrfMerchant
  module Utils
    module JSON
      ToObjectParser = lambda { |object_class|
        lambda { |json|
          ::JSON.parse(json, object_class: object_class)
        }
      }
    end
  end
end
