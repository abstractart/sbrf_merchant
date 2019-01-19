require 'sbrf_merchant/order'

module SbrfMerchant
  class << self
    attr_accessor :configuration
  end

  def self.api_client
    SbrfMerchant::Api::Client.new(
      host: SbrfMerchant.configuration.host,
      user_name: SbrfMerchant.configuration.user_name,
      password: SbrfMerchant.configuration.password
    )
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :host, :user_name, :password
  end
end

Sberbank = SbrfMerchant
SBRF = SbrfMerchant
