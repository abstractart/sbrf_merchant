RSpec.describe SbrfMerchant do
  let(:user_name) { 'user_name' }
  let(:password) { 'password' }
  let(:host) { 'http://localhost:3000' }

  describe '#configure' do
    let(:config) { SbrfMerchant.configuration }
    it do
      SbrfMerchant.configure do |config|
        config.user_name = user_name
        config.password = password
        config.host = host
      end

      expect(config.user_name).to eq(user_name)
      expect(config.password).to eq(password)
      expect(config.host).to eq(host)
    end
  end
end
