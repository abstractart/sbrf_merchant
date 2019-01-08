require 'sbrf_merchant/order'

module SbrfMerchant
  class << self
    attr_accessor :configuration
  end

  def self.api_client
    SbrfMerchant::Api::Client.new(
      host: SbrfMerchant.configuration.host,
      userName: SbrfMerchant.configuration.userName,
      password: SbrfMerchant.configuration.password
    )
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :host, :userName, :password
  end
end
