# frozen_string_literal: true

module SbrfMerchant
  module Api
    module Response
      AppendSuccessFlagToHash = lambda do |hash|
        hash.merge('success?' => IsSuccess.call(hash))
      end

      IsSuccess = lambda do |hash|
        !hash['formUrl'].nil? || hash['errorCode'] == '0'
      end
    end
  end
end
