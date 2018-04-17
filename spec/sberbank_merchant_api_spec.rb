RSpec.describe SberbankMerchantApi do
  it "has a version number" do
    expect(SberbankMerchantApi::VERSION).not_to be nil
  end

  it "does something useful" do
    SberbankMerchantApi.configure do |config|
      config.api_host = 'sbrf.ru'
      config.login = 'sbrf.ru'
      config.password = 'sbrf.ru'
    end
    expect(SberbankMerchantApi.configuration.api_host).to eq('sbrf.ru')
    expect(SberbankMerchantApi.configuration.login).to eq('sbrf.ru')
    expect(SberbankMerchantApi.configuration.password).to eq('sbrf.ru')

    expect(SberbankMerchantApi.api).not_to be nil
  end
end
