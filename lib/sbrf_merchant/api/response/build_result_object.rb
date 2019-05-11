require 'ostruct'

module SbrfMerchant
  module Api
    module Response
      BuildResultObject = lambda do |hash|
        attributes = hash.merge(success?: IsSuccess.call(hash))
        OpenStruct.new(attributes).freeze
      end

      IsSuccess = lambda do |hash|
        !hash[:form_url].nil? || hash[:error_code] == '0'
      end
    end
  end
end
