require "sberbank_merchant_api/version"
require "sberbank_merchant_api/sberbank_api"

module SberbankMerchantApi
  class << self
    attr_accessor :configuration
    attr_accessor :api
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.api = SberbankAPI.new(configuration)
  end

  class Configuration
    attr_accessor :api_host, :login, :password

    def initialize
      @api_host = @login = @password = ''
    end
  end
end
