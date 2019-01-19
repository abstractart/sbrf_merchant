RSpec.describe SbrfMerchant::Response::Base do
  let(:data) { { errorCode: "0", errorMessage: "" } }
  let(:response) { described_class.new(data) }

  it "should raise when hash dont exists key" do
    expect{response.non_existent_message}.to raise_error(NameError)
  end

  it "should respond_to hash keys in snake_case" do
    expect(response.respond_to?(:error_message)).to be true
    expect(response.respond_to?(:error_code)).to be true
    expect(response.respond_to?(:non_existent_message)).to be false
  end
end
