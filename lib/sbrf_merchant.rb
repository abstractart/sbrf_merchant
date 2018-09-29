require 'sbrf_merchant/order/one_stage'

module SbrfMerchant
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :host, :userName, :password
  end
end
