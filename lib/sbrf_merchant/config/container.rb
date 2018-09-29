require 'dry-container'

module SbrfMerchant
  module Config
    class Container
      extend Dry::Container::Mixin

      register 'api_client' do
        SbrfMerchant::Api::Client.new(
          host: SbrfMerchant.configuration.host,
          userName: SbrfMerchant.configuration.userName,
          password: SbrfMerchant.configuration.password
        )
      end
    end
  end
end
