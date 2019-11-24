# frozen_string_literal: true

module SbrfMerchant
  module Api
    module Response
      class AppendSuccessFlagToHash
        def call(hash)
          hash.merge('success?' => success?(hash))
        end

        private

        # Ответ считается успешным когда errorCode == '0' но есть ньюанс,
        # В успешном ответе на запрос register errorCode отсутствует,
        # поэтому проверяем по параметру formUrl
        def success?(hash)
          !hash['formUrl'].nil? || hash['errorCode'] == '0'
        end
      end
    end
  end
end
