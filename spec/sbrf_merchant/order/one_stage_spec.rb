RSpec.describe SbrfMerchant::Order::OneStage do
  let(:orderNumber) { 'orderNumber' }

  context '#register' do
    include_context 'API Client Register Order Stub'

    let(:payment) do
      described_class.new(
        orderNumber: orderNumber,
        api_client: api_client
      )
    end
    let(:actual_response) do
      payment.register(
        amount: amount,
        returnUrl: returnUrl
      )
    end

    it 'returns orderId & payment formURL' do
      expect(actual_response).to be_success
      expect(actual_response.orderId).to eq(orderId)
      expect(actual_response.formUrl).to eq(formUrl)
      expect(payment.orderId).to eq(orderId)
    end
  end

  context '#refund' do
    include_context 'API Client Refund Order Stub'

    let(:payment) do
      described_class.new(
        orderNumber: orderNumber,
        api_client: api_client,
        orderId: orderId
      )
    end
    let(:actual_response) { payment.refund(amount) }

    it 'returns errorCode & errorMessage' do
      expect(actual_response).to be_success
      expect(actual_response.errorCode).to eq(errorCode)
      expect(actual_response.errorMessage).to eq(errorMessage)
    end
  end

  context '#get_info' do
    include_context 'API Client Order Status Stub'

    let(:payment) do
      described_class.new(
        orderNumber: orderNumber,
        api_client: api_client,
        orderId: orderId
      )
    end
    let(:actual_response) { payment.get_info }

    it 'returns errorCode & errorMessage' do
      expect(actual_response).to be_success
      expect(actual_response).to be_not_paid
      expect(actual_response.errorCode).to eq(errorCode)
      expect(actual_response.errorMessage).to eq(errorMessage)
    end
  end

  context '#new' do
    let(:orderId) { 'orderId' }
    let(:orderNumber) { 'orderNumber' }

    let(:payment) do
      described_class.new(
        orderNumber: orderNumber,
        orderId: orderId,
        api_client: OpenStruct.new
      )
    end

    it 'assigns orderId and orderNumber' do
      expect(payment.orderId).to eq(orderId)
      expect(payment.orderNumber).to eq(orderNumber)
    end
  end
end
