require 'sbrf_merchant/api/client'

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

    def initialize(host: nil, user_name: nil, password: nil)
      @host = host
      @user_name = user_name
      @password = password
    end
  end
end

Sberbank = SbrfMerchant
SBRF = SbrfMerchant
