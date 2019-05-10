require 'sbrf_merchant/order'

module SbrfMerchant
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :host, :user_name, :password

    def initialize(host:, user_name:, password:)
      @host = host
      @user_name = user_name
      @password = password
    end
  end
end

Sberbank = SbrfMerchant
SBRF = SbrfMerchant
